package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 410/411: User-Conveyor Relation =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserConveyorTransaction {
    @NotBlank
    @Pattern(regexp = "^41[01]$", message = "Id must be 410 or 411")
    private String id;

    @NotBlank(message = "User number is required")
    private String userNumber;

    @NotBlank(message = "Conveyor code is required")
    @Pattern(regexp = "^\\d{2}$", message = "Conveyor code must be 2 digits")
    private String conveyorCode;

    @Pattern(regexp = "^\\d{0,2}$", message = "Gate code must be up to 2 digits")
    private String gateCode;

    @Pattern(regexp = "^[01]$", message = "Primary must be 0 or 1")
    private String primary;

    @Pattern(regexp = "^[01]$", message = "Assign slot must be 0 or 1")
    private String assignSlot;
}
