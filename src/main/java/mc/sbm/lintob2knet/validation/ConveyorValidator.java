package mc.sbm.lintob2knet.validation;

import java.util.Set;
import org.springframework.stereotype.Component;

@Component
public class ConveyorValidator {

    private static final Set<String> VALID_CONVEYORS = Set.of("hp", "one", "hh");

    public void validate(String conveyorCode) {
        if (conveyorCode == null || conveyorCode.isBlank()) {
            throw new InvalidConveyorException("Conveyor code cannot be null or empty");
        }

        String normalizedCode = conveyorCode.toLowerCase().trim();

        if (!VALID_CONVEYORS.contains(normalizedCode)) {
            throw new InvalidConveyorException(
                String.format("Invalid conveyor code: '%s'. Allowed values: %s", conveyorCode, VALID_CONVEYORS)
            );
        }
    }

    public String normalize(String conveyorCode) {
        validate(conveyorCode);
        return conveyorCode.toLowerCase().trim();
    }

    public Set<String> getValidConveyors() {
        return VALID_CONVEYORS;
    }
}
