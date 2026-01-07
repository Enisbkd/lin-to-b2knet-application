package mc.sbm.lintob2knet.streams;

import mc.sbm.lintob2knet.model.*;

public enum B2KStream {
    MODELS("data-lin-models-raw-one-", "data-lin-models-formatted-one-", ModelTransaction.class, "100", "101"),
    MODEL_STORAGES("data-lin-modelstorages-raw-one-", "data-lin-modelstorages-formatted-one-", ModelStorageTransaction.class, "110", "111"),
    CATEGORIES("data-lin-categories-raw-one-", "data-lin-categories-formatted-one-", CategoryTransaction.class, "200", "201"),
    CATEGORY_MODELS("data-lin-categorymodels-raw-one-", "data-lin-categorymodels-formatted-one-", CategoryModelTransaction.class, "210", "211"),
    SIZES("data-lin-sizes-raw-one-", "data-lin-sizes-formatted-one-", ModelSizeTransaction.class, "300", "301"),
    CLIENTS("data-lin-clients-raw-one-", "data-lin-clients-formatted-one-", UserTransaction.class, "400", "401"),
    USER_CONVEYORS("data-lin-userconveyors-raw-one-", "data-lin-userconveyors-formatted-one-", UserConveyorTransaction.class, "410", "411"),
    CATEGORY_USERS("data-lin-categoryusers-raw-one-", "data-lin-categoryusers-formatted-one-", CategoryUserTransaction.class, "420", "421"),
    CHIPS("data-lin-chips-raw-one-", "data-lin-chips-formatted-one-", ChipTransaction.class, "500", "501"),
    CHIP_RETURNS("data-lin-garmentreturns-raw-one-", "data-lin-garmentreturns-formatted-one-", ChipReturnedTransaction.class, "520", null),
    USER_MODELS("data-lin-usermodels-raw-one-", "data-lin-usermodels-formatted-one-", UserModelTransaction.class, "600", "601"),
    FUNCTIONS("data-lin-functions-raw-one-", "data-lin-functions-formatted-one-", UserFunctionTransaction.class, "900", "901"),
    EMPLOYEES("data-lin-employees-raw-one-", "data-lin-employees-formatted-one-", EmployeeTransaction.class, "000", null);

    public final String rawTopicPrefix;
    public final String formattedTopicPrefix;
    public final Class<?> clazz;
    public final String insertUpdateCode;
    public final String deleteCode;

    B2KStream(String rawTopicPrefix, String formattedTopicPrefix, Class<?> clazz, String insertUpdateCode, String deleteCode) {
        this.rawTopicPrefix = rawTopicPrefix;
        this.formattedTopicPrefix = formattedTopicPrefix;
        this.clazz = clazz;
        this.insertUpdateCode = insertUpdateCode;
        this.deleteCode = deleteCode;
    }

    public String getRawTopic(String env) {
        return rawTopicPrefix + env;
    }

    public String getFormattedTopic(String env) {
        return formattedTopicPrefix + env;
    }

    /**
     * Check if this stream supports the given transaction code
     */
    public boolean supportsTransactionCode(String code) {
        return (insertUpdateCode != null && insertUpdateCode.equals(code)) ||
                (deleteCode != null && deleteCode.equals(code));
    }

    /**
     * Determine if the transaction code is a delete operation
     */
    public boolean isDeleteOperation(String code) {
        return deleteCode != null && deleteCode.equals(code);
    }

    /**
     * Determine if the transaction code is an insert/update operation
     */
    public boolean isInsertUpdateOperation(String code) {
        return insertUpdateCode != null && insertUpdateCode.equals(code);
    }

    /**
     * Find the B2KStream enum by transaction code
     */
    public static B2KStream fromTransactionCode(String code) {
        if (code == null) {
            return null;
        }
        for (B2KStream stream : values()) {
            if (stream.supportsTransactionCode(code)) {
                return stream;
            }
        }
        return null;
    }

    /**
     * Get all transaction codes for this stream
     */
    public String[] getTransactionCodes() {
        if (deleteCode == null) {
            return new String[]{insertUpdateCode};
        }
        return new String[]{insertUpdateCode, deleteCode};
    }
}
