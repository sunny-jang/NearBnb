package com.on.nearbnb.member.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.member.model.vo.Member;

@Repository
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public MemberDao() {}
	
	public List<Member> selectMember() throws Exception {
		List<Member> memberList = sqlSession.selectList("Member.selectMember");
		return memberList;
	}
	
//	public Member selectMember(String userId) throws Exception {
//		Member member = sqlSession.selectOne("Member.selectMember", userId);
//		return member;
//	}
	
	public Member selectMember(Member member) throws Exception {
		Member memberResult = sqlSession.selectOne("Member.selectMember", member);
		return memberResult;
	}
	
	public int insertMember(Member member) throws Exception {
		int cnt = sqlSession.insert("Member.insertMember", member);
		return cnt;
	}

}
