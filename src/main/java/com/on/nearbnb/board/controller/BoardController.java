package com.on.nearbnb.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardThumb;
import com.on.nearbnb.board.service.BoardService;

@Controller
public class BoardController {

	// BoardService DI
	@Autowired
	BoardService boardService;
	
//	private String boardListAgain = "redirect:/board.do/";
	
	// 게시판 목록 조회
	@RequestMapping(value = "board.do", method = RequestMethod.GET)
	public ModelAndView boardListService(@RequestParam(name = "page", defaultValue = "1") int page,
			ModelAndView modelAndView) {
		try {		
			// 현재 페이지
			int currentPage = page;
			
			// 게시글 전체 글 개수 조회
			int boardListCount = boardService.boardListCount();
			
			// 마지막 페이지
			int maxPage = (int) ((double) boardListCount / 15 + 1);
			
			// 게시글 목록
			modelAndView.addObject("boardList", boardService.selectBoardList(currentPage, 15));

			// 페이지 단
			modelAndView.addObject("currentPage", currentPage);
			modelAndView.addObject("maxPage", maxPage);
			
			modelAndView.addObject("boardListCount", boardListCount);
			modelAndView.setViewName("community/board");
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
	// 게시글 상세 조회
	@RequestMapping(value = "boadSelectOneCon.do", method = RequestMethod.GET)
	public ModelAndView boardSelectOneService(int boardCodeSeq,
			ModelAndView modelAndView) {

		Board board = boardService.selectBoardOne(boardCodeSeq);

		BoardThumb boardThumb = boardService.selectBoardThumb(boardCodeSeq);

		modelAndView.addObject("boardThumb", boardThumb);
		modelAndView.addObject("board", board);
		modelAndView.setViewName("community/boardRead");
		
		return modelAndView;
	}
	
//	// 게시글 추천 기능
//	@RequestMapping(value = "thumb.do", method = RequestMethod.POST)
//	public ModelAndView boardThumbsService(int boardCodeSeq, int thumbs, ModelAndView modelAndView) {
//		
//	}
	
	// 게시글 등록하기
	@RequestMapping(value = "boardWriteCon.do", method = RequestMethod.POST)
	public ModelAndView boardInsertService(Board board, ModelAndView modelAndView) throws ServletException, IOException {
		boardService.insertBoard(board);
		
		// 목록 돌아감
		modelAndView.setViewName("community/board");
		
		return modelAndView;
	}
	
	// 게시글 수정 페이지
	@RequestMapping(value = "boardUpdateProCon.do", method = RequestMethod.GET)
	public ModelAndView boardUpdateProService(int boardCodeSeq, ModelAndView modelAndView) {
		Board board = boardService.selectBoardOne(boardCodeSeq);
		modelAndView.addObject("board", board);
		modelAndView.setViewName("community/boardRewrite");
		
		return modelAndView;
	}
	
	
	// 게시글 수정하기
	@RequestMapping(value = "boardUpdateCon.do", method = RequestMethod.POST)
	public String boardUpdateService(Board board, ModelAndView modelAndView) {
		boardService.updateBoard(board);
		
		// 목록 돌아감
		return "redirect:/board.do";	
	}
	
	// 게시글 삭제하기
	@RequestMapping(value = "boardDeleteProCon.do", method = RequestMethod.GET)
	public ModelAndView boardDeleteProCon(int boardCodeSeq, ModelAndView modelAndView) {
		
		Board board = boardService.selectBoardOne(boardCodeSeq);
		
		modelAndView.addObject("board", board);
		modelAndView.setViewName("community/boardDelete");
		
		return modelAndView;
	}
	
	// 게시글 삭제하기
	@RequestMapping(value = "boardDeleteCon.do", method = RequestMethod.POST)
	public String boardDeleteCon(Board board, ModelAndView modelAndView) {
		boardService.deleteBoard(board);
		
		// 목록 돌아감
		return "redirect:/board.do";
	}
}
