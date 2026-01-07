package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.UserModelTransaction;

public class UserModelFormatter {
    public static String format(UserModelTransaction t) {
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(), 3));
        sb.append(fix(t.getUserNumber(), 12));
        sb.append(fix(t.getItemCode(), 30));
        sb.append(fix(t.getSizeCode(), 30));
        sb.append(fix(t.getCreditsDirtyBin(), 30));
        sb.append(fix(t.getWeeklyCredits(), 30));
        sb.append(fix(t.getType(), 30));
        sb.append(fix(t.getOperationFlag(), 30));
        return sb.toString();
    }

    private static String fix(String s, int len) {
        if (s == null) s = "";
        if (s.length() > len) return s.substring(0, len);
        return String.format("%-" + len + "s", s);
    }
}
