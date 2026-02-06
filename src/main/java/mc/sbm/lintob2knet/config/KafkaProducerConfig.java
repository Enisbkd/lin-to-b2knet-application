
package mc.sbm.lintob2knet.config;

import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.config.SaslConfigs;
import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.core.ProducerFactory;

import java.util.HashMap;
import java.util.Map;

import static org.apache.kafka.clients.CommonClientConfigs.SECURITY_PROTOCOL_CONFIG;

@Configuration
public class KafkaProducerConfig {

    @Value("${spring.kafka.bootstrap-servers}")
    private String bootstrapServers;

    @Value("${spring.kafka.producer.enable-idempotence:true}")
    private boolean enableIdempotence;

    @Value(value = "${spring.kafka.properties.security.protocol}")
    private String protocolConfig;

    @Value(value = "${spring.kafka.properties.sasl.jaas.config}")
    private String saslJaasConfig;

    @Value(value = "${spring.kafka.properties.sasl.mechanism}")
    private String saslMechanism;

    @Value(value = "${spring.kafka.properties.ssl.sslTruststoreLocation}")
    private String trustStoreLocation;

    private String trustStorePassword = System.getProperty("javax.net.ssl.trustStorePassword");


    @Bean
    public ProducerFactory<String, Object> producerFactory() {
        Map<String, Object> cfg = new HashMap<>();
        cfg.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        cfg.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        cfg.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, org.springframework.kafka.support.serializer.JsonSerializer.class);
        cfg.put(ProducerConfig.ACKS_CONFIG, "all");
        cfg.put(ProducerConfig.COMPRESSION_TYPE_CONFIG, "snappy");
        cfg.put(org.springframework.kafka.support.serializer.JsonSerializer.ADD_TYPE_INFO_HEADERS, false);
        if (protocolConfig != null) {
            cfg.put(SECURITY_PROTOCOL_CONFIG, protocolConfig);
        }
        if (saslJaasConfig != null) {
            cfg.put(SaslConfigs.SASL_JAAS_CONFIG, saslJaasConfig);
        }
        if (saslMechanism != null) {
            cfg.put(SaslConfigs.SASL_MECHANISM, saslMechanism);
        }
        if (trustStoreLocation != null) {
            cfg.put("ssl.truststore.location", trustStoreLocation);
        }
        if (trustStorePassword != null) {
            cfg.put("ssl.truststore.password", trustStorePassword);
        }

        return new DefaultKafkaProducerFactory<>(cfg);
    }

    @Bean
    public KafkaTemplate<String, Object> kafkaTemplate() {
        return new KafkaTemplate<>(producerFactory());
    }
}
