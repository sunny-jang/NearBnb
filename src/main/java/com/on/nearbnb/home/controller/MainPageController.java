package com.on.nearbnb.home.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.place.model.dao.PlacePointDao;
import com.on.nearbnb.place.model.vo.PlacePoint;
import com.on.nearbnb.place.service.PlaceService;

@Controller
public class MainPageController {
	@Autowired
	PlacePointDao placepointDao;
	@Autowired
	PlaceService placeService;
	
	@RequestMapping(value = "/centerPoint.do", method = RequestMethod.POST)
	public ModelAndView searchPlacePoint(@RequestParam("latitude") double latitude, @RequestParam("longitude") double longitude,
			 HttpServletRequest request, ModelAndView modelAndView) {
	
	PlacePoint searchpoint= new PlacePoint();
	searchpoint.setLatitude(latitude);
	searchpoint.setLongitude(longitude);
	
	System.out.println("위도 getLatitude : "+searchpoint.getLatitude());
	System.out.println("경도 getLongitude : "+searchpoint.getLongitude()); 
	
	
	List<PlacePoint> resultpoint = placeService.searchPlacePoint(searchpoint);
	System.out.println(resultpoint.get(0).toString());

	System.out.println(resultpoint.get(0).getPlaceId());
	
	JSONObject jsonData = new JSONObject();
	JSONArray jsonArray = new JSONArray();
	
	
	
		modelAndView.addObject("resultpoint", resultpoint);
		modelAndView.setViewName("mainMap");
		return modelAndView;
	}
}
