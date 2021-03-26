package com.on.nearbnb.file.model.vo;

public class PlaceFile {
	private Integer placeId;
	private String fileOriginalName;
	private String fileChangedName;
	private String filePath;
	
	public PlaceFile() {}
	
	public PlaceFile(String fileOriginalName, String fileChangedName, String filePath) {
		this.fileOriginalName = fileOriginalName;
		this.fileChangedName = fileChangedName;
		this.filePath = filePath;
	}
	
	public Integer getPlaceId() {
		return placeId;
	}

	public void setPlaceId(Integer placeId) {
		this.placeId = placeId;
	}

	public String getFileChangedName() {
		return fileChangedName;
	}
	public void setFileChangedName(String fileChangedName) {
		this.fileChangedName = fileChangedName;
	}
	public String getFileOriginalName() {
		return fileOriginalName;
	}
	public void setFileOriginalName(String fileOriginalName) {
		this.fileOriginalName = fileOriginalName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Override
	public String toString() {
		return "PlaceFile [fileChangedName=" + fileChangedName + ", fileOriginalName=" + fileOriginalName
				+ ", filePath=" + filePath + "]";
	}
	
	

}
