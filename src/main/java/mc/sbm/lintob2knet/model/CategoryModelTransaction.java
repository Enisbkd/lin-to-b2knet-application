package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 210/211: Category-Model Relation =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryModelTransaction {
    @NotBlank
    @Pattern(regexp = "^21[01]$", message = "Id must be 210 or 211")
    private String id;

    @NotBlank(message = "Model code is required")
    private String modelCode;

    @NotBlank(message = "Category code is required")
    private String categoryCode;

    @Pattern(regexp = "^\\d{0,2}$", message = "Daily credit must be up to 2 digits")
    private String dailyCredit;

    @Pattern(regexp = "^\\d{0,2}$", message = "Weekly credit must be up to 2 digits")
    private String weeklyCredit;

    @Pattern(regexp = "^[01]$", message = "Dotation type must be 0 or 1")
    private String dotationType;
}
