package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.ModelTransaction;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/models")
@RequiredArgsConstructor
@Slf4j
public class ModelsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody ModelTransaction dto) {
        log.debug("Received model import request: transactionId={}, modelCode={}",
                dto.getId(), dto.getModelCode());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getModelCode());
        String topicName = topicConfig.buildRawTopic("models");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Model import event sent successfully: transactionId={}, modelCode={}, key={}",
                    dto.getId(), dto.getModelCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send model import event: transactionId={}, modelCode={}",
                    dto.getId(), dto.getModelCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                        "modelCode", dto.getModelCode()
                ));
    }

    private String resolveMessageKey(String modelCode) {
        return modelCode != null && !modelCode.isBlank() ? modelCode : DEFAULT_KEY;
    }
}
