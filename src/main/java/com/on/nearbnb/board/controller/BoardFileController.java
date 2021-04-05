package com.on.nearbnb.board.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.on.nearbnb.board.model.vo.BoardFile;
import com.on.nearbnb.board.service.BoardFileService;

@Controller
public class BoardFileController {

	// BoardFileService DI
		@Autowired
		BoardFileService boardFileService;
	
	// 해당 게시글 파일 다운받기
		@RequestMapping(value = "boardFileDownload.do", method = RequestMethod.GET)
		public void boardFileDownload(int boardCodeSeq, HttpServletRequest request, HttpServletResponse response) throws IOException {

			// 파일 정보 조회
			BoardFile boardFile = boardFileService.selectBoardFile(boardCodeSeq);
			String saveDir = boardFile.getbFilePath();
			String fileName = boardFile.getbFileChangedName();
			
			// 파일 위치 지정
			File file = new File(saveDir + "/" + fileName);

			// Stream 선언
			FileInputStream fis = null;
			BufferedInputStream bis = null;
			ServletOutputStream sos = null;
			
			try {
				// 객체 생성
				fis = new FileInputStream(file);
				bis = new BufferedInputStream(fis);
				sos = response.getOutputStream();
				
				// 다운받는 파일 이름 지정
				String reFilename = "";
				
				// Internet Explorer로 실행한 경우
				boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") != -1 || request.getHeader("user-agent").indexOf("Trident") != -1;

				// Microsoft Internet Explorer인가?
				if(isMSIE) {
					reFilename = URLEncoder.encode(boardFile.getbFileOriginalName(), "utf-8");
					reFilename = reFilename.replaceAll("\\+", "%20");
				}else {
					reFilename = new String(boardFile.getbFileOriginalName().getBytes("utf-8"), "ISO-8859-1");
				}
				
				response.setContentType("application/octet-stream;charset=utf-8");
				response.addHeader("Content-Disposition", "attachment;filename=\""+reFilename+"\"");
				response.setContentLength((int)file.length());

				int read = 0;
				while((read = bis.read()) != -1) {
					sos.write(read);
				}

			}catch(IOException e) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				script.println("alert('다운로드에 실패했습니다');");
				script.println("history.back();");
				script.println("</script>");
				System.out.println(e.getMessage());
				return;
			}finally {
				try {
					sos.close();
					bis.close();
				}catch(IOException e) {
					System.out.println(e.getMessage());
					e.printStackTrace();
				}
			}
		}
}
