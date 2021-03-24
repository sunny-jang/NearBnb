package com.on.nearbnb.place.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.place.model.dao.PlaceDao;
import com.on.nearbnb.place.model.vo.Place;

@Service
public class placeServiceImpl implements PlaceService {
	
	@Autowired
	private PlaceDao pdao;

	@Override
	public int insertPlace(Place place) {
		// TODO Auto-generated method stub
		return pdao.insertPlace(place);
	}
}
