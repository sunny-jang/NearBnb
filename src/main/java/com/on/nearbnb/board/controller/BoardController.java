package com.on.nearbnb.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.service.BoardService;

@Controller
public class BoardController {

	// BoardService DI
	@Autowired
	BoardService boardService;
	
	// 게시판 목록 조회
	@RequestMapping(value = "board.do", method = RequestMethod.GET)
	public ModelAndView boardListService(ModelAndView modelAndView) {
		System.out.println("컨트롤러");
		List<Board> boardList = boardService.selectBoardList();
		System.out.println(boardList);
		modelAndView.addObject("boardList", boardList);
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
	// 게시글 등록하기
	@RequestMapping(value = "boardWriteCon.do", method = RequestMethod.POST)
	public ModelAndView boardInsertService(Board board, ModelAndView modelAndView) {
		
		int result = boardService.insertBoard(board);
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
	// 게시글 수정하기
	@RequestMapping(value = "boardUpdateCon.do", method = RequestMethod.POST)
	public ModelAndView boardUpdateService(Board board, ModelAndView modelAndView) {
		
		int result = boardService.updateBoard(board);
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
}
