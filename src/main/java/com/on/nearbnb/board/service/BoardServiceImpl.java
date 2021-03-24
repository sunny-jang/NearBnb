package com.on.nearbnb.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.board.model.dao.BoardDao;
import com.on.nearbnb.board.model.vo.Board;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public int insertBoard(Board board) {
		return boardDao.insertBoard(board);
	}

}
