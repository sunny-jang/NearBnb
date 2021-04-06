package com.on.nearbnb.file.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.file.model.vo.MemberProfile;

@Repository
public class MemberProfileDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertMemberProfile(MemberProfile memberProfile) throws Exception {
		return sqlSession.insert("MemberProfile.insertMemberProfile", memberProfile);
	}
	
	public String selectMemberProfile(String userId) throws Exception {
		return sqlSession.selectOne("MemberProfile.selectMemberProfile", userId);
	}
	
	public int updateMemberProfile(MemberProfile memberProfile) throws Exception {
		return sqlSession.update("MemberProfile.updateMemberProfile", memberProfile);
	}
}
