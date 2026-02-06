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
        // Transaction 100/101: Models (Articles)
        factory.buildFormattingStream(builder, B2KStream.MODELS, ModelTransaction.class);

        // Transaction 110/111: Model-Storage Relations
        factory.buildFormattingStream(builder, B2KStream.MODEL_STORAGES, ModelStorageTransaction.class);

        // Transaction 200/201: User Categories
        factory.buildFormattingStream(builder, B2KStream.CATEGORIES, CategoryTransaction.class);

        // Transaction 210/211: Category-Model Relations
        factory.buildFormattingStream(builder, B2KStream.CATEGORY_MODELS, CategoryModelTransaction.class);

        // Transaction 300/301: Model Sizes
        factory.buildFormattingStream(builder, B2KStream.SIZES, ModelSizeTransaction.class);

        // Transaction 400/401: Users/Clients
        factory.buildFormattingStream(builder, B2KStream.CLIENTS, UserTransaction.class);

        // Transaction 410/411: User-Conveyor Relations
        factory.buildFormattingStream(builder, B2KStream.USER_CONVEYORS, UserConveyorTransaction.class);

        // Transaction 420/421: Category-User Relations
        factory.buildFormattingStream(builder, B2KStream.CATEGORY_USERS, CategoryUserTransaction.class);

        // Transaction 500/501: Garments/Chips
        factory.buildFormattingStream(builder, B2KStream.GARMENTS, GarmentTransaction.class);

        // Transaction 520: Chip Returns
        factory.buildFormattingStream(builder, B2KStream.CHIP_RETURNS, ChipReturnedTransaction.class);

        // Transaction 600/601: User-Model Relations
        factory.buildFormattingStream(builder, B2KStream.USER_MODELS, UserModelTransaction.class);

        // Transaction 900/901: User Functions
        factory.buildFormattingStream(builder, B2KStream.FUNCTIONS, UserFunctionTransaction.class);

        // CSV: Employees
        factory.buildFormattingStream(builder, B2KStream.EMPLOYEES, EmployeeTransaction.class);
    }
}
