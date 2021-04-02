package com.on.nearbnb.board.service;

import com.on.nearbnb.board.model.vo.BoardFile;

public interface BoardFileService {
	
	// 파일 업로드
	public int insertBoardFile(BoardFile boardFile, int boardCodeSeq);
	
	// 파일 조회
	public BoardFile selectBoardFile(int boardCodeSeq);
	
	// 파일 삭제
	public int deleteBoardFile(int boardCodeSeq);
}
