package com.on.nearbnb.file.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.file.model.dao.MemberProfileDao;
import com.on.nearbnb.file.model.vo.MemberProfile;

@Service
public class MemberProfileServiceImpl implements MemberProfileService {

	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Override
	public int insertMemberProfile(MemberProfile memberProfile) {
		
		return memberProfileDao.insertMemberProfile(memberProfile);
	}

}
