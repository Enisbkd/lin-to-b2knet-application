
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.ModelTransaction;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class ModelFormatter {
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("ddMMyyyy");

    public static String format(ModelTransaction t) {
        System.out.println("formatting ModelTransaction:" + (t == null ? "null" : t.toString()));
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(), 3)); // Assuming 3 chars for ID
        sb.append(fix(t.getModelCode(), 12));
        sb.append(fix(t.getModelShortDescription(), 30));
        sb.append(fix(t.getModelLongDescription(), 30));
        sb.append(fix(t.getOccupation(), 2));
        sb.append(fix(formatDate(t.getFromDate()), 8)); // Format as DDMMYYYY
        sb.append(fix(formatDate(t.getToDate()), 8));   // Format as DDMMYYYY
        sb.append(fix(t.getHungType(), 2));
        sb.append(fix(t.getModelType(), 2));

        return sb.toString();
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
