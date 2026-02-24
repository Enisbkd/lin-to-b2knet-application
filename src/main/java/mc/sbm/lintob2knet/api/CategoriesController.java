package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.CategoryTransaction;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/{conveyorCode}/user-categories")
@RequiredArgsConstructor
@Slf4j
public class CategoriesController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;


    @PostMapping
    public ResponseEntity<Map<String, String>> post(
        @PathVariable String conveyorCode, @Valid @RequestBody CategoryTransaction dto) {
        log.debug("Received category import request: transactionId={}, categoryCode={}",
            dto.getId(), dto.getCategoryCode());

        GenericImportEvent evt = GenericImportEvent.builder()
            .transactionCode(dto.getId())
            .payload(dto)
            .build();

        String messageKey = resolveMessageKey(dto.getCategoryCode());
        String topicName = topicConfig.buildRawTopic("categories", conveyorCode);

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Category import event sent successfully: transactionId={}, categoryCode={}, key={}",
                dto.getId(), dto.getCategoryCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send category import event: transactionId={}, categoryCode={}",
                dto.getId(), dto.getCategoryCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
            .body(Map.of(
                "status", "accepted",
                "transactionId", dto.getId(),
                "categoryCode", dto.getCategoryCode()
            ));
    }

    private String resolveMessageKey(String categoryCode) {
        return categoryCode != null && !categoryCode.isBlank() ? categoryCode : DEFAULT_KEY;
    }
}
