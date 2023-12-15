package com.human.project_H.entity;

public interface OAuth2MemberInfo {
	String getProviderId();		// 공급자 아이디  ex) kakao, naver
	String getProvider();		// 공급자  ex) kakao, naver
	String getName();			// 사용자 이름 ex) 홍길동
	String getEmail();			// 사용자 이메일 ex) gildong@gmail.com
}
