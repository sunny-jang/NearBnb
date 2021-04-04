package com.on.nearbnb.file.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.on.nearbnb.file.model.dao.PlaceFileDao;
import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.dao.PlaceDao;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;

@Service
public class PlaceFileServiceImpl implements PlaceFileService {
	
	@Autowired
	private PlaceFileDao pFileDao;
	
	@Override
	public int insertPlaceFile(List<PlaceFile> placeFile, Integer placeId) {
		return pFileDao.insertPlaceFile(placeFile, placeId);
	}

	@Override
	public List<PlaceFile> selectFiles(Integer pId) {
		return pFileDao.selectFiles(pId);
	}
	
	@Override
	public List<PlaceFile> selectOneList(List<PlacePoint> resultPoint){
		return pFileDao.selectOneList(resultPoint);
	}
	
}
