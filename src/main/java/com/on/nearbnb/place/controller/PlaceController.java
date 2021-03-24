package com.on.nearbnb.place.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.vo.Coords;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.service.PlaceService;

@Controller
public class PlaceController {
	
	@Autowired
	private PlaceService placeService;
	
	@RequestMapping(value="/addFile", method=RequestMethod.POST)
	@ResponseBody
	public String addFile(MultipartHttpServletRequest files, HttpServletRequest request) throws Exception {
		MultipartFile image = files.getFile("image");
		String imageName = image.getOriginalFilename();
		String path = request.getSession().getServletContext().getRealPath("resources") +"\\html\\images\\" + imageName;
		File file = new File(path);
		
		image.transferTo(file);
		
		System.out.println(path);
		return imageName;
	}
	
	@RequestMapping(value="/placeAdd.do", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView addPlace(MultipartHttpServletRequest files, Place place, HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		List<MultipartFile> images = files.getFiles("imageUpload");
		String path = files.getSession().getServletContext().getRealPath("resources")+"\\html\\images\\";
		
		/* Coords coords = getCoords(request); */
		List<PlaceFile> placeFiles = makeFileList(images, path);
		
		
		System.out.println(placeFiles.toString());
		
		System.out.println(place.toString());
		placeService.insertPlace(place);
		modelAndView.setViewName("/place/placeAdd");
		
		return modelAndView;
	}
	
	public Coords getCoords(HttpServletRequest request) {
		Double latitude = new Double(request.getParameter("latitude"));
		Double longitude = new Double(request.getParameter("longitude"));
		
		Coords coords = new Coords(latitude, longitude);
		System.out.println(coords.toString());
		return coords;
	}
	
	public List<PlaceFile> makeFileList(List<MultipartFile> images, String path) {
		List<PlaceFile> placeFiles = new ArrayList<PlaceFile>();
		
		for(MultipartFile image : images) {
			String fileName = image.getOriginalFilename();
			String fileChangedName = fileName+new java.util.Date().getTime();
			String _path = path;
					
			
			if(fileName!= null && fileName !="") {
				PlaceFile file = new PlaceFile(fileName, fileChangedName, _path);
				placeFiles.add(file);
			}
		}
		return placeFiles;
		
	}

}
