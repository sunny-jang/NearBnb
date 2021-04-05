package com.on.nearbnb.file.model.vo;

public class MemberProfile {
	
	private String userId;
	private String profileName;
	private String profilePath;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getProfileName() {
		return profileName;
	}
	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}
	public String getProfilePath() {
		return profilePath;
	}
	public void setProfilePath(String profilePath) {
		this.profilePath = profilePath;
	}
	
	@Override
	public String toString() {
		return "MemberProfile [userId=" + userId + ", profileName=" + profileName + ", profilePath=" + profilePath
				+ "]";
	}
	
	

}

