package com.on.nearbnb.file.service;

import com.on.nearbnb.file.model.vo.MemberProfile;

public interface MemberProfileService {
	
	public int insertMemberProfile(MemberProfile memberProfile) throws Exception;
	
	public String selectMemberProfile(String userId) throws Exception;
}
