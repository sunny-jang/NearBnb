package com.on.nearbnb.board.model.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class Board {

	private String userId;
	private String boardTitle;
	private String boardContent;
	private String boardType;
	private Date boardDate;
	private int boardThumb;
	private int boardCount;
	
	public String getUserId() {		return userId;	}
	public void setUserId(String userId) {		this.userId = userId;	}
	public String getBoardTitle() {		return boardTitle;	}
	public void setBoardTitle(String boardTitle) {		this.boardTitle = boardTitle;	}
	public String getBoardContent() {		return boardContent;	}
	public void setBoardContent(String boardContent) {		this.boardContent = boardContent;	}
	public String getBoardType() {		return boardType;	}
	public void setBoardType(String boardType) {		this.boardType = boardType;	}
	public Date getBoardDate() {		return boardDate;	}
	public void setBoardDate(Date boardDate) {		this.boardDate = boardDate;	}
	public int getBoardThumb() {		return boardThumb;	}
	public void setBoardThumb(int boardThumb) {		this.boardThumb = boardThumb;	}
	public int getBoardCount() {		return boardCount;	}
	public void setBoardCount(int boardCount) {		this.boardCount = boardCount;	}
	
}
