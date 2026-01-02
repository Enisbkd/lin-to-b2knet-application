package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 600/601: User-Model Relation =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserModelTransaction {
    @NotBlank
    @Pattern(regexp = "^60[01]$", message = "Id must be 600 or 601")
    private String id;

    @NotBlank(message = "User number is required")
    private String userNumber;

    @NotBlank(message = "Item code is required")
    private String itemCode;

    private String sizeCode;

    @Pattern(regexp = "^\\d{0,2}$", message = "Credits dirty bin must be up to 2 digits")
    private String creditsDirtyBin;

    @Pattern(regexp = "^\\d{0,2}$", message = "Weekly credits must be up to 2 digits")
    private String weeklyCredits;

    @Pattern(regexp = "^[0-2]$", message = "Type must be 0, 1, or 2")
    private String type;

    @Pattern(regexp = "^[01]$", message = "Operation flag must be 0 or 1")
    private String operationFlag;
}
