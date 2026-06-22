package mc.sbm.lintob2knet.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// ===== TRANSACTION 400/401: Users =====
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserTransaction {

    @NotBlank
    @Pattern(regexp = "^40[01]$", message = "Id must be 400 or 401")
    private String id;

    @NotBlank(message = "User number is required")
    private String userNumber;

    private String card;

    @NotBlank(message = "Surname is required")
    private String surname;

    @NotBlank(message = "Name is required")
    private String name;

    private String clientNumber;

    private String functionCode;

    private String costCenter;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate startDate;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate endDate;

    private String conveyor;

    @Pattern(regexp = "^\\d{0,2}$", message = "Weekly credit must be up to 2 digits")
    private String weeklyCredit;

    private String categoryCode;

    @Pattern(regexp = "^[MF]$", message = "Gender must be M or F")
    private String gender;

    @Pattern(regexp = "^([a-z]{2}-[A-Z]{2})?$", message = "Language must be in format xx-XX or empty")
    private String language;

    @Pattern(regexp = "^[0-2]?$", message = "Missing size must be 0, 1, 2 or empty")
    private String missingSize;

    @Pattern(regexp = "^[0-2]?$", message = "Send message must be 0, 1, 2 or empty")
    private String sendMessage;

    @Pattern(regexp = "^[01]?$", message = "Phases must be 0, 1 or empty")
    private String phases;

    @Pattern(regexp = "^[01]?$", message = "Pickup must be 0, 1 or empty")
    private String pickUp;

    @Pattern(regexp = "^\\d{0,2}$", message = "Primary conveyor must be up to 2 digits")
    private String primaryConveyor;

    @JsonFormat(pattern = "ddMMyyyy")
    private LocalDate disableDate;

    private String newUserCode;

    private String email;

    private String workShift;
}
