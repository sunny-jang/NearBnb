package com.on.nearbnb.place.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.on.nearbnb.file.service.PlaceFileService;
import com.on.nearbnb.place.model.vo.PlacePoint;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.service.PlaceService;

@Controller
public class PlaceController {
	
	@Autowired
	private PlaceService placeService;
	
	@Autowired
	private PlaceFileService placeFileService;
	
	
	@RequestMapping(value="/addFile", method=RequestMethod.POST)
	@ResponseBody
	public String addFile(MultipartHttpServletRequest files, HttpServletRequest request) throws Exception {
		MultipartFile image = files.getFile("image");

		String imageName = new java.util.Date().getTime() + image.getOriginalFilename();
		String path = request.getSession().getServletContext().getRealPath("resources") +"\\html\\images\\" + imageName;

		File file = new File(path);
		
		image.transferTo(file);
		
		System.out.println(imageName);
		return imageName;
	}
	
	@RequestMapping(value = "/placeDetail.do", method = RequestMethod.GET)
	public ModelAndView placeDetail(@RequestParam(name="pId", defaultValue="1") Integer pId, ModelAndView modelAndView) {
		Place place= placeService.selectPlace(pId);
		List<PlaceFile> files = placeFileService.selectFiles(pId);
		modelAndView.addObject("place", place);
		modelAndView.addObject("images", files);
		
		modelAndView.setViewName("/place/placeDetail");
		return modelAndView;
	}
	
	@RequestMapping(value="/placeAdd.do", method=RequestMethod.POST)
	public String addPlace(MultipartHttpServletRequest files, Place place, PlacePoint placePoint, HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		List<MultipartFile> images = files.getFiles("imageUpload");
		String path = files.getSession().getServletContext().getRealPath("resources")+"\\html\\images\\";
		String[] changedImages = files.getParameterValues("changedImages");
		
		/* Coords coords = getCoords(request); */
		List<PlaceFile> placeFiles = makeFileList(images,changedImages, path);
		System.out.println(placeFiles.toString());
		HttpSession session = request.getSession();
		String uId = (String) session.getAttribute("userId");
		
		place.setuId(uId);
		placeService.insertPlace(place, placePoint, placeFiles);
		
		place = null;
		placePoint = null;
		files = null;
		
		return "redirect:index.do";
	}

	public List<PlaceFile> makeFileList(List<MultipartFile> images,String[] changedImages, String path) {
		List<PlaceFile> placeFiles = new ArrayList<PlaceFile>();
		
		for(int i = 0; i<changedImages.length; i++) {
			String fileName = images.get(i).getOriginalFilename();
			String fileChangedName = changedImages[i];
			System.out.println("fileChangedName : " + fileChangedName);
			String _path = path;
					
			
			if(fileName!= null && fileName !="") {
				PlaceFile file = new PlaceFile(fileName, fileChangedName, _path);
				placeFiles.add(file);
			}
		}
		
		return placeFiles;
	}
	
	
	@RequestMapping(value = "/placeReservation.do", method = RequestMethod.GET)
	public ModelAndView placeReservation(@RequestParam(name="pId", defaultValue="1") Integer pId, ModelAndView modelAndView) {
		Place place = placeService.selectPlace(pId);
		List<PlaceFile> files = placeFileService.selectFiles(pId);		

		modelAndView.addObject("sImage",files.get(0).getFileChangedName());
		
		modelAndView.addObject("place", place);
		modelAndView.setViewName("/place/placeReservation");
		return modelAndView;	
	}
	
	@RequestMapping(value = "/kakaoPayTestPage.do", method=RequestMethod.GET)
	public ModelAndView kakaoPayTestPage(ModelAndView modelAndView) throws Exception {
		modelAndView.setViewName("place/kakaoPayTest");
		return modelAndView;
	}
	
	@RequestMapping(value = "/kakaoPayComplete.do", method=RequestMethod.GET)
	public ModelAndView kakaoPayComplete(ModelAndView modelAndView) throws Exception {
		
		modelAndView.setViewName("place/kakaoPayComplete");
		return modelAndView;
	}
	
	@RequestMapping(value = "/kakaoPayCancel.do", method=RequestMethod.GET)
	public ModelAndView kakaoPayCancel(ModelAndView modelAndView) throws Exception {
		
		modelAndView.setViewName("place/kakaoPayCancel");
		return modelAndView;
	}
	
	@RequestMapping(value = "/kakaoPay.do")
	@ResponseBody
	public String kakaoPayTest(String placeName, String totalPrice) throws Exception {		
		System.out.println(placeName);
		System.out.println(totalPrice);
		return placeService.kakaoPay(placeName, totalPrice);
	}

}
