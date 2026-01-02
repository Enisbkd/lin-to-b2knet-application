package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
// ===== TRANSACTION 110/111: Models/Storages Relation =====

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ModelStorageTransaction {
    @NotBlank
    @Pattern(regexp = "^11[01]$", message = "Id must be 110 or 111")
    private String id;

    @NotBlank(message = "Model code is required")
    private String modelCode;

    @Pattern(regexp = "^[01]$", message = "Model use must be 0 or 1")
    private String modelUse;

    @Pattern(regexp = "^\\d{2}$", message = "Conveyor code must be 2 digits")
    private String conveyorCode;
}
