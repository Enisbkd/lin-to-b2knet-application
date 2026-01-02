package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 520: Chips to Set as Returned =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChipReturnedTransaction {
    @NotBlank
    @Pattern(regexp = "^520$", message = "Id must be 520")
    private String id;

    @NotBlank(message = "Chip code is required")
    private String chipCode;
}
