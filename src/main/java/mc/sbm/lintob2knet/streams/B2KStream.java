package mc.sbm.lintob2knet.streams;

import mc.sbm.lintob2knet.model.*;

public enum B2KStream {
    MODELS("models", ModelTransaction.class, "100", "101"),
    SIZES("sizes", SizeTransaction.class, "300", "301"),
    USERS("users", UserTransaction.class, "400", "401"),
    USER_MODELS("usermodels", UserModelTransaction.class, "600", "601"),
    GARMENTS("garments", GarmentTransaction.class, "500", "501"),
    CATEGORIES("categories", CategoryTransaction.class, "200", "201");

    public final String entityName;
    public final Class<?> clazz;
    public final String insertUpdateCode;
    public final String deleteCode;

    B2KStream(String entityName, Class<?> clazz, String insertUpdateCode, String deleteCode) {
        this.entityName = entityName;
        this.clazz = clazz;
        this.insertUpdateCode = insertUpdateCode;
        this.deleteCode = deleteCode;
    }

    /**
     * Builds raw topic name: data-lin-{entity}-raw-{conveyor}-{env}
     * Example: data-lin-models-raw-hp-dev
     */
    public String getRawTopic(String conveyor, String env) {
        return String.format("data-lin-%s-raw-%s-%s", entityName, conveyor, env);
    }

    /**
     * Builds formatted topic name: data-lin-{conveyor}-{env}
     * Example: data-lin-hp-dev
     */
    public static String getFormattedTopic(String conveyor, String env) {
        return String.format("data-lin-%s-%s", conveyor, env);
    }

    /**
     * Check if this stream supports the given transaction code
     */
    public boolean supportsTransactionCode(String code) {
        return (insertUpdateCode != null && insertUpdateCode.equals(code)) || (deleteCode != null && deleteCode.equals(code));
    }
}
