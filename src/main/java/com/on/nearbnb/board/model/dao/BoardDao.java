package com.on.nearbnb.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardPage;
import com.on.nearbnb.board.model.vo.BoardThumb;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 게시글 목록 조회
	public List<Board> selectBoardList(int startPage, int endPage){
		int startRow = (startPage - 1) * endPage;
		BoardPage boardPage = new BoardPage();
		boardPage.setStartPage(startRow+1);
		boardPage.setEndPage(startRow+15);
		List<Board> boardList = sqlSession.selectList("Board.selectBoardList", boardPage);
		return boardList;
	}
	
	// 게시글 전체 글 개수 조회
	public int boardListCount() {
		return sqlSession.selectOne("Board.boardListCount");
	}
	
	// 게시글 추천 조회
	public BoardThumb selectBoardThumb(int boardCodeSeq) {
		BoardThumb boardThumb = sqlSession.selectOne("Board.selectBoardThumb", boardCodeSeq);
		return boardThumb;
	}
	
	// 게시글 상세 조회
	public Board selectBoardOne(int boardCodeSeq) {
		Board board = sqlSession.selectOne("Board.selectBoardOne", boardCodeSeq);
		return board;
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
	
	// 게시글 삭제하기
	public int deleteBoard(Board board) {
		int cnt = sqlSession.delete("Board.deleteBoard", board);
		return cnt;
	}
}
