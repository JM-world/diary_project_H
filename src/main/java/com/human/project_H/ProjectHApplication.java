package com.human.project_H;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class ProjectHApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectHApplication.class, args);
	}

    @Bean
    BCryptPasswordEncoder bCryptPasswordEncoder() {
	      return new BCryptPasswordEncoder();
	}

}
