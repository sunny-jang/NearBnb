package com.on.nearbnb.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.member.model.vo.Member;
import com.on.nearbnb.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	// 테스트 컨트롤러
	@RequestMapping(value = "/testInsert.do", method = RequestMethod.GET)
	public ModelAndView test(Member member, ModelAndView modelAndView) throws Exception {		
		int cnt = memberService.insertMember(member);
		List<Member> memberList = memberService.selectMemberAll();
		System.out.println(memberList.toString());
		return modelAndView;
	}
	
	@RequestMapping(value = "/test.do", method = RequestMethod.GET)
	public ModelAndView testInsert(Member member, ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("member/test");		
		return modelAndView;
	}
	
	// 회원가입 페이지 이동
	@RequestMapping(value = "/signUp.do", method = RequestMethod.GET)
	public ModelAndView signUp(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/signUp");
		return modelAndView;
	}
	
	// 로그인 페이지 이동
	@RequestMapping(value = "/signIn.do", method = RequestMethod.GET)
	public ModelAndView signIn(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/signIn");
		return modelAndView;
	}
	
	// 아이디 중복확인 ajax
	@RequestMapping(value="idCheck.do", method=RequestMethod.GET)
	@ResponseBody
	public String idCheck(@RequestParam("idCheck") String userId) throws Exception {
		Member member = memberService.selectMember(userId);
		if(member == null) {
			return "1";
		} else {
			return "0";
		}
	}
	
	// 이메일 인증번호 전송
	@RequestMapping(value="authNum.do", method=RequestMethod.POST)
	@ResponseBody
	public String authNum(@RequestParam("authNum") String userEmail) throws Exception {
		String authNum = memberService.authEmail(userEmail);
		return authNum;
	}
	
	// 회원 가입 정보 DB 저장 및 회원가입 완료
	@RequestMapping(value = "/memberIns.do", method = RequestMethod.POST)
	public ModelAndView insertMember(Member member, ModelAndView modelAndView) throws Exception {
		System.out.println(member);
		int cnt = memberService.insertMember(member);
		if(cnt == 1) {
			modelAndView.setViewName("member/memberInsComplete");
		} else {
			modelAndView.setViewName("member/memberErrorPage");
		}
		return modelAndView;
	}
	
	// 로그인 검증
	@RequestMapping(value="login.do", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam("userId") String userId, @RequestParam("userPw") String userPw,
			HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		Member member = memberService.selectMember(userId);
		if(member == null) {
			modelAndView.setViewName("member/memberLoginError");
		} else {
			if((member.getUserPw()).equals(userPw)) {
				session.setAttribute("userId", userId);
				modelAndView.setViewName("member/memberLoginComplete");				
			} else {
				modelAndView.setViewName("member/memberLoginError");
			}
		}
		return modelAndView;
	}
	

}
