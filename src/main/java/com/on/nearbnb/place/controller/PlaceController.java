package com.on.nearbnb.place.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class PlaceController {
	
	@RequestMapping(value = "/addFile.do", method = RequestMethod.POST)
	public String addFile(MultipartHttpServletRequest files) throws Exception {
		MultipartFile image = files.getFile("imageUpload");
		String path = "C:\\Users\\user1\\Desktop\\nearBnb\\NearBnb\\src\\main\\webapp\\resources\\images\\" + image.getOriginalFilename();
		System.out.println("test");
		
		image.transferTo(new File(path));
		System.out.println(path);
		return path;
	}

}
