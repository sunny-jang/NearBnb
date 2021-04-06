package com.on.nearbnb.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardComment;
import com.on.nearbnb.board.model.vo.BoardFile;
import com.on.nearbnb.board.model.vo.BoardThumb;
import com.on.nearbnb.board.service.BoardFileService;
import com.on.nearbnb.board.service.BoardService;

@Controller
public class BoardAjaxController {
	
	// BoardService DI
	@Autowired
	BoardService boardService;
	
	// BoardFileService DI
	@Autowired
	BoardFileService boardFileService;
	
	// 게시글 추천
	@RequestMapping(value = "boardAjaxThumbsUp.do", method = RequestMethod.GET)
	public void thumbInsertService(BoardThumb boardThumb,
			HttpServletRequest request, HttpServletResponse response,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		String userId =(String) session.getAttribute("userId");
		JSONObject jsonData= new JSONObject();
		try {
			if(userId == null) {
				jsonData.put("heart", "unSignIn");
			}else if(boardService.selectBoardThumb(boardThumb) == null) {
				boardService.insertBoardThumb(boardThumb);
				jsonData.put("heart", "thumbsUp");
			}else {
				boardService.deleteBoardThumb(boardThumb);
				jsonData.put("heart", "notThumbsUp");
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		int thumbs = boardService.boardThumbCount(boardThumb.getBoardCodeSeq());

		jsonData.put("maxThumb",thumbs);
		response.getWriter().append(jsonData.toJSONString());
	}
	
	// 게시글 파일 추가
	@RequestMapping(value = "boardAjaxFileInsert.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String addBoardFile(MultipartHttpServletRequest files, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("application/x-json; charset=UTF-8");
		
		MultipartFile file = files.getFile("file");

		// 업로드 시간 + 파일 명
		String fileName = new java.util.Date().getTime() + file.getOriginalFilename();
		System.out.println(fileName);
		
		// 파일 업로드 될 경로
		String path = request.getSession().getServletContext().getRealPath("resources") + "\\html\\images\\";
		File folder = new File(path + fileName);
		
		// 파일 저장
		try {
			System.out.println("파일 경로 : " + folder);
			
			file.transferTo(folder);
			System.out.println(fileName + "전송이 완료되었습니다.");
		}catch(Exception e) {
			System.out.println("파일 전송 에러 : " + e.getMessage());
		}
		
		return fileName;
	}
	
	// 게시글 파일 삭제
	@RequestMapping(value = "boardAjaxFileDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public void delBoardFile(int boardCodeSeq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		BoardFile boardFile = boardFileService.selectBoardFile(boardCodeSeq);
		System.out.println("경로 : " + boardFile.getbFilePath());
		System.out.println("바뀐 명 : " + boardFile.getbFileChangedName());
		System.out.println("원본 명 : " + boardFile.getbFileOriginalName());
		
		boardFileService.deleteBoardFile(boardCodeSeq);

		
	}
	
	// 게시글 분류
	@RequestMapping(value = "boardAjaxType.do", method = RequestMethod.GET)
	@ResponseBody
	public String searchBoardType(@RequestParam(name = "boardType", defaultValue = "전체") String boardType,
			HttpServletResponse response, HttpServletRequest request,
			ModelAndView modelAndView) throws IOException{
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		JSONObject jsonData = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		try {
			// 보드 분류 저장
			Board board = new Board();
			board.setBoardType(boardType);
			
			List<Board> bList = new ArrayList<Board>();
			bList = boardService.searchBoardType(board);
			jsonData.put("boardList", jsonArray);

			for(int i = 0; i <= boardService.searchBoardType(board).size(); i++) {
				jsonArray.add(i, bList.get(i).getBoardType());
			}
			return jsonData.toJSONString();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return jsonData.toJSONString();
	}
	
	// 분류 선택 후 출력
	@RequestMapping(value = "printBoardAjaxType.do", method = RequestMethod.GET)
	public ModelAndView boardAjaxType(String boardType, Board board,HttpServletResponse response, HttpServletRequest request, ModelAndView modelAndView) {
		try {
			response.setCharacterEncoding("UTF-8");
			request.setCharacterEncoding("UTF-8");
			// 분류 선택
			board.setBoardType(boardType);
			
			if(board.getBoardType().equals("전체") || board.getBoardType().equals("")) {
				modelAndView.setViewName("redirect:/board.do");
				return modelAndView;
			}else {
				// 베스트 게시글 5개 조회
				modelAndView.addObject("bestList",boardService.selectBestList());
				
				// 분류 조회
				modelAndView.addObject("boardList", boardService.searchBoardType(board));
				modelAndView.setViewName("community/board");
				return modelAndView;
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		modelAndView.setViewName("redirect:/board.do");
		return modelAndView;
	}

	// 대댓글 달기
	@RequestMapping(value = "subCommentInsert.do", method = RequestMethod.POST)
	public void subCommentInsert(String[] sub, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		BoardComment boardComment = new BoardComment();
		boardComment.setBoardCodeSeq(Integer.parseInt(sub[0]));
		boardComment.setUserId(sub[1]);
		boardComment.setParentCommentCode(Integer.parseInt(sub[2]));
		boardComment.setCommentContent(sub[3]);
		
		boardService.insertBoardComment(boardComment);
	}
	
	// 댓글 수정
	@RequestMapping(value = "boardCommentAjaxUpdate.do", method = RequestMethod.POST)
	public void boardCommentUpdate(BoardComment boardComment,int reCode, String reContent,HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		String reWriteContent = "default";
		JSONObject jsonData= new JSONObject();
		try {
			boardComment.setCommentCodeSeq(reCode);
			boardComment.setCommentContent(reContent);

			boardService.updateBoardComment(boardComment);
			reWriteContent = boardService.selectComment(reCode).getCommentContent();
			jsonData.put("reC", reWriteContent);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		response.getWriter().append(jsonData.toJSONString());
	}

}
