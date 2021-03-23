package com.on.nearbnb.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.member.model.dao.MemberDao;
import com.on.nearbnb.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberDao memberDao;
	
	@Override
	public List<Member> selectMemberAll() throws Exception {
		List<Member> memberList = memberDao.selectMemberAll();
		return memberList;
	}

	@Override
	public int insertMember(Member member) throws Exception {
		int cnt = memberDao.insertMember(member);
		return cnt;
	}

}
