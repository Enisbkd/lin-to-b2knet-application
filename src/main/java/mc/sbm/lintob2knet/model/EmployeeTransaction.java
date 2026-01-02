package mc.sbm.lintob2knet.model;


import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
// ===== CSV Employee Transaction  =====

public class EmployeeTransaction {

    @NotBlank(message = "Employee code is required")
    private String code;

    private String cardCode;

    @NotBlank(message = "Last name is required")
    private String lastName;

    @NotBlank(message = "First name is required")
    private String firstName;

    private String categoryCode;

    private String categoryDescription;

    private String functionCode;

    private String functionDescription;

    private String shiftCode;

    private String shiftDescription;

    @Pattern(regexp = "^[MF]$", message = "Gender must be M or F")
    private String gender;

    @Pattern(regexp = "^[a-z]{2}-[A-Z]{2}$", message = "Language must be in format xx-XX (e.g., en-US)")
    private String language;

    @Pattern(regexp = "^[0-2]$", message = "Change size must be 0, 1, or 2")
    private String changeSize;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate contractStart;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate contractEnd;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate disableDate;

    @Pattern(regexp = "^\\d{2}$", message = "Conveyor code must be 2 digits")
    private String mag;

    @Pattern(regexp = "^[01]$", message = "Primary mag must be 0 or 1")
    private String primaryMag;
}
