package com.on.nearbnb.place.model.vo;

import java.util.Date;

public class Place {
	private Integer placeId;
	private String placeName;
	private String placeAddress;
	private String placeaddressDetail;
	private String maxGuest;
	private String placeType;
	private String placePrice;
	private String hostPhone;
	private String placeKakaoLink;
	private String placeOpenDate;
	private String placeCloseDate;
	private String placeDesc;
	
	
	
	public Integer getPlaceId() {
		return placeId;
	}
	public void setPlaceId(Integer placeId) {
		this.placeId = placeId;
	}
	public String getPlacePrice() {
		return placePrice;
	}
	public void setPlacePrice(String placePrice) {
		this.placePrice = placePrice;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getPlaceAddress() {
		return placeAddress;
	}
	public void setPlaceAddress(String placeaddress) {
		this.placeAddress = placeaddress;
	}
	public String getPlaceaddressDetail() {
		return placeaddressDetail;
	}
	public void setPlaceaddressDetail(String placeaddressDetail) {
		this.placeaddressDetail = placeaddressDetail;
	}
	public String getMaxGuest() {
		return maxGuest;
	}
	public void setMaxGuest(String maxGuest) {
		this.maxGuest = maxGuest;
	}
	public String getPlaceType() {
		return placeType;
	}
	public void setPlaceType(String placeType) {
		this.placeType = placeType;
	}
	public String getHostPhone() {
		return hostPhone;
	}
	public void setHostPhone(String hostPhone) {
		this.hostPhone = hostPhone;
	}
	public String getPlaceKakaoLink() {
		return placeKakaoLink;
	}
	public void setPlaceKakaoLink(String hostKakaoLink) {
		this.placeKakaoLink = hostKakaoLink;
	}
	public String getPlaceOpenDate() {
		return placeOpenDate;
	}
	public void setPlaceOpenDate(String placeOpenDate) {
		this.placeOpenDate = placeOpenDate;
	}
	public String getPlaceCloseDate() {
		return placeCloseDate;
	}
	public void setPlaceCloseDate(String placeCloseDate) {
		this.placeCloseDate = placeCloseDate;
	}
	public String getPlaceDesc() {
		return placeDesc;
	}
	public void setPlaceDesc(String placeDesc) {
		this.placeDesc = placeDesc;
	}
	
	@Override
	public String toString() {
		return "Place [placeName=" + placeName + ", placeaddress=" + placeAddress + ", placeaddressDetail="
				+ placeaddressDetail + ", maxGuest=" + maxGuest + ", placeType=" + placeType + ", hostPhone="
				+ hostPhone + ", hostKakaoLink=" + placeKakaoLink + ", placeOpenDate=" + placeOpenDate
				+ ", placeCloseDate=" + placeCloseDate + ", placeDesc=" + placeDesc + "]";
	}
	
	
	
}
