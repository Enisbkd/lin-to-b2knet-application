package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GarmentTransaction;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/{conveyorCode}/garments/")
@RequiredArgsConstructor
@Slf4j
public class GarmentsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@PathVariable String conveyorCode, @Valid @RequestBody GarmentTransaction dto) {
        log.debug("Received garment import request: transactionId={}, chipCode={}, conveyorCode={}",
            dto.getId(), dto.getChipCode(), conveyorCode);

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getChipCode());
        String topicName = topicConfig.buildRawTopic("garments");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Garment import event sent successfully: transactionId={}, chipCode={}, conveyorCode={}, key={}",
                dto.getId(), dto.getChipCode(), conveyorCode, messageKey);
        } catch (Exception e) {
            log.error("Failed to send garment import event: transactionId={}, chipCode={}, conveyorCode={}",
                dto.getId(), dto.getChipCode(), conveyorCode, e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                    "chipCode", dto.getChipCode(),
                    "conveyorCode", conveyorCode
                ));
    }

    private String resolveMessageKey(String chipCode) {
        return chipCode != null && !chipCode.isBlank() ? chipCode : DEFAULT_KEY;
    }
}
