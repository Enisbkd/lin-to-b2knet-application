//
//package mc.sbm.lintob2knet.format;
//
//public class CategoryFormatter {
//    public static String format(CategoryTransaction t) {
//        StringBuilder sb = new StringBuilder();
//        sb.append(fix(t.getId(), 3));
//        sb.append(fix(t.getCategoryCode(), 8));
//        sb.append(fix(t.getCategoryDescription(), 30));
//        sb.append(fix(t.getItemCode(), 12));
//        sb.append(fix(t.getDailyCredit(), 2));
//        sb.append(fix(t.getWeeklyCredit(), 2));
//        sb.append(fix(t.getDotationType(), 2));
//        return sb.toString();
//    }
//
//    private static String fix(String s, int len) {
//        if (s == null) s = "";
//        if (s.length() > len) return s.substring(0, len);
//        return String.format("%-" + len + "s", s);
//    }
//}
