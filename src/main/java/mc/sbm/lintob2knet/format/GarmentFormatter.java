
package mc.sbm.lintob2knet.format;

import mc.sbm.lintob2knet.model.GarmentTransaction;

public class GarmentFormatter {
    public static String format(GarmentTransaction t) {
        return fix(t.getId(), 3) +
            fix(t.getChipCode(), 24) +
            fix(t.getBarcode() == null ? "" : t.getBarcode(), 24) +
            fix(t.getItemCode(), 12) +
            fix(t.getSizeCode(), 12) +
            fix(t.getPersonalNumber(), 12) +
            fix(t.getClient(), 12) +
            fix(t.getConveyor(), 2) +
            fix(t.getStoragesGroup(), 10);
    }
    private static String fix(String s,int len){ if (s==null) s=""; if (s.length()>len) return s.substring(0,len); return String.format("%-"+len+"s", s); }
}
