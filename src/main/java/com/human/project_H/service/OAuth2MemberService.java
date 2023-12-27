package com.human.project_H.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.human.project_H.entity.KakaoMemberInfo;
import com.human.project_H.entity.NaverMemberInfo;
import com.human.project_H.entity.OAuth2MemberInfo;
import com.human.project_H.entity.PrincipalDetails;
import com.human.project_H.entity.User;

@Service
public class OAuth2MemberService extends DefaultOAuth2UserService {
	@Autowired private BCryptPasswordEncoder bCryptPasswordEncoder;
	@Autowired private UserService userService;
	@Autowired private HttpSession session;
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		OAuth2User oAuth2User = super.loadUser(userRequest);
		OAuth2MemberInfo memberInfo = null;
		System.out.println(oAuth2User.getAttributes());
		System.out.println(userRequest.getClientRegistration().getRegistrationId());
		
		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		System.out.println("registrationId = " + registrationId);
		
		if (registrationId.equals("naver")) {
			memberInfo = new NaverMemberInfo((Map)oAuth2User.getAttributes().get("response"));
		} else if (registrationId.equals("kakao")) {
			memberInfo = new KakaoMemberInfo(oAuth2User.getAttributes());
		} else {
			System.out.println("로그인 실패");
		}
				
		String provider = memberInfo.getProvider();
		String providerId = memberInfo.getProviderId().substring(0,10);
		System.out.println(providerId);
		String username = provider + "_" + providerId; 		// 중복이 발생하지 않도록 provider와 providerId를 조합
		String email = memberInfo.getEmail();
		String nickname = memberInfo.getName();
		String role = "ROLE_USER";	// 일반 유저
		System.out.println(oAuth2User.getAttributes());
		
		User user = userService.getUser(username);
		if(user == null) {
			user = new User(username, bCryptPasswordEncoder.encode("pass"), nickname, provider + " " + nickname, email);
			userService.insertUser(user);
			user = userService.getUser(username);
		}
		
		session.setAttribute("sessCustId", user.getcustId());
		session.setAttribute("sessUname", user.getUname());
		session.setAttribute("sessEmail", user.getEmail());
		
		return new PrincipalDetails(user, oAuth2User.getAttributes());
		
	}
}
