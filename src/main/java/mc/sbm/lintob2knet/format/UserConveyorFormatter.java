//package mc.sbm.lintob2knet.format;
//
//
//public class UserConveyorFormatter {
//    public static String format(UserConveyorTransaction t) {
//        StringBuilder sb = new StringBuilder();
//        sb.append(fix(t.getId(), 3));
//        sb.append(fix(t.getUserNumber(), 12));
//        sb.append(fix(t.getConveyorCode(), 2));
//        sb.append(fix(t.getGateCode(), 2));
//        sb.append(fix(t.getPrimary(), 1));
//        sb.append(fix(t.getAssignSlot(), 1));
//        return sb.toString();
//    }
//
//    private static String fix(String s, int len) {
//        if (s == null) s = "";
//        if (s.length() > len) return s.substring(0, len);
//        return String.format("%-" + len + "s", s);
//    }
//}
//
//
