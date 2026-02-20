package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 200/201: User Categories =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryTransaction {
    @NotBlank
    @Pattern(regexp = "^20[01]$", message = "Id must be 200 or 201")
    private String id;

    @NotBlank(message = "Category code is required")
    private String categoryCode;

    @NotBlank(message = "Category description is required")
    private String categoryDescription;

    private String itemCode;

    @Pattern(regexp = "^\\d{0,2}$", message = "Daily credit must be up to 2 digits")
    private String dailyCredit;

    @Pattern(regexp = "^\\d{0,2}$", message = "Weekly credit must be up to 2 digits")
    private String weeklyCredit;

    @Pattern(regexp = "^0?$", message = "Dotation type must be 0")
    private String dotationType;
}
