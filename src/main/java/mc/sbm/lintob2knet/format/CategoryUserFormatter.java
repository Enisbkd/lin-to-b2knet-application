package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.CategoryUserTransaction;
import mc.sbm.lintob2knet.model.ModelStorageTransaction;

public class CategoryUserFormatter {

    public static String format(CategoryUserTransaction t) {
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(), 3));
        sb.append(fix(t.getUserNumber(), 12));
        sb.append(fix(t.getCategoryCode(), 8));
        sb.append(fix(t.getPrimary(), 1));
        sb.append(fix(t.getEnabled(), 1));
        return sb.toString();
    }

    private static String fix(String s, int len) {
        if (s == null) s = "";
        if (s.length() > len) return s.substring(0, len);
        return String.format("%-" + len + "s", s);
    }
}
