package com.on.nearbnb.place.model.vo;

public class ExtendedPlace {
	private String latitude;
	private String longitude;
	private String imagePath;
	private Place place;
	
	
	
	@Override
	public String toString() {
		return "ExtendedPlace [latitude=" + latitude + ", longitude=" + longitude + ", imagePath=" + imagePath
				+ ", place=" + place + "]";
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public Place getPlace() {
		return place;
	}
	public void setPlace(Place place) {
		this.place = place;
	}
	
	
	
}
