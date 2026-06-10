package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.SizeTransaction;
import mc.sbm.lintob2knet.validation.ConveyorValidator;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/import/{conveyorCode}/sizes")
@RequiredArgsConstructor
@Slf4j
public class SizesController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;
    private final ConveyorValidator conveyorValidator;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@PathVariable String conveyorCode, @Valid @RequestBody SizeTransaction dto) {
        String normalizedConveyor = conveyorValidator.normalize(conveyorCode);

        log.debug(
            "Received size import request: transactionId={}, modelCode={}, sizeCode={}, conveyor={}",
            dto.getId(),
            dto.getModelCode(),
            dto.getSizeCode(),
            normalizedConveyor
        );

        GenericImportEvent evt = GenericImportEvent.builder().transactionCode(dto.getId()).payload(dto).build();

        String messageKey = resolveMessageKey(dto.getModelCode(), dto.getSizeCode());
        String topicName = topicConfig.buildGeneralTopic(normalizedConveyor);

        try {
            producer.send(topicName, messageKey, evt);
            log.info(
                "Size import event sent successfully: transactionId={}, modelCode={}, sizeCode={}, conveyor={}, topic={}, key={}",
                dto.getId(),
                dto.getModelCode(),
                dto.getSizeCode(),
                normalizedConveyor,
                topicName,
                messageKey
            );
        } catch (Exception e) {
            log.error(
                "Failed to send size import event: transactionId={}, modelCode={}, sizeCode={}, conveyor={}",
                dto.getId(),
                dto.getModelCode(),
                dto.getSizeCode(),
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
                "sizeCode",
                dto.getSizeCode(),
                "conveyor",
                normalizedConveyor,
                "topic",
                topicName
            )
        );
    }

    private String resolveMessageKey(String modelCode, String sizeCode) {
        if (modelCode != null && !modelCode.isBlank()) {
            return sizeCode != null && !sizeCode.isBlank() ? modelCode + "-" + sizeCode : modelCode;
        }
        return DEFAULT_KEY;
    }
}
