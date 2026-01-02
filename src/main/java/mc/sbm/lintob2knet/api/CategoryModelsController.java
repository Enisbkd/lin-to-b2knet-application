package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.CategoryModelTransaction;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/category-models")
@RequiredArgsConstructor
@Slf4j
public class CategoryModelsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody CategoryModelTransaction dto) {
        log.debug("Received category-model import request: transactionId={}, categoryCode={}, modelCode={}",
                dto.getId(), dto.getCategoryCode(), dto.getModelCode());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getCategoryCode(), dto.getModelCode());
        String topicName = topicConfig.buildRawTopic("categorymodels");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Category-model import event sent successfully: transactionId={}, categoryCode={}, modelCode={}, key={}",
                    dto.getId(), dto.getCategoryCode(), dto.getModelCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send category-model import event: transactionId={}, categoryCode={}, modelCode={}",
                    dto.getId(), dto.getCategoryCode(), dto.getModelCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                        "categoryCode", dto.getCategoryCode(),
                        "modelCode", dto.getModelCode()
                ));
    }

    private String resolveMessageKey(String categoryCode, String modelCode) {
        if (categoryCode != null && !categoryCode.isBlank()) {
            return modelCode != null && !modelCode.isBlank() ? categoryCode + "-" + modelCode : categoryCode;
        }
        return DEFAULT_KEY;
    }
}
