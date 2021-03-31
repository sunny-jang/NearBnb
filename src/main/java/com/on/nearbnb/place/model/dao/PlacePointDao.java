package com.on.nearbnb.place.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;

@Repository
public class PlacePointDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Transactional
	public int insertPlacePoint(PlacePoint placePoint) {
		return sqlSession.insert("insertPlacePoint", placePoint);
		
	}
	@Transactional
	public List<PlacePoint> searchPlacePoint(PlacePoint searchpoint) {
		System.out.println("DAO도착");
		return sqlSession.selectList("searchPlacePoint",searchpoint);
	}
}
