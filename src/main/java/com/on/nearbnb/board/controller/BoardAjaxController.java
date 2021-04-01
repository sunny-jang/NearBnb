package com.on.nearbnb.board.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.board.model.vo.Board;
import com.on.nearbnb.board.model.vo.BoardComment;
import com.on.nearbnb.board.model.vo.BoardThumb;
import com.on.nearbnb.board.service.BoardService;

@Controller
public class BoardAjaxController {
	
	// BoardService DI
	@Autowired
	BoardService boardService;
	
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
	
//	// 게시글 검색
//	@RequestMapping(value = "boardAjaxSearch.do", method = RequestMethod.GET)
//	public String searchBoard(
//			@RequestParam(name = "boardSearchType", defaultValue = "전체") String type,
//			@RequestParam(name = "boardSearch", required = true) String content,
//			ModelAndView modelAndView) {
//		String boardType = type;
//		String boardContent = content;
//		
//		JSONObject jsonData = new JSONObject();
//		JSONArray jsonArray = new JSONArray();
//		try {
//			HashMap<String, Object> searchMap = new HashMap<String, Object>();
//			searchMap.put("boardType", boardType);
//			searchMap.put("boardContent", boardContent);
//			
//			List<Board> bList = new ArrayList<Board>();
//			bList = boardService.searchBoard(searchMap);
//			jsonData.put("boardList", bList);
//
//			return jsonData.toJSONString();
//		}catch(Exception e) {
//			System.out.println(e.getMessage());
//		}
//
//		return jsonData.toJSONString();
//	}
	
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
	
//	// 댓글 작성
//	@RequestMapping(value = "boardCommentInsert.do", method = RequestMethod.POST)
//	@ResponseBody
//	public String boardCommentInsert(BoardComment boardComment, HttpServletRequest request, HttpServletResponse response, ModelAndView modelAndView) {
//		HttpSession session = request.getSession();
//		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");
//		
//		boardComment.setUserId(userId);
//		JSONObject jsonData = new JSONObject();
//		
//		JSONArray jsonArray = new JSONArray();
//		if(!userId.equals("noOne")){
//			try {
//				response.setCharacterEncoding("UTF-8");
//				request.setCharacterEncoding("UTF-8");
//				// 댓글 등록
//				boardService.insertBoardComment(boardComment);
//				// 댓글 개수 가져오기
//				int boardCommentCnt = boardService.selectBoardCommentCount(boardComment.getBoardCodeSeq());
//				// 댓글 가져오기
//				List<BoardComment> boardCommentList = new ArrayList<BoardComment>();
//				boardCommentList = boardService.selectBoardCommentList(boardComment.getBoardCodeSeq());
//				jsonData.put("commentListCnt",boardCommentCnt);
//
//				// 날짜 형식용
//				SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd hh:mm");
//				
//				for(int i = 0; i < boardCommentCnt; i++) {
//					JSONObject jsonData2 = new JSONObject();
//					jsonData2.put("userId", boardCommentList.get(i).getUserId());
//					jsonData2.put("commentContent", boardCommentList.get(i).getCommentContent());
//					String ftDate = ft.format(boardCommentList.get(i).getCommentDate());
//					jsonData2.put("commentDate",ftDate);
//					jsonArray.add(jsonData2);
//				}
//
//				jsonData.put("commentList", jsonArray);
//
//				return jsonData.toJSONString();
//			}catch(Exception e) {
//				System.out.println(e.getMessage());
//			}
//		}
//		return jsonData.toJSONString();
//	}

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
