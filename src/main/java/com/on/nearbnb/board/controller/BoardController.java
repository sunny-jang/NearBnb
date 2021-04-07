package com.on.nearbnb.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardComment;
import com.on.nearbnb.board.model.vo.BoardFile;
import com.on.nearbnb.board.model.vo.BoardThumb;
import com.on.nearbnb.board.service.BoardFileService;
import com.on.nearbnb.board.service.BoardService;

@Controller
public class BoardController {

	// BoardService DI
	@Autowired
	BoardService boardService;
	
	// BoardFileService DI
	@Autowired
	BoardFileService boardFileService;
	
//	private String boardListAgain = "redirect:/board.do/";
	
	// 게시판 목록 조회, 베스트 게시글 5개 조회
	@RequestMapping(value = "board.do", method = RequestMethod.GET)
	public ModelAndView boardListService(@RequestParam(name = "page", defaultValue = "1") int page,
			Board board,
			ModelAndView modelAndView) {
		List<Integer> cntCmt = new ArrayList<Integer>();
		try {		
			// 현재 페이지
			int currentPage = page;
			
			// 게시글 전체 글 개수 조회
			int boardListCount = boardService.boardListCount(board);
			
			// 마지막 페이지
			int maxPage = (int) ((double) boardListCount / 15 + 0.99);
			
			// 베스트 게시글 5개 조회
			modelAndView.addObject("bestList",boardService.selectBestList());
			
			// 게시글 목록
			modelAndView.addObject("boardList", boardService.selectBoardList(currentPage, 15));
			
			// 페이지
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
	
	// 검색 후 출력
	@RequestMapping(value = "printBoardAjaxSearch.do", method = RequestMethod.GET)
	public ModelAndView boardAjaxType(String boardType, String boardContent, HashMap searchMap, ModelAndView modelAndView) {
		try {
			searchMap.put("boardType", boardType);
			searchMap.put("boardContent", boardContent);
			
			// 조회 결과 확인
			modelAndView.addObject("check", searchMap.get("boardContent"));
			
			// 베스트 게시글 5개 조회
			modelAndView.addObject("bestList",boardService.selectBestList());
			
			// 검색 결과
			modelAndView.addObject("boardList", boardService.searchBoard(searchMap));
			
			modelAndView.setViewName("community/board");
			return modelAndView;
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		modelAndView.setViewName("redirect:/board.do");
		return modelAndView;
	}
		
	
	// 게시글 상세 조회
	@RequestMapping(value = "boadSelectOneCon.do", method = RequestMethod.GET)
	public ModelAndView boardSelectOneService(int boardCodeSeq, HttpServletRequest request,
			ModelAndView modelAndView) {

		// 게시글과 총 추천 수, 댓글 가져오기
		Board board = boardService.selectBoardOne(boardCodeSeq);
		int thumbs = boardService.boardThumbCount(boardCodeSeq);
		int boardComments = boardService.selectBoardCommentCount(boardCodeSeq);
		
		// 댓글 가져오기
		List<BoardComment> boardComment = new ArrayList<BoardComment>();

		try {
			// 세션 및 객체 선언
			HttpSession session = request.getSession();
			BoardThumb boardThumb = new BoardThumb();
			
			// 추천 기능의 사전 작업
			boardThumb.setBoardCodeSeq(boardCodeSeq);
			String userId =(String) session.getAttribute("userId");
			boardThumb.setUserId(userId);

			// 해당 게시글 댓글 조회
			if(boardComments != 0) {
				boardComment = boardService.selectBoardCommentList(boardCodeSeq);
				modelAndView.addObject("boardComment", boardComment);
			}
			
			// 해당 게시글 파일 조회
			BoardFile boardFile = boardFileService.selectBoardFile(boardCodeSeq);
			if(boardFile != null) {
				modelAndView.addObject("boardFile", boardFile);
			}
			
			if(userId == null) {
				// 로그인 하지 않은 경우
				modelAndView.addObject("heart","unSignIn");
			}else if(boardService.selectBoardThumb(boardThumb) == null) {
				// 해당 게시글을 추천하지 않은 경우
				modelAndView.addObject("heart","notThumbsUp");
				
				// 조회 수 증가
				boardService.updateBoardCount(boardCodeSeq);
			}else {
				// 해당 게시글을 이미 추천한 경우
				modelAndView.addObject("heart","thumbsUp");
				
				// 조회 수 증가
				boardService.updateBoardCount(boardCodeSeq);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		modelAndView.addObject("comments",boardComments);
		modelAndView.addObject("thumbs", thumbs);
		modelAndView.addObject("board", board);
		modelAndView.setViewName("community/boardRead");
		
		return modelAndView;
	}
	
	// 게시글 등록
	@RequestMapping(value = "boardWriteCon.do", method = RequestMethod.POST)
	public String boardInsertService(MultipartHttpServletRequest files, Board board, HttpServletRequest request, ModelAndView modelAndView) throws ServletException, IOException {
		HttpSession session = request.getSession();
		board.setUserId((String) session.getAttribute("userId"));
		
		
		if(files != null) {
			// 바뀐 파일 명
			String bFileChangedName = files.getParameter("bFileChangedName");
	
			// 파일 원본 명
			String bFileOriginalName = files.getParameter("bFileOriginalName");
			
			// 파일 경로
			String bFilePath = files.getParameter("bFilePath");
			
			System.out.println("바뀐 파일 명 : " + bFileChangedName);
			System.out.println("원본 : " + bFilePath);
			System.out.println("경로 : " + bFileOriginalName);
			
			// 객체 생성
			BoardFile boardFile = new BoardFile();
			boardFile.setbFileChangedName(bFileChangedName);
			boardFile.setbFileOriginalName(bFileOriginalName);
			boardFile.setbFilePath(bFilePath);
			boardService.insertBoardWith(board, boardFile);
		}else {
			boardService.insertBoard(board);
		}
		// 목록 조회 돌아감
		return "redirect:/board.do";
	}
	
	// 게시글 수정 페이지
	@RequestMapping(value = "boardUpdateProCon.do", method = RequestMethod.GET)
	public ModelAndView boardUpdateProService(int boardCodeSeq, HttpServletRequest request, ModelAndView modelAndView) throws IOException {
		
		// 작성자 확인
		HttpSession session = request.getSession();
		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");
		
		// 게시글 정보 조회
		Board board = boardService.selectBoardOne(boardCodeSeq);
		
		// 게시글 파일 조회
		BoardFile boardFile = boardFileService.selectBoardFile(boardCodeSeq);

		if(boardFile != null) {
			modelAndView.addObject("boardFile", boardFile);
		}
		modelAndView.addObject("board", board);
		if(userId.equals(board.getUserId())) {
			modelAndView.setViewName("community/boardRewrite");
			return modelAndView;
		}else {
			modelAndView.setViewName("redirect:/boadSelectOneCon.do?boardCodeSeq="+boardCodeSeq);
		}
		return modelAndView;
	}
	
	// 게시글 수정
	@RequestMapping(value = "boardUpdateCon.do", method = RequestMethod.POST)
	public String boardUpdateService(Board board, ModelAndView modelAndView) {
		boardService.updateBoard(board);
		
		// 목록 돌아감
		return "redirect:/board.do";	
	}
	
	// 게시글 삭제
	@RequestMapping(value = "boardDeleteCon.do", method = RequestMethod.GET)
	public ModelAndView boardDeleteCon(int boardCodeSeq, HttpServletRequest request, ModelAndView modelAndView) {
		HttpSession session = request.getSession();
		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");
		Board board = boardService.selectBoardOne(boardCodeSeq);
		modelAndView.addObject("board", board);
		
		if(userId.equals(board.getUserId())) {
			boardService.deleteBoard(boardCodeSeq);
			boardService.deleteBoardThumbAll(boardCodeSeq);
			boardService.deleteBoardCommentAll(boardCodeSeq);
			boardFileService.deleteBoardFile(boardCodeSeq);
			modelAndView.setViewName("redirect:/board.do");
			return modelAndView;
		}else {
			modelAndView.setViewName("redirect:/boadSelectOneCon.do?boardCodeSeq="+boardCodeSeq);
		}
		return modelAndView;
	}
	
	// 댓글 작성
	@RequestMapping(value = "boardCommentInsert.do", method = RequestMethod.GET)
	public String boardCommentInsert(BoardComment boardComment, HttpServletRequest request, ModelAndView modelAndView) {
		HttpSession session = request.getSession();
		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");
		boardComment.setUserId(userId);
		if(!userId.equals("noOne")) {
			boardService.insertBoardComment(boardComment);
		}else {
			return "redirect:/signIn.do";
		}
		return "redirect:/boadSelectOneCon.do?boardCodeSeq="+boardComment.getBoardCodeSeq();
	}
	
	
	// 댓글 삭제
	@RequestMapping(value = "boardCommentDelete.do", method = RequestMethod.GET)
	public String boardCommentDelete(int commentCodeSeq, int boardCodeSeq, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");
		String commentOwner = boardService.selectComment(commentCodeSeq).getUserId();
		
		if(commentOwner.equals(userId)) {
			boardService.deleteBoardComment(commentCodeSeq);
		}
		return "redirect:/boadSelectOneCon.do?boardCodeSeq="+boardCodeSeq;
	}
}
