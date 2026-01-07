
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.UserTransaction;

public class UserFormatter {
    public static String format(UserTransaction t) {
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(),3));
        sb.append(fix(t.getUserNumber(),12));
        sb.append(fix(t.getCard(),24));
        sb.append(fix(t.getSurname(),40));
        sb.append(fix(t.getName(),20));
        sb.append(fix(t.getClientNumber(),12));
        sb.append(fix(t.getFunctionCode(),12));
        sb.append(fix(t.getCostCenter(),12));
        sb.append(fix(String.valueOf(t.getStartDate()),8));
        sb.append(fix(String.valueOf(t.getEndDate()),8));
        sb.append(fix(t.getConveyor(),2));
        sb.append(fix(t.getWeeklyCredit(),2));
        sb.append(fix(t.getCategoryCode(),8));
        sb.append(fix(t.getGender(),1));
        sb.append(fix(t.getLanguage(),6));
        sb.append(fix(t.getMissingSize(),1));
        sb.append(fix(t.getSendMessage(),1));
        sb.append(fix(t.getPhases(),1));
        sb.append(fix(t.getPickUp(),1));
        sb.append(fix(t.getPrimaryConveyor(),2));
        sb.append(fix(String.valueOf(t.getDisableDate()),8));
        sb.append(fix(t.getNewUserCode(),12));
        sb.append(fix(t.getEmail(),50));
        sb.append(fix(t.getWorkShift(),30));
        return sb.toString();
    }
    private static String fix(String s,int len){ if (s==null) s=""; if (s.length()>len) return s.substring(0,len); return String.format("%-"+len+"s", s); }
}
