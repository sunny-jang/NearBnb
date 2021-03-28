package com.on.nearbnb.place.model.vo;

import java.util.Date;

public class Place {
	private Integer placeId;
	private String uId;
	private String placeName;
	private String placeAddress;
	private String placeAddressDetail;
	private String maxGuest;
	private String placeType;
	private String placePrice;
	private String hostPhone;
	private String placeKakaoLink;
	private String placeOpenDate;
	private String placeCloseDate;
	private String placeDesc;
	private String placeThumb;
	
	public String getPlaceThumb() {
		return placeThumb;
	}
	public void setPlaceThumb(String placeThumb) {
		this.placeThumb = placeThumb;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
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
	public String getPlaceAddressDetail() {
		return placeAddressDetail;
	}
	public void setPlaceAddressDetail(String placeAddressDetail) {
		this.placeAddressDetail = placeAddressDetail;
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
		return "Place [placeId=" + placeId + ", uId=" + uId + ", placeName=" + placeName + ", placeAddress="
				+ placeAddress + ", placeAddressDetail=" + placeAddressDetail + ", maxGuest=" + maxGuest
				+ ", placeType=" + placeType + ", placePrice=" + placePrice + ", hostPhone=" + hostPhone
				+ ", placeKakaoLink=" + placeKakaoLink + ", placeOpenDate=" + placeOpenDate + ", placeCloseDate="
				+ placeCloseDate + ", placeDesc=" + placeDesc + "]";
	}
}
