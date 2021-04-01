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
import org.springframework.web.bind.annotation.ResponseBody;
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

	@RequestMapping(value = "/centerPoint.do", method = RequestMethod.POST)@ResponseBody
	public Object searchPlacePoint(@RequestParam("latitude") double latitude,
			@RequestParam("longitude") double longitude, HttpServletRequest request, ModelAndView modelAndView) {

		PlacePoint searchpoint = new PlacePoint();
		searchpoint.setLatitude(latitude);
		searchpoint.setLongitude(longitude);

		System.out.println("위도 getLatitude : " + searchpoint.getLatitude());
		System.out.println("경도 getLongitude : " + searchpoint.getLongitude());

		List<PlacePoint> resultpoint = placeService.searchPlacePoint(searchpoint);
		System.out.println(resultpoint.get(0).toString());
		System.out.println(resultpoint.get(0).getPlaceId());

		System.out.println("어레이 크기 : " + resultpoint.size());

		JSONObject jsonObject = new JSONObject();//PlacePoint객체오브젝트
		JSONArray jsonArray = new JSONArray();
		
		JSONObject arrCount = new JSONObject();
		arrCount.put("arrCount", resultpoint.size());
		jsonArray.add(arrCount);
		for (int i = 0; i < resultpoint.size(); i++) {
			JSONObject pObject = new JSONObject();
			pObject.put("placeId", resultpoint.get(i).getPlaceId());
			pObject.put("latitude", resultpoint.get(i).getLatitude());
			pObject.put("longitude", resultpoint.get(i).getLongitude());
			jsonArray.add(pObject);
		}
		
		jsonObject.put("pointList",jsonArray);
		
		Object result = jsonObject.toString();
		
		modelAndView.addObject("resultpoint", resultpoint);
		modelAndView.setViewName("mainMap");
		return result;
	}
}
