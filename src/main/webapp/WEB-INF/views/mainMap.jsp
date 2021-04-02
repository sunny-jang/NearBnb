<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Kakao map</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9072d526bef7d3c82b707cf7fe1c375f&libraries=LIBRARY,services"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
	$(function() {
		initLocation();
		var latitude = $("input[name=latitude]").val();//위도
		var longitude = $("input[name=longitude]").val();//경도

		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도생성옵션
			center : new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
			level :5
		//지도의 레벨(확대, 축소 정도)
		};
		//지도 생성 및 객체 리턴
		var map = new kakao.maps.Map(container, options);
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		function searchAddrFromCoords(coords, callback) {
			// 좌표로  대략적인 주소 요청
			geocoder.coord2RegionCode(coords.getLng(), coords.getLat(),
					callback);
		}
		console.log(coords.getLng(),coords.getLat());
		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var infoDiv = document.getElementById('centerAddr');
				for (var i = 0; i < result.length; i++) {
					// 행정동의 region_type 값은 'H' 이므로
					if (result[i].region_type === 'H') {
						infoDiv.innerHTML = result[i].address_name;
						break;
					}
				}
			}
		}
				
//controller
		function placePoint(lat, lon) {
			console.log("위도 : "+lat);
			console.log("경도 : "+lon);
			$.ajax({
				type : "POST",
				url : "centerPoint.do",
				data : { 'latitude' : lat ,'longitude' : lon},
				error : function(error) {
					console.log("error");
				},
				success : function(data) {
					console.log("success");
					//console.log(data);
					
				 data = JSON.parse(data);				
					searchPoint(data);
					//console.log("1번째 이름 :"+data.pointList[1].placeName);
					//console.log("1번째 이미지:"+data.pointList[1].placeImage);
					searchList(data);
				}
			});
		}
		
		function searchList(data){
			for(var i=1; i<=3; i++){
			$('#list'+[i]).html(data.pointList[i].placeName);
			listImg = "url(/nearbnb/resources/html/images/"+data.pointList[i].placeImage+")";
			$("#listImg"+[i]).css("background-image", listImg); 
			}
		}
		
		
		 //마커생성
		function searchPoint(data){
			var positions = [];
			
			for(var i=1; i<=data.pointList[0].arrCount; i++){
				var obj = new Object();
				obj.title = data.pointList[i].placeName;
				obj.latlng =  new kakao.maps.LatLng(
						data.pointList[i].latitude, 
						data.pointList[i].longitude
						);
				positions.push(obj);
				console.log(data.pointList[0].arrCount);
			}
			
			// 마커 이미지의 이미지 주소입니다
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			    
			var bounds = new kakao.maps.LatLngBounds(); 
			
			for (var i = 0; i < positions.length; i ++) {
			    
			    // 마커 이미지의 이미지 크기 입니다
			    var imageSize = new kakao.maps.Size(24, 35); 
			    
			    // 마커 이미지를 생성합니다    
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			    
			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[i].latlng, // 마커를 표시할 위치
			        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage // 마커 이미지 
			    });
			    
			    // 마커에 표시할 인포윈도우를 생성합니다 
			    var infowindow = new kakao.maps.InfoWindow({
			        content: positions[i].title // 인포윈도우에 표시할 내용
			     
			    });
			   
			    infowindow.open(map, marker);
			    marker.setMap(map);
			    bounds.extend(positions[i].latlng);
			    map.setBounds(bounds);
			}	
		}
		
		 
		

		
		//현재 위치값 불러오는 함수
		function initLocation() {
			if (navigator.geolocation) {//위치값 액세스
				navigator.geolocation.getCurrentPosition(function(position) {
					var latitude = position.coords.latitude;
					var longitude = position.coords.longitude;
					var coords = new kakao.maps.LatLng(latitude, longitude);//x,y좌표값
					
					placePoint(latitude, longitude);
					//지도 생성 및 객체 리턴
					map.setCenter(coords);
					searchAddrFromCoords(map.getCenter(), displayCenterInfo);
					$("input[name=latitude]").val(latitude); //var latitude, longitude
					$("input[name=longitude]").val(longitude);

				});
			} else { //액세스X
				alert('GPS를 지원하지 않습니다');
			}
		}
		//initLocation_end
	});
</script>
</head>
<body>
	<input type="hidden" name="latitude" value=""></input>
	<input type="hidden" name="longitude" value=""></input>

	<div id="map" style="width: 100%; height: 100%;"></div>

	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

	</div>
</body>
</html>