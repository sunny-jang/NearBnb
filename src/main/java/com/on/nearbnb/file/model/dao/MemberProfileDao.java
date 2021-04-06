package com.on.nearbnb.file.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.file.model.vo.MemberProfile;

@Repository
public class MemberProfileDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertMemberProfile(MemberProfile memberProfile) {
		return sqlSession.insert("insertMemberProfile", memberProfile);
	}
}