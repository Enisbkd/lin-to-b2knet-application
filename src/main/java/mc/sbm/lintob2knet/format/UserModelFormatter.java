package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.UserModelTransaction;

public class UserModelFormatter {
    public static String format(UserModelTransaction t) {
        String sb = fix(t.getId(), 3) +
            fix(t.getUserNumber(), 12) +
            fix(t.getItemCode(), 30) +
            fix(t.getSizeCode(), 30) +
            fix(t.getCreditsDirtyBin(), 30) +
            fix(t.getWeeklyCredits(), 30) +
            fix(t.getType(), 30) +
            fix(t.getOperationFlag(), 30);
        return sb;
    }

    private static String fix(String s, int len) {
        if (s == null) s = "";
        if (s.length() > len) return s.substring(0, len);
        return String.format("%-" + len + "s", s);
    }
}
