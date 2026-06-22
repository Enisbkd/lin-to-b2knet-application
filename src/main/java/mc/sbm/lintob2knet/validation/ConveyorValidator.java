package mc.sbm.lintob2knet.validation;

import java.util.HashSet;
import java.util.Set;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ConveyorValidator {

    private final Set<String> validConveyors;

    public ConveyorValidator(
        @Value("${conveyor.one.name}") String oneName,
        @Value("${conveyor.one.enabled:false}") boolean oneEnabled,
        @Value("${conveyor.hp.name}") String hpName,
        @Value("${conveyor.hp.enabled:false}") boolean hpEnabled,
        @Value("${conveyor.hh.name}") String hhName,
        @Value("${conveyor.hh.enabled:false}") boolean hhEnabled
    ) {
        Set<String> codes = new HashSet<>();
        if (oneEnabled) codes.add(oneName);
        if (hpEnabled) codes.add(hpName);
        if (hhEnabled) codes.add(hhName);
        this.validConveyors = Set.copyOf(codes);
    }

    public void validate(String conveyorCode) {
        if (conveyorCode == null || conveyorCode.isBlank()) {
            throw new InvalidConveyorException("Conveyor code cannot be null or empty");
        }

        String normalizedCode = conveyorCode.toLowerCase().trim();

        if (!validConveyors.contains(normalizedCode)) {
            throw new InvalidConveyorException(
                String.format("Invalid conveyor code: '%s'. Allowed values: %s", conveyorCode, validConveyors)
            );
        }
    }

    public String normalize(String conveyorCode) {
        validate(conveyorCode);
        return conveyorCode.toLowerCase().trim();
    }

    public Set<String> getValidConveyors() {
        return validConveyors;
    }
}
