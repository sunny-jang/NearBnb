package com.on.nearbnb.place.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.place.model.vo.Place;

import com.on.nearbnb.place.model.vo.PlacePoint;

import com.on.nearbnb.place.model.vo.PlaceThumb;


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

	// 숙소 코드로 숙소 명 조회
	public String selectPlaceName(Integer pId) {
		return sqlSession.selectOne("selectPlaceName",pId);
	}
	
	// 게시글 추천 개수 조회
	public int placeThumbCount(int placeId) {
		return sqlSession.selectOne("Place.placeThumbCount", placeId);
	}
	
	// 추천 조회
	public PlaceThumb selectPlaceThumb(PlaceThumb placeThumb) {
		return sqlSession.selectOne("Place.selectPlaceThumb", placeThumb);
	}
	
	// 추천하기
	public int insertPlaceThumb(PlaceThumb placeThumb) {
		return sqlSession.insert("Place.insertPlaceThumb", placeThumb);
	}
	
	// 추천 취소
	public int deletePlaceThumb(PlaceThumb placeThumb) {
		return sqlSession.delete("Place.deletePlaceThumb", placeThumb);
	}

	// 마이페이지용 숙소 코드로 조회(상세 조회)
	public Place selectPlaceForModal(Integer pId) {		
		return sqlSession.selectOne("Place.selectPlaceForModal", pId);
	}	


	//foreach문 place정보조회 (임시)
	public List<Place>selectSearchPlace(List<PlacePoint> resultPoint){
		return sqlSession.selectList("selectSearchPlace",resultPoint);
	}
} 



