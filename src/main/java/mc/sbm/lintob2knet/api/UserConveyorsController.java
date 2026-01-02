package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.UserConveyorTransaction;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/user-conveyors")
@RequiredArgsConstructor
@Slf4j
public class UserConveyorsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody UserConveyorTransaction dto) {
        log.debug("Received user-conveyor import request: transactionId={}, userNumber={}, conveyorCode={}",
                dto.getId(), dto.getUserNumber(), dto.getConveyorCode());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getUserNumber());
        String topicName = topicConfig.buildRawTopic("userconveyors");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("User-conveyor import event sent successfully: transactionId={}, userNumber={}, conveyorCode={}, key={}",
                    dto.getId(), dto.getUserNumber(), dto.getConveyorCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send user-conveyor import event: transactionId={}, userNumber={}, conveyorCode={}",
                    dto.getId(), dto.getUserNumber(), dto.getConveyorCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                        "userNumber", dto.getUserNumber(),
                        "conveyorCode", dto.getConveyorCode()
                ));
    }

    private String resolveMessageKey(String userNumber) {
        return userNumber != null && !userNumber.isBlank() ? userNumber : DEFAULT_KEY;
    }
}
