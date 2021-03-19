package com.on.nearbnb.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
	
	// 게시판 index
	@RequestMapping(value = "blist.do", method = RequestMethod.GET)
	public ModelAndView boardListService(ModelAndView modelAndView) {
		modelAndView.setViewName("board");
		return modelAndView;
	}
	
}
