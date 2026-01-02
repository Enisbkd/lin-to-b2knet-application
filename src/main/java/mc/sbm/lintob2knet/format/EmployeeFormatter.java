package mc.sbm.lintob2knet.format;


import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.model.EmployeeTransaction;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@Component
public class EmployeeFormatter {

    private static final String CSV_DELIMITER = ";";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("ddMMyyyy");
    private static final String CSV_HEADER = "Code;CardCode;LastName;FirstName;CategoryCode;CategoryDescription;" +
            "FunctionCode;FunctionDescription;ShiftCode;ShiftDescription;Gender;LANGUAGE;ChangeSize;" +
            "CONTRACTDATESTART;CONTRACTDATEEND;DisableDate;Mag;PrimaryMag";

    /**
     * Formats a single employee to CSV format
     */
    public static String format(EmployeeTransaction employee) {
        return String.join(CSV_DELIMITER,
                safeValue(employee.getCode()),
                safeValue(employee.getCardCode()),
                safeValue(employee.getLastName()),
                safeValue(employee.getFirstName()),
                safeValue(employee.getCategoryCode()),
                safeValue(employee.getCategoryDescription()),
                safeValue(employee.getFunctionCode()),
                safeValue(employee.getFunctionDescription()),
                safeValue(employee.getShiftCode()),
                safeValue(employee.getShiftDescription()),
                safeValue(employee.getGender()),
                safeValue(employee.getLanguage()),
                safeValue(employee.getChangeSize()),
                formatDate(employee.getContractStart()),
                formatDate(employee.getContractEnd()),
                formatDate(employee.getDisableDate()),
                safeValue(employee.getMag()),
                safeValue(employee.getPrimaryMag())
        ) + CSV_DELIMITER;
    }

    /**
     * Formats a list of employees to CSV format with header
     */
    public String formatEmployeesToCsv(List<EmployeeTransaction> employees) {
        StringBuilder csv = new StringBuilder();
        csv.append(CSV_HEADER).append(System.lineSeparator());

        employees.forEach(employee ->
                csv.append(format(employee)).append(System.lineSeparator())
        );

        return csv.toString();
    }

//    /**
//     * Formats a list of employees to CSV format without header
//     */
//    public String formatEmployeesToCsvNoHeader(List<EmployeeTransaction> employees) {
//        return employees.stream()
//                .map(this::format)
//                .collect(Collectors.joining(System.lineSeparator()));
//    }

    /**
     * Returns empty string if value is null, otherwise returns the value
     */
    private static String safeValue(String value) {
        return value == null ? "" : value;
    }

    /**
     * Formats LocalDate to ddMMyyyy format, returns empty string if null
     */
    private static String formatDate(LocalDate date) {
        return date == null ? "" : date.format(DATE_FORMATTER);
    }

    /**
     * Generates CSV header
     */
    public String getCsvHeader() {
        return CSV_HEADER;
    }
}
