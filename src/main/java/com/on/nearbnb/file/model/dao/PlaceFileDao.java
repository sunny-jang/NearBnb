package com.on.nearbnb.file.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;

@Repository
public class PlaceFileDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Transactional
	public int insertPlaceFile(List<PlaceFile> placeFile, Integer placeId) {
		for (PlaceFile file : placeFile) {
			file.setPlaceId(placeId);
		}
		return sqlSession.insert("insertPlaceFile", placeFile);
	}
	
	public List<PlaceFile> selectFiles(Integer pId) {
		return sqlSession.selectList("selectFiles", pId);
	}
	
	public List<PlaceFile> selectOneList(List<PlacePoint> resultPoint) {//메인페이지
		return sqlSession.selectList("selectOneList",resultPoint); 
	}
}
