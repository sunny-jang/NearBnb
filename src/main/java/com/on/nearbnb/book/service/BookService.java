package com.on.nearbnb.book.service;

import java.util.HashMap;
import java.util.List;

import com.on.nearbnb.book.model.vo.Book;

public interface BookService {
	public int insertBook(Book book);
	public List<Book> selectBook(Book book);
	public int deleteBook(String bookId);
	public List<Book> selectRangedBook(HashMap books);
}
