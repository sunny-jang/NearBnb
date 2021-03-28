package com.on.nearbnb.board.model.vo;

import org.springframework.stereotype.Component;

@Component
public class BoardThumb {
	
	private int boardCodeSeq;
	private String userId;
	
	public int getBoardCodeSeq() {		return boardCodeSeq;	}
	public void setBoardCodeSeq(int boardCodeSeq) {		this.boardCodeSeq = boardCodeSeq;	}
	public String getUserId() {		return userId;	}
	public void setUserId(String userId) {		this.userId = userId;	}
	
}
