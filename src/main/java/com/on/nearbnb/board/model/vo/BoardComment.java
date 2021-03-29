package com.on.nearbnb.board.model.vo;

import java.util.Date;

public class BoardComment {

	private int commentCodeSeq;
	private int boardCodeSeq;
	private String userId;
	private String commentContent;
	private Date commentDate;
	
	public int getCommentCodeSeq() {		return commentCodeSeq;	}
	public void setCommentCodeSeq(int commentCodeSeq) {		this.commentCodeSeq = commentCodeSeq;	}
	public int getBoardCodeSeq() {		return boardCodeSeq;	}
	public void setBoardCodeSeq(int boardCodeSeq) {		this.boardCodeSeq = boardCodeSeq;	}
	public String getUserId() {		return userId;	}
	public void setUserId(String userId) {		this.userId = userId;	}
	public String getCommentContent() {		return commentContent;	}
	public void setCommentContent(String commentContent) {		this.commentContent = commentContent;	}
	public Date getCommentDate() {		return commentDate;	}
	public void setCommentDate(Date commentDate) {		this.commentDate = commentDate;	}
		
}
