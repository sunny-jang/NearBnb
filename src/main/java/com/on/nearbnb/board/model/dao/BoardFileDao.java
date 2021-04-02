package com.on.nearbnb.board.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.board.model.vo.BoardFile;

@Repository
public class BoardFileDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 파일 업로드
	public int insertBoardFile(BoardFile boardFile, int boardCodeSeq) {
		boardFile.setBoardCodeSeq(boardCodeSeq);

		return sqlSession.insert("BoardFile.insertBoardFile", boardFile);
	}
	
	// 파일 조회
	public BoardFile selectBoardFile(int boardCodeSeq){
		return sqlSession.selectOne("BoardFile.selectBoardFile", boardCodeSeq);
	}
	
	// 파일 삭제
	public int deleteBoardFile(int boardCodeSeq) {
		return sqlSession.delete("BoardFile.deleteBoardFile", boardCodeSeq);
	}
	
}
