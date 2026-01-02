package mc.sbm.lintob2knet.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

// ===== TRANSACTION 100/101: Models (Articles) =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ModelTransaction {
    @NotBlank
    @Pattern(regexp = "^10[01]$", message = "Id must be 100 or 101")
    private String id;

    @NotBlank(message = "Model code is required")
    private String modelCode;

    @NotBlank(message = "Short description is required")
    private String modelShortDescription;

    private String modelLongDescription;

    @Pattern(regexp = "^[12]$", message = "Occupation must be 1 or 2")
    private String occupation;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate fromDate;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate toDate;

    @Pattern(regexp = "^[0-2]$", message = "Hung type must be 0, 1, or 2")
    private String hungType;

    @Pattern(regexp = "^[0-2]$", message = "Model type must be 0, 1, or 2")
    private String modelType;
}
