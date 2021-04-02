package com.on.nearbnb.place.model.vo;

public class PlacePoint {
	
	private Integer placeId;
	
	private double latitude;
	private double longitude;
	
	
	
	public Integer getPlaceId() {
		return placeId;
	}
	public void setPlaceId(Integer placeId) {
		this.placeId = placeId;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	
	public PlacePoint() {
	}
	
	
	public PlacePoint(double latitude, double longitude) {
		this.latitude = latitude;
		this.longitude = longitude;
	}
	
	@Override
	public String toString() {
		return "Coords [latitude=" + latitude + ", longitude=" + longitude + "]";
	}
	
	
	
	
}
