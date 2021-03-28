package com.on.nearbnb.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
	
}
