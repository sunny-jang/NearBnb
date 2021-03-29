package com.on.nearbnb.board.service;

import java.util.HashMap;
import java.util.List;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardComment;
import com.on.nearbnb.board.model.vo.BoardThumb;

public interface BoardService {
	
	// 게시글 목록 조회
	public List<Board> selectBoardList(int startPage, int endPage);
	
	// 게시글 전체 글 개수 조회
	public int boardListCount(Board board);
	
	// 베스트 게시글 5개 조회
	public List<Board> selectBestList();
	
	// 게시글 검색
	public List<Board> searchBoard(HashMap searchMap);
	
	// 게시글 분류
	public List<Board> searchBoardType(Board board);

	// 게시글 추천 개수 조회
	public int boardThumbCount(int boardCodeSeq);
	
	// 게시글 상세 조회
	public Board selectBoardOne(int boardCodeSeq);
	
	// 게시글 등록
	public int insertBoard(Board board);
	
	// 게시글 추천
	public int insertBoardThumb(BoardThumb boardThumb);
	
	// 게시글 추천 취소
	public int deleteBoardThumb(BoardThumb boardThumb);
	
	// 게시글 추천 조회
	public BoardThumb selectBoardThumb(BoardThumb boardThumb);
	
	// 게시글 수정
	public int updateBoard(Board board);
	
	// 게시글 삭제
	public int deleteBoard(int boardCodeSeq);
	
	// 게시글 추천 삭제
	public int deleteBoardThumbAll(int boardCodeSeq);
	
	// 댓글 조회
	public List<BoardComment> selectBoardCommentList(int boardCodeSeq);
	
	// 해당 게시글 댓글 개수 조회
	public int selectBoardCommentCount(int boardCodeSeq);
	
	// 댓글 작성
	public int insertBoardComment(BoardComment boardComment);
}
