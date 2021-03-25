package com.on.nearbnb.member.service;

import java.util.List;

import com.on.nearbnb.member.model.vo.Member;

public interface MemberService {
	
	public List<Member> selectMemberAll() throws Exception;
	
	public Member selectMember(String userId) throws Exception;
	
	public int insertMember(Member member) throws Exception;
 
}
