package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.ChipTransaction;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/chips")
@RequiredArgsConstructor
@Slf4j
public class ChipsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody ChipTransaction dto) {
        log.debug("Received chip import request: transactionId={}, chipCode={}",
                dto.getId(), dto.getChipCode());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getChipCode());
        String topicName = topicConfig.buildRawTopic("chips");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Chip import event sent successfully: transactionId={}, chipCode={}, key={}",
                    dto.getId(), dto.getChipCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send chip import event: transactionId={}, chipCode={}",
                    dto.getId(), dto.getChipCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                        "chipCode", dto.getChipCode()
                ));
    }

    private String resolveMessageKey(String chipCode) {
        return chipCode != null && !chipCode.isBlank() ? chipCode : DEFAULT_KEY;
    }
}
