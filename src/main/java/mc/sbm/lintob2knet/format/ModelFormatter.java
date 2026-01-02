
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.ModelTransaction;

public class ModelFormatter {
    public static String format(ModelTransaction t) {
        System.out.println("formatting ModelTransaction:" + (t == null ? "null" : t.toString()));
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(), 3)); // Assuming 3 chars for ID
        sb.append(fix(t.getModelCode(), 12));
        sb.append(fix(t.getModelShortDescription(), 30));
        sb.append(fix(t.getModelLongDescription(), 30));
        sb.append(fix(t.getOccupation(), 2));
        sb.append(fix(String.valueOf(t.getFromDate()), 8)); // Assuming DDMMYYYY
        sb.append(fix(String.valueOf(t.getToDate()), 8));   // Assuming DDMMYYYY
        sb.append(fix(t.getHungType(), 2));
        sb.append(fix(t.getModelType(), 2));

        return sb.toString();
    }

    private static String fix(String s, int len) {
        if (s == null) s = "";
        if (s.length() > len) return s.substring(0, len);
        return String.format("%-" + len + "s", s);
    }
}
