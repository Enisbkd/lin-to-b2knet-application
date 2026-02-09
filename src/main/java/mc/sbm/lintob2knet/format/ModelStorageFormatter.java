//package mc.sbm.lintob2knet.format;
//
//public class ModelStorageFormatter {
//
//    public static String format(ModelStorageTransaction t) {
//        StringBuilder sb = new StringBuilder();
//        sb.append(fix(t.getId(), 3));
//        sb.append(fix(t.getModelCode(), 12));
//        sb.append(fix(t.getModelUse(), 1));
//        sb.append(fix(t.getConveyorCode(), 2));
//        return sb.toString();
//    }
//
//    private static String fix(String s, int len) {
//        if (s == null) s = "";
//        if (s.length() > len) return s.substring(0, len);
//        return String.format("%-" + len + "s", s);
//    }
//}
