package com.on.nearbnb.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.member.model.vo.Member;
import com.on.nearbnb.member.service.MemberService;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.service.PlaceService;

@Controller
public class MyPageController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PlaceService placeService;
	
	@RequestMapping(value="/myPage.do", method=RequestMethod.GET)
	public ModelAndView myPage(ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("myPage/myPage");
		return modelAndView;
	}
	
	@RequestMapping(value="/myPagePwCheck.do", method=RequestMethod.GET)
	public ModelAndView myPagePwCheck(ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("myPage/myPagePwCheck");
		return modelAndView;
	}	
	
	@RequestMapping(value="/myPagePwCheckAction.do", method=RequestMethod.POST)
	public ModelAndView myPagePwCheckAction(Member member, ModelAndView modelAndView) throws Exception {
		Member m = memberService.selectMember(member);
		if(m.getUserPw().equals(member.getUserPw())) {
			modelAndView.setViewName("redirect:myPage.do");
		} else {
			modelAndView.setViewName("myPage/myPagePwCheckError");
		}		
		return modelAndView;
	}
	
	@RequestMapping(value="/myPageEditUser.do", method=RequestMethod.GET)
	public ModelAndView myPageEditUser(HttpSession session, ModelAndView modelAndView) throws Exception {
		String userId = (String)session.getAttribute("userId");
		Member m = memberService.selectMemberStr(userId);
		modelAndView.addObject("m", m);		
		modelAndView.setViewName("myPage/myPageEditUser");
		return modelAndView;
	}
	
	@RequestMapping(value="editUserAction.do", method=RequestMethod.POST)
	public ModelAndView editUserAction(Member member, ModelAndView modelAndView) throws Exception {
		int cnt = memberService.updateMember(member);
		if(cnt == 1) {
			modelAndView.setViewName("myPage/editUserComplete");
		}
		return modelAndView;
	}
	
	@RequestMapping(value="withdrawal.do", method=RequestMethod.GET)
	public ModelAndView withdrawal(HttpSession session, ModelAndView modelAndView) throws Exception {
		String userId = (String)session.getAttribute("userId");
		int cnt = memberService.deleteMember(userId);
		if(cnt == 1) {
			session.invalidate();
			modelAndView.setViewName("myPage/withdrawalComplete");
		}
		return modelAndView;
	}
	
	@RequestMapping(value = "/myPageHostCheck.do", method = RequestMethod.GET)
	public ModelAndView myPageHostCheck(HttpSession session, ModelAndView modelAndView) {
		String uId = (String)session.getAttribute("userId");
		List<Place> placeList = placeService.selectPlaceById(uId);
		modelAndView.addObject("placeList", placeList);
		modelAndView.setViewName("myPage/myPageHostCheck");
		return modelAndView;
	}
	
	@RequestMapping(value = "/myPageHostCalendar.do", method = RequestMethod.GET)
	public ModelAndView myPageHostCalendar(ModelAndView modelAndView) {
		modelAndView.setViewName("myPage/myPageHostCalendar");
		return modelAndView;
	}
	
	@RequestMapping(value = "/myPageGuestCheck.do", method = RequestMethod.GET)
	public ModelAndView myPageGuestCheck(ModelAndView modelAndView) {
		modelAndView.setViewName("/myPage/myPageGuestCheck");
		return modelAndView;
	}
	
}
