
package mc.sbm.lintob2knet.model;

import lombok.*;

/**
 * Generic wrapper sent by controllers to raw topics.
 */
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GenericImportEvent {
    private String transactionCode; // e.g., "100"
    private Object payload; // actual DTO
}
