package com.on.nearbnb.book.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.on.nearbnb.book.model.dao.BookDao;
import com.on.nearbnb.book.model.vo.Book;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	BookDao bookDao;

	@Override
	public int insertBook(Book book) {
		return bookDao.insertBook(book);
	}
	
}
