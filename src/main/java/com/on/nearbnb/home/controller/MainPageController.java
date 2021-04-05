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

	@RequestMapping(value = "/centerPoint.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String searchPlacePoint(@RequestParam("latitude") double latitude,
			@RequestParam("longitude") double longitude, HttpServletRequest request) {

		PlacePoint searchpoint = new PlacePoint();
		searchpoint.setLatitude(latitude);
		searchpoint.setLongitude(longitude);


		System.out.println("위도 getLatitude : " + searchpoint.getLatitude());
		System.out.println("경도 getLongitude : " + searchpoint.getLongitude());

		List<PlacePoint> resultPoint = placeService.searchPlacePoint(searchpoint);
		System.out.println("PlaceId : " + resultPoint.get(0).getPlaceId());
		List<Place> resultPlace = placeService.selectPlaceList(resultPoint);// 숙소정보
		System.out.println("PlaceName : " + resultPlace.get(0).getPlaceName());
		List<PlaceFile> resultFileOne = placeFileService.selectOneList(resultPoint);
		System.out.println("resultPoint.size : " + resultPoint.size());

		// Ajax
		JSONObject jsonObject = new JSONObject();// PlacePoint객체오브젝트
		JSONArray jsonArray = new JSONArray();

		int pointId, placeId, fileId;

		for (int i = 0; i < resultPoint.size(); i++) {
			pointId = resultPoint.get(i).getPlaceId(); 
			placeId = resultPlace.get(i).getPlaceId();
			fileId = resultFileOne.get(i).getPlaceId();
			//System.out.println(pointId+","+placeId+","+fileId);
			
			if ((pointId == placeId) && (placeId == fileId)) {
				JSONObject pObject = new JSONObject();
				pObject.put("placeId", resultPoint.get(i).getPlaceId());
				pObject.put("latitude", resultPoint.get(i).getLatitude());
				pObject.put("longitude", resultPoint.get(i).getLongitude());	
				pObject.put("placeName", resultPlace.get(i).getPlaceName());
				pObject.put("placeImage", resultFileOne.get(i).getFilePath());
				jsonArray.add(pObject);
				
			}
		}

		jsonObject.put("pointList", jsonArray);

		String result = jsonObject.toString();
		//System.out.println(result);
		return result;
	}
}
