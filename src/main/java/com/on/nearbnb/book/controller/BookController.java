package com.on.nearbnb.book.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.book.model.vo.Book;
import com.on.nearbnb.book.service.BookService;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.service.PlaceService;

@Controller
public class BookController {
	@Autowired
	BookService bookService;
	
	@Autowired
	PlaceService placeService;
	
	@RequestMapping(value = "/placePayment.do", method = RequestMethod.GET)
	public ModelAndView placePayment(Integer pId, ModelAndView modelAndView) {
		Place place = placeService.selectPlace(pId);
		
		modelAndView.addObject("place", place);
		modelAndView.setViewName("/place/placePayment");
		return modelAndView;
	}
	
	@RequestMapping(value="registerBook.do", method=RequestMethod.POST)
	@ResponseBody
	public String insertBook(Book book, HttpServletResponse response) throws Exception {
		response.setContentType("application/json; charset=utf-8");		
		JSONObject sendJson = new JSONObject();
		System.out.println(book);
		int cnt = bookService.insertBook(book);		
		if(cnt == 1) {
			sendJson.put("ok", URLEncoder.encode("성공", "utf-8"));
			return sendJson.toJSONString();
		} else {
			sendJson.put("fail", URLEncoder.encode("실패", "utf-8"));
			return sendJson.toJSONString();
		}
	}
}
