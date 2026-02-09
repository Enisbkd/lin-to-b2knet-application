package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.UserModelTransaction;
import mc.sbm.lintob2knet.validation.ConveyorValidator;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/{conveyorCode}/user-models")
@RequiredArgsConstructor
@Slf4j
public class UserModelsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;
    private final ConveyorValidator conveyorValidator;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(
            @PathVariable String conveyorCode,
            @Valid @RequestBody UserModelTransaction dto) {

        String normalizedConveyor = conveyorValidator.normalize(conveyorCode);

        log.debug("Received user-model import request: transactionId={}, userNumber={}, itemCode={}, conveyor={}",
            dto.getId(), dto.getUserNumber(), dto.getItemCode(), normalizedConveyor);

        GenericImportEvent evt = GenericImportEvent.builder()
            .transactionCode(dto.getId())
            .payload(dto)
            .build();

        String messageKey = resolveMessageKey(dto.getUserNumber());
        String topicName = topicConfig.buildRawTopic("usermodels", normalizedConveyor);

        try {
            producer.send(topicName, messageKey, evt);
            log.info("User-model import event sent successfully: transactionId={}, userNumber={}, itemCode={}, conveyor={}, topic={}, key={}",
                dto.getId(), dto.getUserNumber(), dto.getItemCode(), normalizedConveyor, topicName, messageKey);
        } catch (Exception e) {
            log.error("Failed to send user-model import event: transactionId={}, userNumber={}, itemCode={}, conveyor={}",
                dto.getId(), dto.getUserNumber(), dto.getItemCode(), normalizedConveyor, e);
            throw e;
        }

        return ResponseEntity.accepted()
            .body(Map.of(
                "status", "accepted",
                "transactionId", dto.getId(),
                "userNumber", dto.getUserNumber(),
                "itemCode", dto.getItemCode(),
                "conveyor", normalizedConveyor,
                "topic", topicName
            ));
    }

    private String resolveMessageKey(String userNumber) {
        return userNumber != null && !userNumber.isBlank() ? userNumber : DEFAULT_KEY;
    }
}
