package mc.sbm.lintob2knet.streams;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;
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

        valueSerde.configure(
            Map.of(
                JsonDeserializer.TRUSTED_PACKAGES,
                "*",
                JsonDeserializer.USE_TYPE_INFO_HEADERS,
                false,
                JsonDeserializer.VALUE_DEFAULT_TYPE,
                GenericImportEvent.class.getName(),
                JsonDeserializer.REMOVE_TYPE_INFO_HEADERS,
                false
            ),
            false
        );

        String rawTopic = streamInfo.getRawTopic(conveyor, topicConfig.getEnv());
        String formattedTopic = topicConfig.buildFormattedTopic(conveyor);

        builder
            .stream(rawTopic, Consumed.with(Serdes.String(), valueSerde))
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

    /**
     * Builds a formatting stream that reads from the general topic,
     * routes by payload id, formats, and writes to the formatted topic.
     * Reads from: data-lin-general-{conveyor}-{env}
     * Writes to:  data-lin-{conveyor}-{env}
     */
    public void buildFormattingStream(StreamsBuilder builder, String conveyor, Map<String, B2KStream> streamRegistry) {
        JsonSerde<GenericImportEvent> valueSerde = new JsonSerde<>(GenericImportEvent.class, objectMapper);

        valueSerde.configure(
            Map.of(
                JsonDeserializer.TRUSTED_PACKAGES,
                "*",
                JsonDeserializer.USE_TYPE_INFO_HEADERS,
                false,
                JsonDeserializer.VALUE_DEFAULT_TYPE,
                GenericImportEvent.class.getName(),
                JsonDeserializer.REMOVE_TYPE_INFO_HEADERS,
                false
            ),
            false
        );

        String generalTopic = topicConfig.buildGeneralTopic(conveyor);
        String formattedTopic = topicConfig.buildFormattedTopic(conveyor);

        builder
            .stream(generalTopic, Consumed.with(Serdes.String(), valueSerde))
            .mapValues((readOnlyKey, event) -> {
                if (event == null || event.getPayload() == null) {
                    throw new IllegalStateException("Received null event or payload for key: " + readOnlyKey);
                }

                String txCode = event.getTransactionCode();
                // Look up the stream info based on the payload id/type
                String payloadId = extractPayloadId(event);
                B2KStream streamInfo = streamRegistry.get(payloadId);

                if (streamInfo == null) {
                    throw new IllegalStateException("No stream registered for payload id: " + payloadId);
                }

                Object value = objectMapper.convertValue(event.getPayload(), streamInfo.clazz);

                if (txCode == null || txCode.isEmpty() || !streamInfo.supportsTransactionCode(txCode)) {
                    txCode = streamInfo.insertUpdateCode;
                }

                return router.format(txCode, value);
            })
            .to(formattedTopic, Produced.with(Serdes.String(), Serdes.String()));
    }

    /**
     * Extracts the payload identifier from the event to determine
     * which formatter/stream info to use.
     */
    private String extractPayloadId(GenericImportEvent event) {
        // Use the transactionCode set by the controller — it's the canonical routing key
        if (event.getTransactionCode() != null && !event.getTransactionCode().isEmpty()) {
            return event.getTransactionCode();
        }
        // Fallback: extract "id" from payload map
        if (event.getPayload() instanceof Map) {
            Object id = ((Map<?, ?>) event.getPayload()).get("id");
            return id != null ? id.toString() : "unknown";
        }
        return "unknown";
    }
}
