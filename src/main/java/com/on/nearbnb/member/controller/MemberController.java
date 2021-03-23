package com.on.nearbnb.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

}
