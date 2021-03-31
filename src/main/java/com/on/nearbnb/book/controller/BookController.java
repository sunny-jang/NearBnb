package com.on.nearbnb.book.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
}
