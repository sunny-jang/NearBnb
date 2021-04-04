package com.on.nearbnb.place.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.on.nearbnb.file.model.dao.PlaceFileDao;
import com.on.nearbnb.file.model.vo.PlaceFile;
import com.on.nearbnb.place.model.dao.PlaceDao;
import com.on.nearbnb.place.model.dao.PlacePointDao;
import com.on.nearbnb.place.model.vo.ExtendedPlace;
import com.on.nearbnb.place.model.vo.Place;
import com.on.nearbnb.place.model.vo.PlacePoint;
import com.on.nearbnb.place.model.vo.PlaceThumb;

@Service
public class placeServiceImpl implements PlaceService {

	@Autowired
	private PlaceDao pDao;

	@Autowired
	private PlacePointDao pPointDao;

	@Autowired
	private PlaceFileDao pFileDao;

	@Transactional
	@Override
	public int insertPlace(Place place, PlacePoint placePoint, List<PlaceFile> placeFile) {
		// TODO Auto-generated method
		pDao.insertPlace(place);
		 
		placePoint.setPlaceId(place.getPlaceId());
		pPointDao.insertPlacePoint(placePoint);
		pFileDao.insertPlaceFile(placeFile, place.getPlaceId());

		return 0;
	}

	@Override
	public int insertPlacePoint(PlacePoint placePoint) {
		// TODO Auto-generated method stub
		return pPointDao.insertPlacePoint(placePoint);
	}

	@Override
	public Place selectPlace(Integer pId) {
		return pDao.selectPlace(pId);
	}	

	@Override
	public List<Place> selectPlaceById(String uId) {		
		return pDao.selectPlaceById(uId);
	}
	
	@Override
	public Place selectPlaceForModal(Integer pId) {		
		return pDao.selectPlaceForModal(pId);
	}

	@Override
	public String kakaoPay(String placeName, String totalPrice) throws Exception {
		String itemName = URLEncoder.encode(placeName, "UTF-8");
		int price = Integer.parseInt(totalPrice);
		int vat = price/11;
		URL address = new URL("https://kapi.kakao.com/v1/payment/ready"); // 주소
		HttpURLConnection conn = (HttpURLConnection) address.openConnection(); // 요청하는 클라이언트와 요청을 받는 카카오페이 서버를 연결시켜주는 기능
		conn.setRequestMethod("POST"); // 통신방식 : POST
		conn.setRequestProperty("Authorization", "KakaoAK c13d2cfd23c36064ad1e30d7efea9bba"); // 인증받은 admin key인지 검사, setRequestProperty : 프로퍼티 하나하나를 심어주는 역할
		conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); // Content-type 프로퍼티 심어주기	
		// connection에는 doInput, doOutput이 있는데, doInput은 디폴트 값이 true, doOutput은 false -> 따로 설정해줘야 함.
		conn.setDoOutput(true); // doOutput : 서버에 내보내줄 것이 있는지 없는지 -> 있으면 true
		
		// 파라미터 구간
		String param = "cid=TC0ONETIME&partner_order_id=partner_order_id&"
				+ "partner_user_id=partner_user_id&item_name="+itemName+"&quantity=1&total_amount="+totalPrice+"&vat_amount="+vat+"&tax_free_amount=0&"
				+ "approval_url=http://localhost:8181/nearbnb/kakaoPayComplete.do&fail_url=http://localhost:8181/nearbnb/index.do&cancel_url=http://localhost:8181/nearbnb/kakaoPayCancel.do";
		OutputStream ops = conn.getOutputStream(); // 파라미터를 실제로 서버로 전달하기 위한 역할, connection을 통해 뭔가를 줄 수 있게 됨.
		DataOutputStream dops = new DataOutputStream(ops); // 데이터 주는 역할
		dops.writeBytes(param); // 데이터를 줄 때 byte형태로 전달해야 하는데, byte로 형변환 하는 역할
		// dops.flush();
		dops.close(); // stream 닫기, connection을 통해 보내야 할 것을 보내는 역할이 가능한 flush() 까지 진행됨.
		
		int result = conn.getResponseCode(); // 실제로 송신이 잘 됐는지 결과를 받는 부분. 200/400/404/500 등
		
		InputStream ips; // 받는애. 그저 받을 줄만 암. 활용할 줄은 모름
		if(result == 200) { // 정상적인 송신, 200 만이 개발자가 의도한 대로 된 것
			ips = conn.getInputStream();
		} else { // 송신에 문제가 생김.
			ips = conn.getErrorStream(); // error 코드 발생했을 경우에만 받는 것.
		}
		
		InputStreamReader isr = new InputStreamReader(ips); // 받은 것을 읽어내는 역할 (활용하는 애)
		BufferedReader br = new BufferedReader(isr); // 서버의 응답은 byte형식으로 오는데 이를 형변환 하는 역할. 사실 BufferedReader는 형변환 하는 역할은 아니지만 형변환 할 줄 암.
		return br.readLine(); // 문자열로 형변환. 동시에 비워지게 됨.
	}	
	//main
	@Override
	public List<PlacePoint> searchPlacePoint(PlacePoint searchpoint){
		return pPointDao.searchPlacePoint(searchpoint);
	}


	@Override
	public PlacePoint searchPlacePointOne(Integer pId) {
		return pPointDao.searchPlacePointOne(pId);

	}
	
	@Override
	public int placeThumbCount(int placeId) {
		return pDao.placeThumbCount(placeId);
	}
	
	@Override
	public PlaceThumb selectPlaceThumb(PlaceThumb placeThumb) {
		return pDao.selectPlaceThumb(placeThumb);
	}
	
	@Override
	public int insertPlaceThumb(PlaceThumb placeThumb) {
		return pDao.insertPlaceThumb(placeThumb);
	}
	
	@Override
	public int deletePlaceThumb(PlaceThumb placeThumb) {
		return pDao.deletePlaceThumb(placeThumb);
	}
	
	@Override
	public List<ExtendedPlace> searchExtendedPlace(PlacePoint pp) {
		return pDao.searchExtendedPlace(pp);
	}

}
