
package mc.sbm.lintob2knet.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class FileNamingUtils {
    private static final DateTimeFormatter TF = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

    public static String b2kInputFilename(String batchId) {
        String ts = TF.format(LocalDateTime.now());
        return String.format("b2knetIn_%s_batch_%s.txt", ts, batchId);
    }
}
