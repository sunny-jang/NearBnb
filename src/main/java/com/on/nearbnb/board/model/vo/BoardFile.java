package com.on.nearbnb.board.model.vo;

import org.springframework.stereotype.Component;

@Component
public class BoardFile {

	private String bFileChangedName;
	private int boardCodeSeq;
	private String bFileOriginalName;
	private String bFilePath;
	
	public String getbFileChangedName() {		return bFileChangedName;	}
	public void setbFileChangedName(String bFileChangedName) {		this.bFileChangedName = bFileChangedName;	}
	public int getBoardCodeSeq() {		return boardCodeSeq;	}
	public void setBoardCodeSeq(int boardCodeSeq) {		this.boardCodeSeq = boardCodeSeq;	}
	public String getbFileOriginalName() {		return bFileOriginalName;	}
	public void setbFileOriginalName(String bFileOriginalName) {		this.bFileOriginalName = bFileOriginalName;	}
	public String getbFilePath() {		return bFilePath;	}
	public void setbFilePath(String bFilePath) {		this.bFilePath = bFilePath;	}
		
}
