package mc.sbm.lintob2knet.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 900/901: User Functions =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserFunctionTransaction {
    @NotBlank
    @Pattern(regexp = "^90[01]$", message = "Id must be 900 or 901")
    private String id;

    @NotBlank(message = "Function code is required")
    private String functionCode;

    @NotBlank(message = "Function description is required")
    private String functionDescription;
}
