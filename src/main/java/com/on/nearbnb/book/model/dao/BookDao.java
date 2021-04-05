package com.on.nearbnb.book.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.on.nearbnb.book.model.vo.Book;

@Repository
public class BookDao {
	@Autowired
	SqlSession sqlSession;
	
	public int insertBook(Book book) {
		return sqlSession.insert("insertBook", book);
	}
	
	public List<Book> selectBook(Book book) {
		return sqlSession.selectList("selectBook", book);
	}
	
	public int deleteBook(String bookId) {
		return sqlSession.delete("Book.deleteBook", bookId);
	}
}
