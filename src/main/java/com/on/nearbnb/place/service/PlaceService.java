package com.on.nearbnb.place.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;
import com.on.nearbnb.place.model.vo.PlaceThumb;

@Transactional(rollbackFor = Exception.class)
public interface PlaceService {
	
	// 숙소 등록
	public int insertPlace(Place place, PlacePoint placePoint, List<PlaceFile>placeFile);
	
	// 숙소 위치 등록
	public int insertPlacePoint(PlacePoint placePoint);
	public Place selectPlace(Integer pId);
	public List<Place> selectPlaceById(String uId);

	public List<PlacePoint> searchPlacePoint(PlacePoint searchpoint);

	public String selectPlaceName(Integer pId);
	

	public PlacePoint searchPlacePointOne(Integer pId);


	public String kakaoPay(String placeName, String totalPrice) throws Exception;

	public int placeThumbCount(int placeId);
	
	public PlaceThumb selectPlaceThumb(PlaceThumb placeThumb);
	
	public int insertPlaceThumb(PlaceThumb placeThumb);
	
	public int deletePlaceThumb(PlaceThumb placeThumb);
}
