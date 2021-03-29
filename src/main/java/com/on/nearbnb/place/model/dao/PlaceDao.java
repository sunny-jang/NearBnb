package com.on.nearbnb.place.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.place.model.vo.Place;

@Repository
public class PlaceDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertPlace(Place place) {
		return sqlSession.insert("insertPlace", place);
	}
	
	public Place selectPlace(Integer pId) {
		return sqlSession.selectOne("selectPlace", pId);
	}
	
	public List<Place> selectPlaceById(String uId) {		
		return sqlSession.selectList("Place.selectPlaceById", uId);
	}
}
