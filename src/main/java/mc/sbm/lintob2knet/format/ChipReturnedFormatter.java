
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.ChipReturnedTransaction;

public class ChipReturnedFormatter {
    public static String format(ChipReturnedTransaction t) {
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(), 3));
        sb.append(fix(t.getChipCode(), 24));
        return sb.toString();
    }

    private static String fix(String s, int len) {
        if (s == null) s = "";
        if (s.length() > len) return s.substring(0, len);
        return String.format("%-" + len + "s", s);
    }
}
