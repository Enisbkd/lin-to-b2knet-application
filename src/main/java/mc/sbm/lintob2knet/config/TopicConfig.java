package mc.sbm.lintob2knet.config;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import mc.sbm.lintob2knet.validation.ConveyorValidator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Getter
@RequiredArgsConstructor
public class TopicConfig {

    @Value("${app.kafka.env}")
    private String env;

    private final ConveyorValidator conveyorValidator;

    /**
     * Builds raw topic name: data-lin-{entity}-raw-{conveyor}-{env}
     * Example: data-lin-models-raw-hp-dev
     */
    public String buildRawTopic(String entity, String conveyor) {
        String normalizedConveyor = conveyorValidator.normalize(conveyor);
        return String.format("data-lin-%s-raw-%s-%s", entity, normalizedConveyor, env);
    }

    /**
     * Builds formatted topic name: data-lin-{conveyor}-{env}
     * Example: data-lin-hp-dev
     */
    public String buildFormattedTopic(String conveyor) {
        String normalizedConveyor = conveyorValidator.normalize(conveyor);
        return String.format("data-lin-%s-%s", normalizedConveyor, env);
    }
}
