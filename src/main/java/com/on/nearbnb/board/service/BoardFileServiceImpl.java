package com.on.nearbnb.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.board.model.dao.BoardFileDao;
import com.on.nearbnb.board.model.vo.BoardFile;

@Service
public class BoardFileServiceImpl implements BoardFileService{

	@Autowired
	private BoardFileDao boardFileDao;
	
	// 파일 업로드
	@Override
	public int insertBoardFile(BoardFile boardFile, int boardCodeSeq) {
		return boardFileDao.insertBoardFile(boardFile, boardCodeSeq);
	}
	
	// 파일 조회
	@Override
	public BoardFile selectBoardFile(int boardCodeSeq){
		return boardFileDao.selectBoardFile(boardCodeSeq);
	}
	
	// 파일 삭제
	@Override
	public int deleteBoardFile(int boardCodeSeq) {
		return boardFileDao.deleteBoardFile(boardCodeSeq);
	}
	
}
