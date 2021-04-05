package com.on.nearbnb.member.service;

import java.util.List;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.on.nearbnb.member.model.dao.MemberDao;
import com.on.nearbnb.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberDao memberDao;
	
	@Inject
	JavaMailSenderImpl mailSender;
	
	@Override
	public List<Member> selectMemberAll() throws Exception {
		List<Member> memberList = memberDao.selectMember();
		return memberList;
	}	

	@Override
	public Member selectMember(Member member) throws Exception {
		Member m = memberDao.selectMember(member);
		return m;
	}
	
	@Override
	public Member selectMemberStr(String userId) throws Exception {
		Member m = memberDao.selectMember(userId);
		return m;
	}

	@Override
	public String authEmail(String userEmail) throws Exception {
		
		// 인증번호 생성기
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for(int i=0; i<10; i++) {
			int rIndex = rnd.nextInt(3);
			switch(rIndex) {
			case 0 :
				// a-z
				temp.append((char)((int)(rnd.nextInt(26))+97));
				break;
			case 1 :
				// A-Z
				temp.append((char)((int)(rnd.nextInt(26))+65));
				break;
			case 2 :
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		
		// 메일 제목, 내용
		String subject = "안녕하세요. NearBnB 인증 메일입니다.";
		String content = "인증 번호는 : "+temp+" 입니다.";		
		
		// 보내는 사람
		String from = "zordstyle@naver.com";
		
		// 받는 사람
		String to = userEmail;
		
		try {
			// 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
			
			// 메일 내용 채우기
			mailHelper.setFrom(from);		// 보내는 사람 셋팅
			mailHelper.setTo(to);			// 받는 사람 셋팅
			mailHelper.setSubject(subject);	// 제목 셋팅
			mailHelper.setText(content);	// 내용 셋팅
			
			// 메일 전송
			mailSender.send(mail);
		} catch(Exception e) {
			e.printStackTrace();
		}			
				
		return temp.toString();
	}
	
	@Override
	public int insertMember(Member member) throws Exception {
		int cnt = memberDao.insertMember(member);
		return cnt;
	}

	@Override
	public int updateMember(Member member) throws Exception {
		int cnt = memberDao.updateMember(member);
		return cnt;
	}

	@Override
	public int deleteMember(String userId) throws Exception {
		int cnt = memberDao.deleteMember(userId);
		return cnt;
	}

	@Override
	public int updateMemberProfile(String userId) throws Exception {
		int cnt = memberDao.updateMemberProfile(userId);
		return cnt;
	}

}
