package com.on.nearbnb.place.model.vo;

public class Coords {
	private double latitude;
	private double longitude;
	
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
	
	public Coords() {
	}
	
	
	public Coords(double latitude, double longitude) {
		this.latitude = latitude;
		this.longitude = longitude;
	}
	
	@Override
	public String toString() {
		return "Coords [latitude=" + latitude + ", longitude=" + longitude + "]";
	}
	
	
	
	
}
