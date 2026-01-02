package mc.sbm.lintob2knet.config;//
//package mc.sbm.lin2btk.config;
//
//import org.apache.kafka.streams.StreamsConfig;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.*;
//import org.springframework.kafka.annotation.EnableKafka;
//import org.springframework.kafka.config.KafkaStreamsConfiguration;
//
//import java.util.HashMap;
//import java.util.Map;
//
//@Configuration
//@EnableKafka
//public class KafkaStreamsConfig {
//
//    @Value("${spring.kafka.bootstrap-servers}")
//    private String bootstrapServers;
//
//    @Value("${spring.application.name:lin2btk-modeA-streams}")
//    private String appId;
//
//    @Bean(name = "kafkaStreamsConfigA")
//    public KafkaStreamsConfiguration kafkaStreamsConfiguration() {
//        Map<String, Object> props = new HashMap<>();
//        props.put(StreamsConfig.APPLICATION_ID_CONFIG, appId);
//        props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
//        props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, org.apache.kafka.common.serialization.Serdes.String().getClass());
//        props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, org.springframework.kafka.support.serializer.JsonSerde.class);
//        return new KafkaStreamsConfiguration(props);
//    }
//}
