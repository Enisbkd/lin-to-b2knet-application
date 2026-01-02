package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import mc.sbm.lintob2knet.model.UserFunctionTransaction;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/functions")
@RequiredArgsConstructor
@Slf4j
public class FunctionsController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody UserFunctionTransaction dto) {
        log.debug("Received function import request: transactionId={}, functionCode={}",
                dto.getId(), dto.getFunctionCode());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(dto.getId())
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getFunctionCode());
        String topicName = topicConfig.buildRawTopic("functions");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Function import event sent successfully: transactionId={}, functionCode={}, key={}",
                    dto.getId(), dto.getFunctionCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send function import event: transactionId={}, functionCode={}",
                    dto.getId(), dto.getFunctionCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "transactionId", dto.getId(),
                        "functionCode", dto.getFunctionCode()
                ));
    }

    private String resolveMessageKey(String functionCode) {
        return functionCode != null && !functionCode.isBlank() ? functionCode : DEFAULT_KEY;
    }
}
