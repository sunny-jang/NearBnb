package com.on.nearbnb.book.model.vo;

public class Book {
	private String uId;
	private String pId;
	private String bookCheckIn;
	private String bookCheckOut;
	private String bookPerson;
	private String bookPayPrice;
	private String bookPayDate;
	
	@Override
	public String toString() {
		return "Book [uId=" + uId + ", pId=" + pId + ", bookCheckIn=" + bookCheckIn + ", bookCheckOut=" + bookCheckOut
				+ ", bookPerson=" + bookPerson + ", bookPayPrice=" + bookPayPrice + ", bookPayDate=" + bookPayDate
				+ "]";
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getBookCheckIn() {
		return bookCheckIn;
	}
	public void setBookCheckIn(String bookCheckIn) {
		this.bookCheckIn = bookCheckIn;
	}
	public String getBookCheckOut() {
		return bookCheckOut;
	}
	public void setBookCheckOut(String bookCheckOut) {
		this.bookCheckOut = bookCheckOut;
	}
	public String getBookPerson() {
		return bookPerson;
	}
	public void setBookPerson(String bookPerson) {
		this.bookPerson = bookPerson;
	}
	public String getBookPayPrice() {
		return bookPayPrice;
	}
	public void setBookPayPrice(String bookPayPrice) {
		this.bookPayPrice = bookPayPrice;
	}
	public String getBookPayDate() {
		return bookPayDate;
	}
	public void setBookPayDate(String bookPayDate) {
		this.bookPayDate = bookPayDate;
	}
	
	
	
}
