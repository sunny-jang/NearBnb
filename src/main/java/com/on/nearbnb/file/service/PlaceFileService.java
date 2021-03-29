package com.on.nearbnb.file.service;

import java.io.File;
import java.util.List;

import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.vo.Place;

public interface PlaceFileService {
	
	public int insertPlaceFile(List<PlaceFile> placeFile, Integer placeId);

	public List<PlaceFile> selectFiles(Integer pId);
}
