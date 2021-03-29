package com.on.nearbnb.place.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;

@Transactional(rollbackFor = Exception.class)
public interface PlaceService {
	
	public int insertPlace(Place place, PlacePoint placePoint, List<PlaceFile>placeFile);
	public int insertPlacePoint(PlacePoint placePoint);
	public Place selectPlace(Integer pId);
	public List<Place> selectPlaceById(String uId);
}
