
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.UserFunctionTransaction;

public class FunctionFormatter {
    public static String format(UserFunctionTransaction t) {
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(),3));
        sb.append(fix(t.getFunctionCode(),12));
        sb.append(fix(t.getFunctionDescription(),30));
        return sb.toString();
    }
    private static String fix(String s,int len){ if (s==null) s=""; if (s.length()>len) return s.substring(0,len); return String.format("%-"+len+"s", s); }
}
