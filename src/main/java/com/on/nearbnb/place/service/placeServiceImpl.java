package com.on.nearbnb.place.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.on.nearbnb.file.model.dao.PlaceFileDao;
import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.dao.PlaceDao;
import com.on.nearbnb.place.model.dao.PlacePointDao;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;

@Service
public class placeServiceImpl implements PlaceService {

	@Autowired
	private PlaceDao pDao;

	@Autowired
	private PlacePointDao pPointDao;

	@Autowired
	private PlaceFileDao pFileDao;

	@Transactional
	@Override
	public int insertPlace(Place place, PlacePoint placePoint, List<PlaceFile> placeFile) {
		// TODO Auto-generated method
		pDao.insertPlace(place);
		 
		placePoint.setPlaceId(place.getPlaceId());
		pPointDao.insertPlacePoint(placePoint);
		pFileDao.insertPlaceFile(placeFile, place.getPlaceId());

		return 0;
	}

	@Override
	public int insertPlacePoint(PlacePoint placePoint) {
		// TODO Auto-generated method stub
		return pPointDao.insertPlacePoint(placePoint);
	}

	@Override
	public Place selectPlace(Integer pId) {
		return pDao.selectPlace(pId);
	}
}
