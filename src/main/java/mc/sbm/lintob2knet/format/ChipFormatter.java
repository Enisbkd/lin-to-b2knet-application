
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.ChipTransaction;

public class ChipFormatter {
    public static String format(ChipTransaction t) {
        StringBuilder sb = new StringBuilder();
        sb.append(fix(t.getId(),3));
        sb.append(fix(t.getChipCode(),24));
        sb.append(fix(t.getBarcode(),24));
        sb.append(fix(t.getItemCode(),12));
        sb.append(fix(t.getSizeCode(),12));
        sb.append(fix(t.getPersonalNumber(),12));
        sb.append(fix(t.getClient(),12));
        sb.append(fix(t.getConveyor(),2));
        sb.append(fix(t.getStoragesGroup(),10));
        return sb.toString();
    }
    private static String fix(String s,int len){ if (s==null) s=""; if (s.length()>len) return s.substring(0,len); return String.format("%-"+len+"s", s); }
}
