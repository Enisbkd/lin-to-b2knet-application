
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.ModelSizeTransaction;

public class ModelSizeFormatter {
    public static String format(ModelSizeTransaction t) {
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(), 3));
        sb.append(fix(t.getModelCode(), 12));
        sb.append(fix(t.getSizeCode(), 12));
        sb.append(fix(t.getSizeDescription(), 30));
        sb.append(fix(t.getSizeSet(), 5));
        sb.append(fix(t.getOrderPosition(), 5));
        return sb.toString();
    }

    private static String fix(String s, int len) {
        if (s == null) s = "";
        if (s.length() > len) return s.substring(0, len);
        return String.format("%-" + len + "s", s);
    }
}
