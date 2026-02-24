
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.ModelTransaction;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

public class ModelFormatter {
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("ddMMyyyy");

    public static String format(ModelTransaction t) {
        System.out.println("formatting ModelTransaction:" + (t == null ? "null" : t.toString()));

        return fix(Objects.requireNonNull(t).getId(), 3) + // Assuming 3 chars for ID
            fix(t.getModelCode(), 12) +
            fix(t.getModelShortDescription(), 30) +
            fix(t.getModelLongDescription(), 30) +
            fix(t.getOccupation(), 2) +
            fix(formatDate(t.getFromDate()), 8) + // Format as DDMMYYYY
            fix(formatDate(t.getToDate()), 8) +   // Format as DDMMYYYY
            fix(t.getHungType(), 2) +
            fix(t.getModelType(), 2);
    }

    /**
     * Formats LocalDate to ddMMyyyy format, returns empty string if null
     */
    private static String formatDate(LocalDate date) {
        return date == null ? "" : date.format(DATE_FORMATTER);
    }

    private static String fix(String s, int len) {
        if (s == null) s = "";
        if (s.length() > len) return s.substring(0, len);
        return String.format("%" + len + "s", s);
    }
}
