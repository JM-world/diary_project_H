package com.human.project_H.entity;

import java.util.Map;

public class KakaoMemberInfo implements OAuth2MemberInfo{
	private Map<String, Object> attributes;
	private Map<String, Object> kakaoAccountAttributes;
	private Map<String, Object> profileAttributes;
	
	public KakaoMemberInfo(Map<String, Object> attributes) {
		 /*
        System.out.println(attributes);
            {id=아이디값,
            connected_at=2022-02-22T15:50:21Z,
            properties={nickname=이름},
            kakao_account={
                profile_nickname_needs_agreement=false,
                profile={nickname=이름},
                has_email=true,
                email_needs_agreement=false,
                is_email_valid=true,
                is_email_verified=true,
                email=이메일}
            }
        */
		this.attributes = attributes;
		this.kakaoAccountAttributes = (Map<String, Object>) attributes.get("kakao_account");
		this.profileAttributes = (Map<String, Object>) kakaoAccountAttributes.get("profile");
	}

	@Override
	public String getProviderId() {
		return attributes.get("id").toString();
	}

	@Override
	public String getProvider() {
		return "kakao";
	}

	@Override
	public String getName() {
		return profileAttributes.get("nickname").toString();
	}

	@Override
	public String getEmail() {
		return kakaoAccountAttributes.get("email").toString();
	}
}
