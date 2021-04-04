package com.on.nearbnb.home.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.file.service.PlaceFileService;
import com.on.nearbnb.place.model.dao.PlacePointDao;
import com.on.nearbnb.place.model.vo.ExtendedPlace;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;
import com.on.nearbnb.place.service.PlaceService;

@Controller
public class MainPageController {
	@Autowired
	PlacePointDao placepointDao;
	@Autowired
	PlaceService placeService;
	@Autowired
	PlaceFileService placeFileService;
	
	
	@RequestMapping(value = "/test.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")@ResponseBody
	public void test(@RequestParam("latitude") double latitude,
			@RequestParam("longitude") double longitude, HttpServletRequest request, ModelAndView modelAndView) {
		PlacePoint pp = new PlacePoint();
		pp.setLatitude(latitude);
		pp.setLongitude(longitude);
		
		List<ExtendedPlace> ep = placeService.searchExtendedPlace(pp);
		System.out.println(ep.toString());
	}

	@RequestMapping(value = "/centerPoint.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")@ResponseBody
	public Object searchPlacePoint(@RequestParam("latitude") double latitude,
			@RequestParam("longitude") double longitude, HttpServletRequest request, ModelAndView modelAndView) {

		PlacePoint searchpoint = new PlacePoint();
		searchpoint.setLatitude(latitude);
		searchpoint.setLongitude(longitude);

		List<PlacePoint> resultpoint = placeService.searchPlacePoint(searchpoint);
		
		List<Place> resultplace = new ArrayList();
		List<String> resultimage = new ArrayList(); 
		
		for(int i =0; i<resultpoint.size(); i++) {
			
			int pId=resultpoint.get(i).getPlaceId();
			Place placeName = placeService.selectPlace(pId);
			resultplace.add(placeName);
			
			String imageStr = placeFileService.selectOneFiles(pId);
			resultimage.add(imageStr);
		}
		  
		
		//Ajax
		JSONObject jsonObject = new JSONObject();//PlacePoint객체오브젝트
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < resultpoint.size(); i++) {
			JSONObject pObject = new JSONObject();
			pObject.put("placeId", resultpoint.get(i).getPlaceId());
			pObject.put("latitude", resultpoint.get(i).getLatitude());
			pObject.put("longitude", resultpoint.get(i).getLongitude());
			pObject.put("placeName",resultplace.get(i).getPlaceName());
			pObject.put("placeImage",resultimage.get(i));
			jsonArray.add(pObject);
		}
		
		jsonObject.put("pointList",jsonArray);
		
		Object result = jsonObject.toString();
		modelAndView.addObject("resultpoint", resultpoint);
		modelAndView.setViewName("mainMap");
		return result;
	}
}
