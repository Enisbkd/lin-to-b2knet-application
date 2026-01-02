
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
        } else if (payload instanceof ModelSizeTransaction sizeTx) {
            if ("300".equals(transactionCode) || "301".equals(transactionCode)) {
                return ModelSizeFormatter.format(sizeTx);
            }
        } else if (payload instanceof UserTransaction clientTx) {
            if ("400".equals(transactionCode) || "401".equals(transactionCode)) {
                return ClientFormatter.format(clientTx);
            }
        } else if (payload instanceof ChipReturnedTransaction returnTx) {
            if ("520".equals(transactionCode)) {
                return Return520Formatter.format(returnTx);
            }
        } else if (payload instanceof ChipTransaction chipTx) {
            if ("500".equals(transactionCode) || "501".equals(transactionCode)) {
                return ChipFormatter.format(chipTx);
            }
        } else if (payload instanceof UserFunctionTransaction functionTx) {
            if ("900".equals(transactionCode) || "901".equals(transactionCode)) {
                return FunctionFormatter.format(functionTx);
            }
        } else if (payload instanceof EmployeeTransaction functionTx) {
            if ("000".equals(transactionCode)) {
                return EmployeeFormatter.format(functionTx);
            }
        }

        // Log warning for mismatched transaction code and payload type
        System.out.println("WARNING: Transaction code '" + transactionCode +
                "' does not match payload type: " + payload.getClass().getSimpleName());
        return "";
    }
}
