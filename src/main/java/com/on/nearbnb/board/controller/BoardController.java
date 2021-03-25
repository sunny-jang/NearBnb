package com.on.nearbnb.board.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;

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
		List<Board> boardList = boardService.selectBoardList();
		modelAndView.addObject("boardList", boardList);
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
	// 게시글 상세 조회
	@RequestMapping(value = "boadSelectOneCon.do", method = RequestMethod.GET)
	public ModelAndView boardSelectOneService(int boardCodeSeq, ModelAndView modelAndView) {
		Board board = boardService.selectBoardOne(boardCodeSeq);
		modelAndView.addObject("board", board);
		modelAndView.setViewName("community/boardRead");
		
		return modelAndView;
		
	}
	
	// 게시글 등록하기
	@RequestMapping(value = "boardWriteCon.do", method = RequestMethod.POST)
	public ModelAndView boardInsertService(Board board, ModelAndView modelAndView) throws ServletException, IOException {
		boardService.insertBoard(board);
		
		List<Board> boardList = boardService.selectBoardList();
		modelAndView.addObject("boardList", boardList);
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
	// 게시글 수정하기
	@RequestMapping(value = "boardUpdateCon.do", method = RequestMethod.POST)
	public ModelAndView boardUpdateService(Board board, ModelAndView modelAndView) {
		
		boardService.updateBoard(board);
		
		List<Board> boardList = boardService.selectBoardList();
		modelAndView.addObject("boardList", boardList);
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
}
