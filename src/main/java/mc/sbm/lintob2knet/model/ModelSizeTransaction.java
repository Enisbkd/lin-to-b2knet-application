
package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.*;

// ===== TRANSACTION 300/301: Model Sizes =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ModelSizeTransaction {
    @NotBlank
    @Pattern(regexp = "^30[01]$", message = "Id must be 300 or 301")
    private String id;

    @NotBlank(message = "Model code is required")
    private String modelCode;

    @NotBlank(message = "Size code is required")
    private String sizeCode;

    @NotBlank(message = "Size description is required")
    private String sizeDescription;

    private String sizeSet;

    @Pattern(regexp = "^\\d{0,5}$", message = "Order position must be up to 5 digits")
    private String orderPosition;
}
