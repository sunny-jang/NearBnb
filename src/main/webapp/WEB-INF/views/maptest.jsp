<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>Kakao map</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9072d526bef7d3c82b707cf7fe1c375f&libraries=LIBRARY,services"></script>

<script>
	 navigator.geolocation.getCurrentPosition((position) => {
	        var latitude = position.coords.latitude;//위도
	        var longitude = position.coords.longitude;//경도
	        console.log('latitude',latitude);
	        console.log('longitude',longitude);
	        
	        //kakao.api
	        var container = document.getElementById('map');// 지도를 표시할 div 
			var options = {
				center: new kakao.maps.LatLng(latitude, longitude), //지도 중심좌표
				level: 3
			};

			var map = new kakao.maps.Map(container, options);//지도생성
			
			// 주소-좌표 변환 
			var geocoder = new kakao.maps.services.Geocoder();

			// 현재 지도 중심좌표로 주소를 검색
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);

			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			});

			function searchAddrFromCoords(coords, callback) {
			    // 좌표로  대략적인 주소 요청
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}

			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			        var infoDiv = document.getElementById('centerAddr');

			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                infoDiv.innerHTML = result[i].address_name;
			                break;
			            }
			        }
			    }    
			}
	});
	 

	</script>
</head>
<body>
	<div id="map" style="width:500px;height:400px;"></div>
	
	<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div class="hAddr">
        <span class="title">지도중심기준 행정동 주소정보</span>
        <span id="centerAddr"></span>
    </div>
</div>
</body>
</html>