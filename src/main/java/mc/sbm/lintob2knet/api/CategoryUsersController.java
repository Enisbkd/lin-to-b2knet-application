package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.CategoryUserTransaction;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/category-users")
@RequiredArgsConstructor
@Slf4j
public class CategoryUsersController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody CategoryUserTransaction dto) {
        log.debug("Received category-user import request: transactionId={}, categoryCode={}, userNumber={}",
                dto.getId(), dto.getCategoryCode(), dto.getUserNumber());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getUserNumber());
        String topicName = topicConfig.buildRawTopic("categoryusers");


        try {
            producer.send(topicName, messageKey, evt);
            log.info("Category-user import event sent successfully: transactionId={}, categoryCode={}, userNumber={}, key={}",
                    dto.getId(), dto.getCategoryCode(), dto.getUserNumber(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send category-user import event: transactionId={}, categoryCode={}, userNumber={}",
                    dto.getId(), dto.getCategoryCode(), dto.getUserNumber(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                        "categoryCode", dto.getCategoryCode(),
                        "userNumber", dto.getUserNumber()
                ));
    }

    private String resolveMessageKey(String userNumber) {
        return userNumber != null && !userNumber.isBlank() ? userNumber : DEFAULT_KEY;
    }
}
