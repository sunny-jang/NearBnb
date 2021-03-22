package com.on.nearbnb;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView modelAndView) {
		modelAndView.setViewName("home");
		return modelAndView;
	}
	
	@RequestMapping(value = "/placeList.do", method = RequestMethod.GET)
	public ModelAndView placeList(ModelAndView modelAndView) {
		modelAndView.setViewName("placeList");
		return modelAndView;
	}
	
	@RequestMapping(value = "/placeDetail.do", method = RequestMethod.GET)
	public ModelAndView placeDetail(ModelAndView modelAndView) {
		modelAndView.setViewName("placeDetail");
		return modelAndView;
	}
	
	@RequestMapping(value = "/placeReservation.do", method = RequestMethod.GET)
	public ModelAndView placeReservation(ModelAndView modelAndView) {
		modelAndView.setViewName("placeReservation");
		return modelAndView;
	}

	@RequestMapping(value = "/placePayment.do", method = RequestMethod.GET)
	public ModelAndView placePayment(ModelAndView modelAndView) {
		modelAndView.setViewName("placePayment");
		return modelAndView;
	}
	
	@RequestMapping(value = "/reservationComplete.do", method = RequestMethod.GET)
	public ModelAndView reservationComplete(ModelAndView modelAndView) {
		modelAndView.setViewName("reservationComplete");
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
	
	@RequestMapping(value = "/findId.do", method = RequestMethod.GET)
	public ModelAndView findId(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/findId");
		return modelAndView;
	}
	
	@RequestMapping(value = "/findIdResult.do", method = RequestMethod.GET)
	public ModelAndView findIdResult(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/findIdResult");
		return modelAndView;
	}
	
	@RequestMapping(value = "/findPassword.do", method = RequestMethod.GET)
	public ModelAndView findPassword(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/findPassword");
		return modelAndView;
	}
	
	@RequestMapping(value = "/sentPasswordEmail.do", method = RequestMethod.GET)
	public ModelAndView sentPassword(ModelAndView modelAndView) {
		modelAndView.setViewName("/member/sentPasswordEmail");
		return modelAndView;
	}
	
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public ModelAndView mypage(ModelAndView modelAndView) {
		modelAndView.setViewName("/myPage/myPage");
		return modelAndView;
	}
	
	@RequestMapping(value = "/myPageHostCheck.do", method = RequestMethod.GET)
	public ModelAndView myPageHostCheck(ModelAndView modelAndView) {
		modelAndView.setViewName("/myPage/myPageHostCheck");
		return modelAndView;
	}
	
	@RequestMapping(value = "/myPageHostCalendar.do", method = RequestMethod.GET)
	public ModelAndView myPageHostCalendar(ModelAndView modelAndView) {
		modelAndView.setViewName("/myPage/myPageHostCalendar");
		return modelAndView;
	}
	
	@RequestMapping(value = "/myPageGuestCheck.do", method = RequestMethod.GET)
	public ModelAndView myPageGuestCheck(ModelAndView modelAndView) {
		modelAndView.setViewName("/myPage/myPageGuestCheck");
		return modelAndView;
	}
	
	@RequestMapping(value = "/board.do", method = RequestMethod.GET)
	public ModelAndView board(ModelAndView modelAndView) {
		modelAndView.setViewName("board");
		return modelAndView;
	}
	
	@RequestMapping(value = "/boardRead.do", method = RequestMethod.GET)
	public ModelAndView boardRead(ModelAndView modelAndView) {
		modelAndView.setViewName("boardRead");
		return modelAndView;
	}
	
	@RequestMapping(value = "/boardWrite.do", method = RequestMethod.GET)
	public ModelAndView boardWrite(ModelAndView modelAndView) {
		modelAndView.setViewName("boardWrite");
		return modelAndView;
	}
	
	@RequestMapping(value = "/boardRewrite.do", method = RequestMethod.GET)
	public ModelAndView boardRewrite(ModelAndView modelAndView) {
		modelAndView.setViewName("boardRewrite");
		return modelAndView;
	}
	
}
