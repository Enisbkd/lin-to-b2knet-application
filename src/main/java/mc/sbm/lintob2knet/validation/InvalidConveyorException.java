package mc.sbm.lintob2knet.validation;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class InvalidConveyorException extends RuntimeException {
    public InvalidConveyorException(String message) {
        super(message);
    }
}
