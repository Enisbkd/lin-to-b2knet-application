package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GarmentTransaction;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.validation.ConveyorValidator;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/import/{conveyorCode}/garments")
@RequiredArgsConstructor
@Slf4j
public class GarmentsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;
    private final ConveyorValidator conveyorValidator;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@PathVariable String conveyorCode, @Valid @RequestBody GarmentTransaction dto) {
        String normalizedConveyor = conveyorValidator.normalize(conveyorCode);

        log.debug(
            "Received garment import request: transactionId={}, chipCode={}, conveyor={}",
            dto.getId(),
            dto.getChipCode(),
            normalizedConveyor
        );

        GenericImportEvent evt = GenericImportEvent.builder().transactionCode(dto.getId()).payload(dto).build();

        String messageKey = resolveMessageKey(dto.getChipCode());
        String topicName = topicConfig.buildGeneralTopic(normalizedConveyor);

        try {
            producer.send(topicName, messageKey, evt);
            log.info(
                "Garment import event sent successfully: transactionId={}, chipCode={}, conveyor={}, topic={}, key={}",
                dto.getId(),
                dto.getChipCode(),
                normalizedConveyor,
                topicName,
                messageKey
            );
        } catch (Exception e) {
            log.error(
                "Failed to send garment import event: transactionId={}, chipCode={}, conveyor={}",
                dto.getId(),
                dto.getChipCode(),
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
                "chipCode",
                dto.getChipCode(),
                "conveyor",
                normalizedConveyor,
                "topic",
                topicName
            )
        );
    }

    private String resolveMessageKey(String chipCode) {
        return chipCode != null && !chipCode.isBlank() ? chipCode : DEFAULT_KEY;
    }
}
