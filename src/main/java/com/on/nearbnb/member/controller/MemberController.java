package com.on.nearbnb.member.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public ModelAndView signUp(ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("/member/signUp");
		return modelAndView;
	}
	
	// 로그인 페이지 이동
	@RequestMapping(value = "/signIn.do", method = RequestMethod.GET)
	public ModelAndView signIn(ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("/member/signIn");
		return modelAndView;
	}
	
	// 아이디 중복확인 ajax
	@RequestMapping(value="idCheck.do", method=RequestMethod.GET)	
	public void idCheck(Member member, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		Member m = memberService.selectMember(member);
		if(m == null) {
			out.append("1");
		} else {
			out.append("0");
		}		
		out.close();
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
	public ModelAndView login(Member member, HttpServletRequest request,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		Member m = memberService.selectMember(member);
		if(m == null) {
			modelAndView.setViewName("member/memberLoginError");
		} else {
			if((m.getUserPw()).equals(member.getUserPw())) {
				session.setAttribute("userId", m.getUserId());
				modelAndView.setViewName("redirect:index.do");				
			} else {
				modelAndView.setViewName("member/memberLoginError");
			}
		}
		return modelAndView;
	}
	
	// 로그아웃
	@RequestMapping(value="signOut.do", method=RequestMethod.GET)
	public ModelAndView signOut(HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		modelAndView.setViewName("redirect:index.do");
		return modelAndView;
	}
	
	// 아이디 찾기
	@RequestMapping(value = "/findId.do", method = RequestMethod.GET)
	public ModelAndView findId(ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("member/findId");
		return modelAndView;
	}
	
	@RequestMapping(value = "findIdAction.do", method = RequestMethod.POST)
	public String findIdAction(Member member, Model model) throws Exception {		
		Member m = memberService.selectMember(member);
		if(m != null) {
			model.addAttribute("foundId", m.getUserId());
			System.out.println(m.getUserId());
		}
		return "member/findIdResult";
	}	
	
	// 비밀번호 찾기
	@RequestMapping(value = "/findPassword.do", method = RequestMethod.GET)
	public ModelAndView findPassword(ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("member/findPassword");
		return modelAndView;
	}
	
	@RequestMapping(value = "/findPwAction.do", method = RequestMethod.POST)
	public ModelAndView findPwAction(Member member, ModelAndView modelAndView) throws Exception {
		System.out.println(member);
		Member m = memberService.selectMember(member);
		System.out.println(m);
		if(m != null) {
			String authNum = memberService.authEmail(m.getUserEmail());
			modelAndView.addObject("userId", m.getUserId());
			modelAndView.addObject("authKey", authNum);
			modelAndView.setViewName("member/findPasswordAuth");
		} else {
			modelAndView.setViewName("member/findPasswordError");
		}
		return modelAndView;
	}
	
	@RequestMapping(value = "/changePassword.do", method = RequestMethod.POST)
	public ModelAndView findPasswordAuth(@RequestParam("userId") String userId, ModelAndView modelAndView) throws Exception {
		modelAndView.addObject("userId", userId);
		modelAndView.setViewName("member/changePassword");
		return modelAndView;
	}
	
	@RequestMapping(value = "/changePwAction.do", method = RequestMethod.POST)
	public ModelAndView changePwAction(Member member, ModelAndView modelAndView) throws Exception {
		int cnt = memberService.updateMember(member);
		if(cnt == 1) {
			modelAndView.setViewName("member/changePwComplete");
		}
		return modelAndView;
	}	
	
}
