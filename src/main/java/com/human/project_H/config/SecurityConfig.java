package com.human.project_H.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.human.project_H.service.OAuth2MemberService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired private OAuth2MemberService oAuth2MemberService;

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception{
        return httpSecurity
                .httpBasic().disable()
                .csrf().disable()
                .cors().and()
                .authorizeRequests()
                .antMatchers("/private/**").authenticated() //private로 시작하는 uri는 로그인 필수
                .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')") //admin으로 시작하는 uri는 관릴자 계정만 접근 가능
                .anyRequest().permitAll() //나머지 uri는 모든 접근 허용
                .and().oauth2Login()
                .loginPage("/user/login") //로그인이 필요한데 로그인을 하지 않았다면 이동할 uri 설정
                .defaultSuccessUrl("/calendar") //OAuth 구글 로그인이 성공하면 이동할 uri 설정
                .failureUrl("/user/login") // 로그인 실패시 이동 uri 설정
                .userInfoEndpoint()//로그인 완료 후 회원 정보 받기
                .userService(oAuth2MemberService).and().and().build(); //
    }
}
	
//	
//	@Bean
//	public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
//		httpSecurity
//				.httpBasic().disable()
//				.csrf().disable()
//				.cors().and()
//				.authorizeRequests()
//				.antMatchers("/private/**").authenticated()	// private로 시작하는 uri는 로그인 필수
//				.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")  // admin으로 시작하는 uri는 관리자 계정만 접근 가능
//				.anyRequest().permitAll()  // 나머지 uri는 모든 접근 허용
////				.and()
////				.formLogin()	// form login 관련 설정
////				.loginPage("/user/login")
////				.loginProcessingUrl("/user/login")
////				.defaultSuccessUrl("/calendar")	// 로그인 성공 후 이동할 url
//				.and()
//				.oauth2Login() 		// oauth2 관련 설정
//				.loginPage("/user/login")		// 로그인이 필요한데 로그인을 하지 않았다면 이동할 uri 설정
//				.defaultSuccessUrl("/index")		// Oauth 로그인이 성공하면 이동할 uri 설정
//				.userInfoEndpoint()		// 로그인 완료 후 회원 정보 받기
//				.userService(getoAuth2MemberService());
//		return httpSecurity.build();
//	}
//	
//}
