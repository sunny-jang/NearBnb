package com.on.nearbnb.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.board.model.dao.BoardDao;
import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardThumb;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	// 게시판 목록 조회
	@Override
	public List<Board> selectBoardList(int startPage, int endPage){
		return boardDao.selectBoardList(startPage, endPage);
	}
	
	// 게시글 전체 글 개수 조회
	@Override
	public int boardListCount() {
		return boardDao.boardListCount();
	}
	
	// 베스트 게시글 5개 조회
	@Override
	public List<Board> selectBestList(){
		return boardDao.selectBestList();
	}
	
	// 게시판 추천 개수 조회
	@Override
	public int boardThumbCount(int boardCodeSeq) {
		return boardDao.boardThumbCount(boardCodeSeq);
	}
	
	// 게시글 상세 조회
	@Override
	public Board selectBoardOne(int boardCodeSeq) {
		return boardDao.selectBoardOne(boardCodeSeq);
	}
	
	// 게시글 등록
	@Override
	public int insertBoard(Board board) {
		return boardDao.insertBoard(board);
	}
	
	// 게시글 추천
	@Override
	public int insertBoardThumb(BoardThumb boardThumb) {
		return boardDao.insertBoardThumb(boardThumb);
	}
	
	// 게시글 추천 취소
	@Override
	public int deleteBoardThumb(BoardThumb boardThumb) {
		return boardDao.deleteBoardThumb(boardThumb);
	}
	
	// 게시글 추천 조회
	@Override
	public BoardThumb selectBoardThumb(BoardThumb boardThumb) {
		return boardDao.selectBoardThumb(boardThumb);
	}
	
	// 게시글 수정
	@Override
	public int updateBoard(Board board) {
		return boardDao.updateBoard(board);
	}
	
	// 게시글 삭제
	@Override
	public int deleteBoard(int boardCodeSeq) {
		return boardDao.deleteBoard(boardCodeSeq);
	}
	
	// 게시글 추천 삭제
	@Override
	public int deleteBoardThumbAll(int boardCodeSeq) {
		return boardDao.deleteBoardThumbAll(boardCodeSeq);
	}

}
