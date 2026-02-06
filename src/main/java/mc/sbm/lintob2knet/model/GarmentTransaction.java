
package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 500/501:Transponder Chips =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GarmentTransaction {
    @NotBlank
    @Pattern(regexp = "^50[01]$", message = "Id must be 500 or 501")
    private String id;

    @NotBlank(message = "Chip code is required")
    private String chipCode;

    private String barcode;

    @NotBlank(message = "Item code is required")
    private String itemCode;

    private String sizeCode;

    private String personalNumber;

    private String client;

    @Pattern(regexp = "^\\d{0,2}$", message = "Conveyor must be up to 2 digits")
    private String conveyor;

    private String storagesGroup;
}
