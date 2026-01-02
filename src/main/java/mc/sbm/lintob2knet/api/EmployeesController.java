package mc.sbm.lintob2knet.api;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mc.sbm.lintob2knet.config.TopicConfig;
import mc.sbm.lintob2knet.kafka.producer.GenericProducer;
import mc.sbm.lintob2knet.model.EmployeeTransaction;
import mc.sbm.lintob2knet.model.GenericImportEvent;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/import/employees")
@RequiredArgsConstructor
@Slf4j
public class EmployeesController {

    private static final String DEFAULT_KEY = "default";

    private final GenericProducer producer;
    private final TopicConfig topicConfig;

    @PostMapping
    public ResponseEntity<Map<String, String>> post(@Valid @RequestBody EmployeeTransaction dto) {
        log.debug("Received employee import request: code={}", dto.getCode());

        GenericImportEvent evt = GenericImportEvent.builder()
                .transactionCode(null)
                .payload(dto)
                .build();

        String messageKey = resolveMessageKey(dto.getCode());
        String topicName = topicConfig.buildRawTopic("employees");

        try {
            producer.send(topicName, messageKey, evt);
            log.info("Employee import event sent successfully: code={}, key={}",
                    dto.getCode(), messageKey);
        } catch (Exception e) {
            log.error("Failed to send employee import event: code={}", dto.getCode(), e);
            throw e;
        }

        return ResponseEntity.accepted()
                .body(Map.of(
                        "status", "accepted",
                        "employeeCode", dto.getCode()
                ));
    }

    private String resolveMessageKey(String code) {
        return code != null && !code.isBlank() ? code : DEFAULT_KEY;
    }
}
