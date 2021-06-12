package com.on.nearbnb.book.service;

import java.util.HashMap;
import java.util.List;

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

	@Override
	public List<Book> selectBook(Book book) {
		return bookDao.selectBook(book);
	}

	@Override
	public int deleteBook(String bookId) {		
		return bookDao.deleteBook(bookId);
	}

	@Override
	public List<Book> selectRangedBook(HashMap books) {
		// TODO Auto-generated method stub
		return bookDao.selectRangedtBook(books);
	}
	
	
	
}
