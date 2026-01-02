package mc.sbm.lintob2knet;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import mc.sbm.lintob2knet.config.AsyncSyncConfiguration;
import mc.sbm.lintob2knet.config.JacksonConfiguration;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Base composite annotation for integration tests.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@SpringBootTest(classes = { LinToB2KnetApplicationApp.class, JacksonConfiguration.class, AsyncSyncConfiguration.class })
public @interface IntegrationTest {}
