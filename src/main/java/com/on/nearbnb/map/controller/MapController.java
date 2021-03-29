package com.on.nearbnb.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MapController {

	@RequestMapping(value = "/centerPoint.do", method = RequestMethod.GET)
	public ModelAndView maptest(ModelAndView modelAndView) {
		
		
		modelAndView.setViewName("mainMap");
		return modelAndView;
	}
	
	@RequestMapping(value = "/centerPoint.do", method = RequestMethod.POST)
	public ModelAndView area(ModelAndView modelAndView) {
		
		
		modelAndView.setViewName("mainMap");
		return modelAndView;
	}
}
