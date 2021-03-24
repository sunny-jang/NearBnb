package com.on.nearbnb.board.service;

import java.util.List;

import com.on.nearbnb.board.model.vo.Board;

public interface BoardService {
	
	// 게시글 목록 조회
	public List<Board> selectBoardList();
	
	// 게시글 등록하기
	public int insertBoard(Board board);
	
	// 게시글 수정하기
	public int updateBoard(Board board);
	
//	public int totalCount();
//	public List<Board> selectList(int startPage, int limit);
//	public List<Board> selectSearch(String keyword);
}
