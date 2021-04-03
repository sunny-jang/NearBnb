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
	
	// 숙소 등록
	public int insertPlace(Place place) {
		return sqlSession.insert("insertPlace", place);
	}
	
	// 숙소 코드로 조회(상세 조회)
	public Place selectPlace(Integer pId) {
		return sqlSession.selectOne("selectPlace", pId);
	}
	
	// 아이디로 숙소 조회(등록한 숙소 조회)
	public List<Place> selectPlaceById(String uId) {		
		return sqlSession.selectList("Place.selectPlaceById", uId);
	}

	
	// 마이페이지용 숙소 코드로 조회(상세 조회)
	public Place selectPlaceForModal(Integer pId) {		
		return sqlSession.selectOne("Place.selectPlaceForModal", pId);
	}	


}
