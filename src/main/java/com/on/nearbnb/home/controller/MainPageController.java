package com.on.nearbnb.home.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.place.model.dao.PlacePointDao;
import com.on.nearbnb.place.service.PlaceService;

@Controller
public class MainPageController {
	@Autowired
	PlacePointDao placepointDao;
	@Autowired
	PlaceService placeService;
	
	@RequestMapping(value = "/centerPoint.do", method = RequestMethod.POST)
	public ModelAndView area(@RequestParam("latitude") double latitude, @RequestParam("longitude") double longitude,
			ModelAndView modelAndView) {
	System.out.println("위도 : "+latitude);
	System.out.println("경도 : "+longitude);
	
		
	//	List<PlacePoint> pointList = placeService.
		
		
		modelAndView.setViewName("mainMap");
		return modelAndView;
	}
}
