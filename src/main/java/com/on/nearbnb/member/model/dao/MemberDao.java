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
	
	public List<Member> selectMemberAll() throws Exception {
		List<Member> memberList = sqlSession.selectList("Member.selectMemberAll");
		return memberList;
	}
	
	public Member selectMember(String userId) throws Exception {
		Member member = sqlSession.selectOne("Member.selectMember", userId);
		return member;
	}
	
	public int insertMember(Member member) throws Exception {
		int cnt = sqlSession.insert("Member.insertMember", member);
		return cnt;
	}

}
