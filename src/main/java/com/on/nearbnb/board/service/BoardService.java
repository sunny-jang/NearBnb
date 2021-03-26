package com.on.nearbnb.board.service;

import java.util.List;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardThumb;

public interface BoardService {
	
	// 게시글 목록 조회
	public List<Board> selectBoardList(int startPage, int endPage);
	
	// 게시글 전체 글 개수 조회
	public int boardListCount();

	// 게시글 추천 조회
	public BoardThumb selectBoardThumb(int boardCodeSeq);
	
	// 게시글 상세 조회
	public Board selectBoardOne(int boardCodeSeq);
	
	// 게시글 등록하기
	public int insertBoard(Board board);
	
	// 게시글 수정하기
	public int updateBoard(Board board);
	
	// 게시글 삭제하기
	public int deleteBoard(Board board);
	
//	public int totalCount();
//	public List<Board> selectList(int startPage, int limit);
//	public List<Board> selectSearch(String keyword);
}
