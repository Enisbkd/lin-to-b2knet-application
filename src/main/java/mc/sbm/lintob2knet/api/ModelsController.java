package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.ModelTransaction;
import mc.sbm.lintob2knet.validation.ConveyorValidator;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/import/{conveyorCode}/models")
@RequiredArgsConstructor
@Slf4j
public class ModelsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;
    private final ConveyorValidator conveyorValidator;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@PathVariable String conveyorCode, @Valid @RequestBody ModelTransaction dto) {
        // Validate and normalize conveyor code
        String normalizedConveyor = conveyorValidator.normalize(conveyorCode);

        log.debug(
            "Received model import request: transactionId={}, modelCode={}, conveyor={}",
            dto.getId(),
            dto.getModelCode(),
            normalizedConveyor
        );

        GenericImportEvent evt = GenericImportEvent.builder().transactionCode(dto.getId()).payload(dto).build();

        String messageKey = resolveMessageKey(dto.getModelCode());
        String topicName = topicConfig.buildGeneralTopic(normalizedConveyor);

        try {
            producer.send(topicName, messageKey, evt);
            log.info(
                "Model import event sent successfully: transactionId={}, modelCode={}, conveyor={}, topic={}, key={}",
                dto.getId(),
                dto.getModelCode(),
                normalizedConveyor,
                topicName,
                messageKey
            );
        } catch (Exception e) {
            log.error(
                "Failed to send model import event: transactionId={}, modelCode={}, conveyor={}",
                dto.getId(),
                dto.getModelCode(),
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
                "modelCode",
                dto.getModelCode(),
                "conveyor",
                normalizedConveyor,
                "topic",
                topicName
            )
        );
    }

    private String resolveMessageKey(String modelCode) {
        return modelCode != null && !modelCode.isBlank() ? modelCode : DEFAULT_KEY;
    }
}
