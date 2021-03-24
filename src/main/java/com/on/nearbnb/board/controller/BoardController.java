package com.on.nearbnb.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.service.BoardService;

@Controller
public class BoardController {

	@Autowired	// DI덕에 자동으로 맵핑된다.
	BoardService boardService;
	
	@RequestMapping(value = "boardWriteCon.do", method = RequestMethod.POST)
	public ModelAndView boardInsertService(Board board, ModelAndView modelAndView) {
		
		int result = boardService.insertBoard(board);
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("community/board");
		
		
		
		return modelAndView;
	}
	
}
