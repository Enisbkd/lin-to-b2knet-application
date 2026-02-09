
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.UserTransaction;

public class UserFormatter {
    public static String format(UserTransaction t) {
        String sb = fix(t.getId(), 3) +
            fix(t.getUserNumber(), 12) +
            fix(t.getCard(), 24) +
            fix(t.getSurname(), 40) +
            fix(t.getName(), 20) +
            fix(t.getClientNumber(), 12) +
            fix(t.getFunctionCode(), 12) +
            fix(t.getCostCenter(), 12) +
            fix(String.valueOf(t.getStartDate()), 8) +
            fix(String.valueOf(t.getEndDate()), 8) +
            fix(t.getConveyor(), 2) +
            fix(t.getWeeklyCredit(), 2) +
            fix(t.getCategoryCode(), 8) +
            fix(t.getGender(), 1) +
            fix(t.getLanguage(), 6) +
            fix(t.getMissingSize(), 1) +
            fix(t.getSendMessage(), 1) +
            fix(t.getPhases(), 1) +
            fix(t.getPickUp(), 1) +
            fix(t.getPrimaryConveyor(), 2) +
            fix(String.valueOf(t.getDisableDate()), 8) +
            fix(t.getNewUserCode(), 12) +
            fix(t.getEmail(), 50) +
            fix(t.getWorkShift(), 30);
        return sb;
    }
    private static String fix(String s,int len){ if (s==null) s=""; if (s.length()>len) return s.substring(0,len); return String.format("%-"+len+"s", s); }
}
