package com.on.nearbnb.board.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardComment;
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
	public int boardListCount(Board board) {
		return sqlSession.selectOne("Board.boardListCount", board);
	}
	
	// 베스트 게시글 5개 조회
	public List<Board> selectBestList(){
		List<Board> bestList = sqlSession.selectList("Board.selectBestList");
		return bestList;
	}
	
	// 게시글 검색
	public List<Board> searchBoard(HashMap searchMap){
		return sqlSession.selectList("Board.boardSearch", searchMap);
	}
	
	// 게시글 분류
	public List<Board> searchBoardType(Board board){
		return sqlSession.selectList("Board.boardTypeSearch", board);
	}
		
	// 게시글 추천 개수 조회
	public int boardThumbCount(int boardCodeSeq) {
		return sqlSession.selectOne("Board.boardThumbCount", boardCodeSeq);
	}
	
	// 게시글 상세 조회
	public Board selectBoardOne(int boardCodeSeq) {
		Board board = sqlSession.selectOne("Board.selectBoardOne", boardCodeSeq);
		return board;
	}
	
	// 게시글 등록
	public int insertBoard(Board board) {
		int cnt = sqlSession.insert("Board.insertBoard", board);
		return cnt;
	}
	
	// 게시글 추천
	public int insertBoardThumb(BoardThumb boardThumb) {
		int cnt = sqlSession.insert("Board.insertBoardThumb", boardThumb);
		return cnt;
	}
	
	// 게시글 추천 취소
	public int deleteBoardThumb(BoardThumb boardThumb) {
		int cnt = sqlSession.delete("Board.deleteBoardThumb", boardThumb);
		return cnt;
	}
	
	// 게시글 추천 조회
	public BoardThumb selectBoardThumb(BoardThumb boardThumb) {
		return sqlSession.selectOne("Board.selectBoardThumb", boardThumb);
	}
	
	// 게시글 수정
	public int updateBoard(Board board) {
		int cnt = sqlSession.update("Board.updateBoard", board);
		return cnt;
	}
	
	// 게시글 삭제
	public int deleteBoard(int boardCodeSeq) {
		int cnt = sqlSession.delete("Board.deleteBoard", boardCodeSeq);
		return cnt;
	}
	
	// 게시글 추천 삭제
	public int deleteBoardThumbAll(int boardCodeSeq) {
		int cnt = sqlSession.delete("Board.deleteBoardThumbAll", boardCodeSeq);
		return cnt;
	}
	
	// 댓글 조회
	public List<BoardComment> selectBoardCommentList(int boardCodeSeq){
		List<BoardComment> boardComment = sqlSession.selectList("Board.selectBoardCommentList", boardCodeSeq);
		return boardComment;
	}
	
	// 해당 게시글 댓글 개수 조회
	public int selectBoardCommentCount(int boardCodeSeq) {
		int cnt = sqlSession.selectOne("Board.selectBoardCommentCount", boardCodeSeq);
		return cnt;
	}
	
	// 댓글 작성
	public int insertBoardComment(BoardComment boardComment) {
		int cnt = sqlSession.insert("Board.insertBoardComment", boardComment);
		return cnt;
	}
}
