package mc.sbm.lintob2knet.streams;

import java.util.Map;
import mc.sbm.lintob2knet.model.*;
import org.apache.kafka.streams.StreamsBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class B2KAllFormattingStreams {

    private final B2KFormattingStreamFactory factory;

    // Registry mapping payload "id" (transaction code) to stream info
    private static final Map<String, B2KStream> STREAM_REGISTRY = Map.ofEntries(
        Map.entry("100", B2KStream.MODELS),
        Map.entry("101", B2KStream.MODELS),
        Map.entry("200", B2KStream.CATEGORIES), // add CATEGORIES to B2KStream if missing
        Map.entry("201", B2KStream.CATEGORIES),
        Map.entry("300", B2KStream.SIZES),
        Map.entry("301", B2KStream.SIZES),
        Map.entry("400", B2KStream.USERS),
        Map.entry("401", B2KStream.USERS),
        Map.entry("500", B2KStream.GARMENTS),
        Map.entry("501", B2KStream.GARMENTS),
        Map.entry("600", B2KStream.USER_MODELS),
        Map.entry("601", B2KStream.USER_MODELS)
    );

    public B2KAllFormattingStreams(B2KFormattingStreamFactory factory) {
        this.factory = factory;
    }

    @Autowired
    public void buildPipeline(StreamsBuilder builder) {
        // Build streams for HP conveyor (per-entity raw topics)
        factory.buildFormattingStream(builder, B2KStream.MODELS, "hp", ModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.SIZES, "hp", SizeTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USERS, "hp", UserTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USER_MODELS, "hp", UserModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.GARMENTS, "hp", GarmentTransaction.class);

        // Build streams for ONE conveyor (per-entity raw topics)
        factory.buildFormattingStream(builder, B2KStream.MODELS, "one", ModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.SIZES, "one", SizeTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USERS, "one", UserTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USER_MODELS, "one", UserModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.GARMENTS, "one", GarmentTransaction.class);

        // Build general-topic streams (controllers send to general topic)
        factory.buildFormattingStream(builder, "hp", STREAM_REGISTRY);
        factory.buildFormattingStream(builder, "one", STREAM_REGISTRY);
    }
}
