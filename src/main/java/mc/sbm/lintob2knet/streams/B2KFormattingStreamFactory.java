package mc.sbm.lintob2knet.streams;

import com.fasterxml.jackson.databind.ObjectMapper;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.format.B2KFormatterRouter;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.kstream.Consumed;
import org.apache.kafka.streams.kstream.Produced;
import org.springframework.kafka.support.serializer.JsonDeserializer;
import org.springframework.kafka.support.serializer.JsonSerde;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class B2KFormattingStreamFactory {

    private final B2KFormatterRouter router;
    private final ObjectMapper objectMapper;
    private final TopicConfig topicConfig;

    public B2KFormattingStreamFactory(B2KFormatterRouter router, ObjectMapper objectMapper, TopicConfig topicConfig) {
        this.router = router;
        this.objectMapper = objectMapper;
        this.topicConfig = topicConfig;
    }

    /**
     * Builds a formatting stream for a specific conveyor and stream type
     * Reads from: data-lin-{entity}-raw-{conveyor}-{env}
     * Writes to: data-lin-{conveyor}-{env}
     */
    public <T> void buildFormattingStream(StreamsBuilder builder, B2KStream streamInfo, String conveyor, Class<T> type) {
        JsonSerde<GenericImportEvent> valueSerde = new JsonSerde<>(GenericImportEvent.class, objectMapper);

        valueSerde.configure(Map.of(
            JsonDeserializer.TRUSTED_PACKAGES, "*",
            JsonDeserializer.USE_TYPE_INFO_HEADERS, false,
            JsonDeserializer.VALUE_DEFAULT_TYPE, GenericImportEvent.class.getName(),
            JsonDeserializer.REMOVE_TYPE_INFO_HEADERS, false
        ), false);

        String rawTopic = streamInfo.getRawTopic(conveyor, topicConfig.getEnv());
        String formattedTopic = topicConfig.buildFormattedTopic(conveyor);

        builder.stream(rawTopic, Consumed.with(Serdes.String(), valueSerde))
            .mapValues((readOnlyKey, event) -> {
                if (event == null || event.getPayload() == null) {
                    throw new IllegalStateException("Received null event or payload for key: " + readOnlyKey);
                }

                T value = objectMapper.convertValue(event.getPayload(), type);

                String txCode = event.getTransactionCode();
                if (txCode == null || txCode.isEmpty() || !streamInfo.supportsTransactionCode(txCode)) {
                    txCode = streamInfo.insertUpdateCode;
                }

                return router.format(txCode, value);
            })
            .to(formattedTopic, Produced.with(Serdes.String(), Serdes.String()));
    }
}
