package mc.sbm.lintob2knet.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Getter
public class TopicConfig {

    @Value("${app.kafka.env}")
    private String env;

    public String buildRawTopic(String model) {
        return String.format("data-lin-%s-raw-one-%s", model, env);
    }

    public String buildFormattedTopic(String model) {
        return String.format("data-lin-%s-formatted-one-%s", model, env);
    }
}
