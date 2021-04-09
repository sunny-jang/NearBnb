package com.on.nearbnb.place.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.on.nearbnb.book.model.vo.Book;
import com.on.nearbnb.book.service.BookService;
import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.file.service.MemberProfileService;
import com.on.nearbnb.file.service.PlaceFileService;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;
import com.on.nearbnb.place.model.vo.PlaceThumb;
import com.on.nearbnb.place.service.PlaceService;

import net.sf.json.JSONArray;

@Controller
public class PlaceController {
	
	@Autowired
	private PlaceService placeService;
	
	@Autowired
	private PlaceFileService placeFileService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private MemberProfileService memberProfileService;
	
	@RequestMapping(value = "/placeList.do", method = RequestMethod.GET)//숙소목록
	public ModelAndView placeList(PlacePoint pp, ModelAndView modelAndView) {
		List<PlacePoint> resultPoint = placeService.searchPlacePoint(pp);
		List<Place> resultPlace = placeService.selectPlaceList(resultPoint);// 숙소정보
		List<PlaceFile> resultFileOne = placeFileService.selectOneList(resultPoint);
		
		int pointId, placeId, fileId, size;
		size = resultPoint.size();
		pointId = resultPoint.get(size-1).getPlaceId(); 
		placeId = resultPlace.get(size-1).getPlaceId();
		fileId = resultFileOne.get(size-1).getPlaceId();
		System.out.println(pointId+","+placeId+","+fileId);
		System.out.println("resultPoint size : "+resultPoint.size());
		System.out.println("resultPlace size : "+resultPlace.size());
		System.out.println("resultFileOne size : "+resultFileOne.size());
		
		if ((pointId == placeId) && (placeId == fileId)) {
		modelAndView.addObject("epPlace", resultPlace);
		modelAndView.addObject("epFile", resultFileOne);
		modelAndView.addObject("pp", pp);
		}else {System.out.println("파일오류");}
		modelAndView.setViewName("/place/placeList");
		return modelAndView;
	}

	@RequestMapping(value = "/placeDetail.do", method = RequestMethod.GET)
	public ModelAndView placeDetail(@RequestParam(name="pId") Integer pId, HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		// 숙소정보, 숙소이미지, 좌표값 조회
		Place place= placeService.selectPlace(pId);
		List<PlaceFile> files = placeFileService.selectFiles(pId);
		PlacePoint pp = placeService.searchPlacePointOne(pId);
		
		// 숙소 정보 저장
		modelAndView.addObject("place", place);
		modelAndView.addObject("images", files);
		modelAndView.addObject("pp", pp);
		
		// 호스트 이미지 조회
		String hostProfile = memberProfileService.selectMemberProfile(place.getuId());
		HttpSession session = request.getSession();
		
		// 호스트 이미지 저장
		modelAndView.addObject("hostProfile", hostProfile);
		
		//로그인되어있지 않는 유저 noOne으로 초기화
		String userId = ((String) session.getAttribute("userId") == null)? "noOne" : (String) session.getAttribute("userId");

		// 총 숙소 좋아요 조회
		int likes = placeService.placeThumbCount(pId);
		PlaceThumb placeThumb = new PlaceThumb();
		placeThumb.setPlaceId(pId);
		placeThumb.setuId(userId);

		try {
			// 로그인정보 없으면 로그인 페이지로 이동	
			if(userId.equals("noOne")) {
				modelAndView.addObject("like", "login");
			// 해당 아이디로 추천한 적 없을때 정보 저장
			}else if(placeService.selectPlaceThumb(placeThumb) == null) {
				modelAndView.addObject("like", "didnt");
			// 이미 추천 한 숙소일 때 정보 저장
			}else {
				modelAndView.addObject("like", "did");
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		// 조회된 총 추천 개수 저장
		modelAndView.addObject("likes",likes);
		
		
		
		modelAndView.setViewName("/place/placeDetail");
		return modelAndView;
	
	}
	
	@RequestMapping(value="/placeAdd.do", method=RequestMethod.POST)
	public String addPlace(MultipartHttpServletRequest files, Place place, PlacePoint placePoint, HttpServletRequest request, ModelAndView modelAndView) throws Exception {
		List<MultipartFile> images = files.getFiles("imageUpload");
		String[] changedImages = files.getParameterValues("changedImages");
		String[] imagePath = files.getParameterValues("imagePath");
		
		System.out.println(place);
		System.out.println(changedImages.toString());
		System.out.println(imagePath.toString());
		List<HashMap<String, String>> imageInfo = new ArrayList<HashMap<String,String>>();
		
		for(int i=0; i<changedImages.length; i++) {
			if(changedImages[i] != "" || changedImages[i] != null) {
				HashMap<String, String> fileInfo = new HashMap<String, String>();
				String fileName = images.get(i).getOriginalFilename();
				
				fileInfo.put("fileName", fileName);
				fileInfo.put("changedName", changedImages[i]);
				fileInfo.put("imagePath", imagePath[i]);
				
				imageInfo.add(fileInfo);
			}
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
			innerObject.put("title", URLEncoder.encode("예약 완료", "utf-8"));
			innerObject.put("userId", book_.getuId());
			innerObject.put("bookPayPrice", book_.getBookPayPrice());
			innerObject.put("bookPerson", book_.getBookPerson());
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
