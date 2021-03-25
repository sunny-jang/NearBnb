package com.on.nearbnb.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.board.model.dao.BoardDao;
import com.on.nearbnb.board.model.vo.Board;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	// 게시판 목록 조회
	@Override
	public List<Board> selectBoardList(){
		return boardDao.selectBoardList();
	}
	
	// 게시글 상세 조회
	@Override
	public Board selectBoardOne(int boardCodeSeq) {
		return boardDao.selectBoardOne(boardCodeSeq);
	}
	
	// 게시글 등록하기
	@Override
	public int insertBoard(Board board) {
		return boardDao.insertBoard(board);
	}
	
	// 게시글 수정하기
	@Override
	public int updateBoard(Board board) {
		return boardDao.updateBoard(board);
	}

	

}
