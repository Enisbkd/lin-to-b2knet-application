package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.UserTransaction;
import mc.sbm.lintob2knet.validation.ConveyorValidator;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/import/{conveyorCode}/users")
@RequiredArgsConstructor
@Slf4j
public class UsersController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;
    private final ConveyorValidator conveyorValidator;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@PathVariable String conveyorCode, @Valid @RequestBody UserTransaction dto) {
        String normalizedConveyor = conveyorValidator.normalize(conveyorCode);

        log.debug(
            "Received user import request: transactionId={}, userNumber={}, conveyor={}",
            dto.getId(),
            dto.getUserNumber(),
            normalizedConveyor
        );

        GenericImportEvent evt = GenericImportEvent.builder().transactionCode(dto.getId()).payload(dto).build();

        String messageKey = resolveMessageKey(dto.getUserNumber());
        String topicName = topicConfig.buildGeneralTopic(normalizedConveyor);

        try {
            producer.send(topicName, messageKey, evt);
            log.info(
                "User import event sent successfully: transactionId={}, userNumber={}, conveyor={}, topic={}, key={}",
                dto.getId(),
                dto.getUserNumber(),
                normalizedConveyor,
                topicName,
                messageKey
            );
        } catch (Exception e) {
            log.error(
                "Failed to send user import event: transactionId={}, userNumber={}, conveyor={}",
                dto.getId(),
                dto.getUserNumber(),
                normalizedConveyor,
                e
            );
            throw e;
        }

        return ResponseEntity.accepted().body(
            Map.of(
                "status",
                "accepted",
                "transactionId",
                dto.getId(),
                "userNumber",
                dto.getUserNumber(),
                "conveyor",
                normalizedConveyor,
                "topic",
                topicName
            )
        );
    }

    private String resolveMessageKey(String userNumber) {
        return userNumber != null && !userNumber.isBlank() ? userNumber : DEFAULT_KEY;
    }
}
