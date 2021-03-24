package com.on.nearbnb.board.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.board.model.vo.Board;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertBoard(Board board) {
		int cnt = sqlSession.insert("Board.insertBoard", board);
		return cnt;
	}
}
