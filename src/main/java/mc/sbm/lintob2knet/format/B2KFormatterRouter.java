package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.*;
import org.springframework.stereotype.Component;

@Component
public class B2KFormatterRouter {

    public String format(String transactionCode, Object payload) {
        System.out.println("Received payload: " + payload + " with transactionCode: " + transactionCode);
        if (transactionCode == null) {
            throw new IllegalArgumentException("transactionCode missing");
        }

        // Route based on actual payload type first, then validate transaction code
        if (payload instanceof ModelTransaction modelTx) {
            if ("100".equals(transactionCode) || "101".equals(transactionCode)) {
                return ModelFormatter.format(modelTx);
            }
        } else if (payload instanceof CategoryTransaction categoryTx) {
            if ("200".equals(transactionCode) || "201".equals(transactionCode)) {
                return CategoryFormatter.format(categoryTx);
            }
        } else if (payload instanceof SizeTransaction sizeTx) {
            if ("300".equals(transactionCode) || "301".equals(transactionCode)) {
                return SizeFormatter.format(sizeTx);
            }
        } else if (payload instanceof UserTransaction clientTx) {
            if ("400".equals(transactionCode) || "401".equals(transactionCode)) {
                return UserFormatter.format(clientTx);
            }
        } else if (payload instanceof GarmentTransaction chipTx) {
            if ("500".equals(transactionCode) || "501".equals(transactionCode)) {
                return GarmentFormatter.format(chipTx);
            }
        } else if (payload instanceof UserModelTransaction functionTx) {
            if ("600".equals(transactionCode) || "601".equals(transactionCode)) {
                return UserModelFormatter.format(functionTx);
            }
        }
        //        } else if (payload instanceof ChipReturnedTransaction returnTx) {
        //            if ("520".equals(transactionCode)) {
        //                return ChipReturnedFormatter.format(returnTx);
        //            }
        //        } else if (payload instanceof UserConveyorTransaction categoryTx) {
        //            if ("410".equals(transactionCode) || "411".equals(transactionCode)) {
        //                return UserConveyorFormatter.format(categoryTx);
        //            }
        //        } else if (payload instanceof UserFunctionTransaction functionTx) {
        //            if ("900".equals(transactionCode) || "901".equals(transactionCode)) {
        //                return UserFunctionFormatter.format(functionTx);
        //            }
        //        } else if (payload instanceof EmployeeTransaction functionTx) {
        //            if ("000".equals(transactionCode)) {
        //                return EmployeeFormatter.format(functionTx);
        //            }
        //        } else if (payload instanceof CategoryModelTransaction functionTx) {
        //            if ("210".equals(transactionCode) || "211".equals(transactionCode)) {
        //                return CategoryModelFormatter.format(functionTx);
        //            }
        //        } else if (payload instanceof ModelStorageTransaction functionTx) {
        //            if ("110".equals(transactionCode) || "111".equals(transactionCode)) {
        //                return ModelStorageFormatter.format(functionTx);
        //            }
        //        } else if (payload instanceof CategoryUserTransaction functionTx) {
        //            if ("420".equals(transactionCode) || "421".equals(transactionCode)) {
        //                return CategoryUserFormatter.format(functionTx);
        //            }

        // Log warning for mismatched transaction code and payload type
        System.out.println(
            "WARNING: Transaction code '" + transactionCode + "' does not match payload type: " + payload.getClass().getSimpleName()
        );
        return "";
    }
}
