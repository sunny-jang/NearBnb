package com.on.nearbnb.place.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class PlaceController {
	
	@RequestMapping(value="/addFile", method=RequestMethod.POST)
	@ResponseBody
	public String addFile(MultipartHttpServletRequest files, HttpServletRequest request) throws Exception {
		MultipartFile image = files.getFile("image");
		String imageName = image.getOriginalFilename();
		String path = request.getSession().getServletContext().getRealPath("resources") +"\\html\\images\\" + imageName;
		System.out.println(imageName);
		File file = new File(path);
		
		image.transferTo(file);
		
		System.out.println(path);
		return imageName;
	}

}
