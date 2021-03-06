package com.on.nearbnb.member.service;

import java.util.List;

import com.on.nearbnb.member.model.vo.Member;

public interface MemberService {
	
	public List<Member> selectMemberAll() throws Exception;
	
	// id 찾기용
	public Member selectMember(Member member) throws Exception;
	
	public Member selectMemberStr(String userId) throws Exception;
	
	public String authEmail(String userEmail) throws Exception;
	
	public int insertMember(Member member) throws Exception;
	
	public int updateMember(Member member) throws Exception;
	
	public int deleteMember(String userId) throws Exception;
 
	public int updateMemberProfile(String userId) throws Exception;
}
