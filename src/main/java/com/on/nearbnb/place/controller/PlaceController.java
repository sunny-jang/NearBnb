package com.on.nearbnb.place.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.on.nearbnb.board.model.vo.BoardThumb;
import com.on.nearbnb.book.model.vo.Book;
import com.on.nearbnb.book.service.BookService;
import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.file.service.PlaceFileService;
import com.on.nearbnb.place.model.vo.PlacePoint;
import com.on.nearbnb.place.model.vo.PlaceThumb;
import com.on.nearbnb.place.model.dao.PlaceDao;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.service.PlaceService;

import net.sf.json.JSONArray;
import org.json.simple.JSONObject;

@Controller
public class PlaceController {
	
	@Autowired
	private PlaceService placeService;
	
	@Autowired
	private PlaceFileService placeFileService;
	
	@Autowired
	private BookService bookService;
	
	@RequestMapping(value = "/placeList.do", method = RequestMethod.GET)//숙소목록
	public ModelAndView placeList(ModelAndView modelAndView) {
		modelAndView.setViewName("/place/placeList");
		return modelAndView;
	}
	
	@RequestMapping(value = "/pListAjax.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String pListAjax(@RequestParam("idList") List<PlacePoint> pidList,
			 HttpServletRequest request, ModelAndView modelAndView) {
		List<Place> resultList = placeService.selectPlaceList(pidList);
		List<PlaceFile> resultFileOne = placeFileService.selectOneList(pidList);
		// Ajax
				JSONObject jsonObject = new JSONObject();
				JSONArray jsonArray = new JSONArray();
				for (int i = 0; i < resultList.size(); i++) {
					JSONObject pObject = new JSONObject();
					pObject.put("placeId", resultList.get(i).getuId());	
					pObject.put("maxGuest", resultList.get(i).getMaxGuest());	
					pObject.put("placeType", resultList.get(i).getPlaceType());	
					pObject.put("placePrice", resultList.get(i).getPlacePrice());	
					pObject.put("placeDesc", resultList.get(i).getPlaceDesc());	
					pObject.put("placeOpenDate", resultList.get(i).getPlaceOpenDate());	
					pObject.put("placeCloseDate", resultList.get(i).getPlaceCloseDate());	
					jsonArray.add(pObject);
				}
				jsonObject.put("placeList", jsonArray);
		String result=jsonObject.toString();
		System.out.println(result); 
		return result;
	}

	@RequestMapping(value = "/placeDetail.do", method = RequestMethod.GET)
	public ModelAndView placeDetail(@RequestParam(name="pId", defaultValue="1") Integer pId, HttpServletRequest request, ModelAndView modelAndView) {
		Place place= placeService.selectPlace(pId);
		List<PlaceFile> files = placeFileService.selectFiles(pId);
		PlacePoint pp = placeService.searchPlacePointOne(pId);
		
		HttpSession session = request.getSession();
		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");
		
		int likes = placeService.placeThumbCount(pId);
		modelAndView.addObject("place", place);
		modelAndView.addObject("images", files);
		
		PlaceThumb placeThumb = new PlaceThumb();
		placeThumb.setPlaceId(pId);
		placeThumb.setuId(userId);

		try {
			if(userId.equals("noOne")) {
				modelAndView.addObject("like", "login");
			}else if(placeService.selectPlaceThumb(placeThumb) == null) {
				modelAndView.addObject("like", "didnt");
			}else {
				modelAndView.addObject("like", "did");
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
			
		modelAndView.addObject("likes",likes);
		modelAndView.addObject("pp", pp);
		
		modelAndView.setViewName("/place/placeDetail");
		return modelAndView;
	
	}
	
	@RequestMapping(value="/placeAdd.do", method=RequestMethod.POST)
	public String addPlace(MultipartHttpServletRequest files, Place place, PlacePoint placePoint, HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		List<MultipartFile> images = files.getFiles("imageUpload");
		String[] changedImages = files.getParameterValues("changedImages");
		String[] imagePath = files.getParameterValues("imagePath");
		
		List<HashMap<String, String>> imageInfo = new ArrayList<HashMap<String,String>>();
		
		for(int i=0; i<changedImages.length; i++) { 
			HashMap<String, String> fileInfo = new HashMap<String, String>();
			String fileName = images.get(i).getOriginalFilename();
			
			fileInfo.put("fileName", fileName);
			fileInfo.put("changedName", changedImages[i]);
			fileInfo.put("imagePath", imagePath[i]);
			
			imageInfo.add(fileInfo);
		}
		
		/* Coords coords = getCoords(request); */
		List<PlaceFile> placeFiles = makeFileList(imageInfo);
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

	public List<PlaceFile> makeFileList(List<HashMap<String, String>> imageInfo) {
		List<PlaceFile> placeFiles = new ArrayList<PlaceFile>();
		
		for(int i = 0; i<imageInfo.size(); i++) {
			String fileName = imageInfo.get(i).get("fileName");
			String fileChangedName = imageInfo.get(i).get("changedName");
			String _path = imageInfo.get(i).get("imagePath");
					
			
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
	
		modelAndView.addObject("sImage",files.get(0).getFilePath());
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
	
	@RequestMapping(value = "/bookList.do")
	@ResponseBody
	public String makeBookJson(String pId) throws UnsupportedEncodingException {
		Book book = new Book();
		book.setpId(pId);
		List<Book> bookList = bookService.selectBook(book);
		JSONArray jsonArray = new JSONArray();
		
		for(Book book_: bookList) {
			JSONObject innerObject = new JSONObject();
			innerObject.put("title", URLEncoder.encode("예약 불가", "utf-8"));
			innerObject.put("start", book_.getBookCheckIn());
			innerObject.put("end", book_.getBookCheckOut());
			jsonArray.add(innerObject);
		}
		
		System.out.println();
		
		return jsonArray.toString();
	}
	
	// 숙소 추천
	@RequestMapping(value = "placeAjaxThumbsUp.do", method = RequestMethod.GET)
	public void thumbInsertService(int placeCodeSeq,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");
		JSONObject jsonData= new JSONObject();
		
		if(userId.equals("noOne")) {
			jsonData.put("like", "didnt");
			return;
		}
		PlaceThumb placeThumb = new PlaceThumb();
		placeThumb.setPlaceId(placeCodeSeq);
		placeThumb.setuId(userId);

		try {
			if(placeService.selectPlaceThumb(placeThumb) == null){
				jsonData.put("like", "did");
				placeService.insertPlaceThumb(placeThumb);
			}else {
				placeService.deletePlaceThumb(placeThumb);
				jsonData.put("like", "didnt");
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		int likes = placeService.placeThumbCount(placeThumb.getPlaceId());
		jsonData.put("maxLikes",likes);
		
		response.getWriter().append(jsonData.toJSONString());
	}
	
	@RequestMapping(value="deletePlace.do", method=RequestMethod.GET)
	@ResponseBody
	public String deletePlace(@RequestParam(name="pId") String pId) {
		JSONObject jobj = new JSONObject();
		Book book = new Book();
		book.setpId(pId);
		System.out.println(pId);
		
		List<Book> bList = bookService.selectBook(book);
		System.out.println(bList.toString());
		if(bList.size() == 0) {
			placeService.deletePlace(Integer.parseInt(pId));
			jobj.put("result", "deleted");
		}else {
			jobj.put("result", "failed");
		}
		
		return jobj.toJSONString();
	}
}
