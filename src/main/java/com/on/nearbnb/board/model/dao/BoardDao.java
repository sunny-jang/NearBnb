package com.on.nearbnb.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.board.model.vo.Board;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 게시글 목록 조회
	public List<Board> selectBoardList(){
		List<Board> boardList = sqlSession.selectList("Board.selectBoardList");
		return boardList;
	}
	
	// 게시글 등록하기
	public int insertBoard(Board board) {
		int cnt = sqlSession.insert("Board.insertBoard", board);
		return cnt;
	}
	
	// 게시글 수정하기
	public int updateBoard(Board board) {
		int cnt = sqlSession.update("Board.updateBoard", board);
		return cnt;
	}
}
