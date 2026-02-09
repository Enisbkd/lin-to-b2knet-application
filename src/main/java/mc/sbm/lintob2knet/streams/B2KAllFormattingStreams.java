package mc.sbm.lintob2knet.streams;

import mc.sbm.lintob2knet.model.*;
import org.apache.kafka.streams.StreamsBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class B2KAllFormattingStreams {

    private final B2KFormattingStreamFactory factory;

    public B2KAllFormattingStreams(B2KFormattingStreamFactory factory) {
        this.factory = factory;
    }

    @Autowired
    public void buildPipeline(StreamsBuilder builder) {
        // Build streams for HP conveyor
        factory.buildFormattingStream(builder, B2KStream.MODELS, "hp", ModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.SIZES, "hp", SizeTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USERS, "hp", UserTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USER_MODELS, "hp", UserModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.GARMENTS, "hp", GarmentTransaction.class);

        // Build streams for ONE conveyor
        factory.buildFormattingStream(builder, B2KStream.MODELS, "one", ModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.SIZES, "one", SizeTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USERS, "one", UserTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.USER_MODELS, "one", UserModelTransaction.class);
        factory.buildFormattingStream(builder, B2KStream.GARMENTS, "one", GarmentTransaction.class);
    }
}
