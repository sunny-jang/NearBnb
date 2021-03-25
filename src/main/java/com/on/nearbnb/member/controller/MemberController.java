package com.on.nearbnb.member.controller;

import java.util.List;

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
	
	@RequestMapping(value = "/signUp.do", method = RequestMethod.GET)
	public ModelAndView signUp(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/signUp");
		return modelAndView;
	}
	
	@RequestMapping(value = "/signIn.do", method = RequestMethod.GET)
	public ModelAndView signIn(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/signIn");
		return modelAndView;
	}
	
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

}
