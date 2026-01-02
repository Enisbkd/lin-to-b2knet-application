package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 420/421: Category-User Relation =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryUserTransaction {
    @NotBlank
    @Pattern(regexp = "^42[01]$", message = "Id must be 420 or 421")
    private String id;

    @NotBlank(message = "User number is required")
    private String userNumber;

    @NotBlank(message = "Category code is required")
    private String categoryCode;

    @Pattern(regexp = "^[01]$", message = "Primary must be 0 or 1")
    private String primary;

    @Pattern(regexp = "^[01]$", message = "Enabled must be 0 or 1")
    private String enabled;
}
