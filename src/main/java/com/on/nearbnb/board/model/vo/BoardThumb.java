package com.on.nearbnb.board.model.vo;

import org.springframework.stereotype.Component;

@Component
public class BoardThumb {
	
	private int boardCodeSeq;
	private String userId;
	private int boardThumb;
	
	public int getBoardCodeSeq() {		return boardCodeSeq;	}
	public void setBoardCodeSeq(int boardCodeSeq) {		this.boardCodeSeq = boardCodeSeq;	}
	public String getUserId() {		return userId;	}
	public void setUserId(String userId) {		this.userId = userId;	}
	public int getBoardThumb() {		return boardThumb;	}
	public void setBoardThumb(int boardThumb) {		this.boardThumb = boardThumb;	}
}
