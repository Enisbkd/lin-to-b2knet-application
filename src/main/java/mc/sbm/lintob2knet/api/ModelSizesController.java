package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.ModelSizeTransaction;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/model-sizes")
@RequiredArgsConstructor
@Slf4j
public class ModelSizesController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody ModelSizeTransaction dto) {
        log.debug("Received model size import request: transactionId={}, modelCode={}, sizeCode={}",
                dto.getId(), dto.getModelCode(), dto.getSizeCode());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getModelCode(), dto.getSizeCode());
        String topicName = topicConfig.buildRawTopic("modelsizes");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Model size import event sent successfully: transactionId={}, modelCode={}, sizeCode={}, key={}",
                    dto.getId(), dto.getModelCode(), dto.getSizeCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send model size import event: transactionId={}, modelCode={}, sizeCode={}",
                    dto.getId(), dto.getModelCode(), dto.getSizeCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                        "modelCode", dto.getModelCode(),
                        "sizeCode", dto.getSizeCode()
                ));
    }

    private String resolveMessageKey(String modelCode, String sizeCode) {
        if (modelCode != null && !modelCode.isBlank()) {
            return sizeCode != null && !sizeCode.isBlank() ? modelCode + "-" + sizeCode : modelCode;
        }
        return DEFAULT_KEY;
    }
}
