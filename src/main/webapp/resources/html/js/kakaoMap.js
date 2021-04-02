$(function() {
	
	var latitude = $("input[name=latitude]").val();
	var longitude = $("input[name=longitude]").val();
	initLocation();
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
		//지도 생성 및 객체 리턴
	var map = new kakao.maps.Map(container, options);
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();
	var marker = new kakao.maps.Marker({map: map});
	var infowindow =  new kakao.maps.InfoWindow({map: map})
	infowindow.open(map, marker);

	function initLocation() {
		if (navigator.geolocation) { // GPS를 지원하면
			navigator.geolocation.getCurrentPosition(function(position) {
				var $checkCurrent =  $("input[name=getLocation]");
				var latitude_ = latitude;
				var longitude_ = longitude;
				
				if($checkCurrent.val() == 'current') {
					latitude_ = position.coords.latitude;
					longitude_ = position.coords.longitude;
				}
			
			var coords = new kakao.maps.LatLng(latitude_, longitude_);//x,y좌표값
			
			infowindow.setPosition(coords);
			infowindow.setContent('<div style="width:150px;text-align:center;padding:6px 0; margin-bottom: -2px">현재 위치</div>')
			marker.setPosition(coords);
			
			//지도 생성 및 객체 리턴
			map.setCenter(coords);
			
			$("input[name=latitude]").val(latitude);
			$("input[name=longitude]").val(longitude);
		}, function(error) {
			console.error(error);
		}, {
			enableHighAccuracy: false,
			maximumAge: 0,
			timeout: Infinity
		});
		
		} else {
		alert('GPS를 지원하지 않습니다');
		}
	}


	//TDDO fetch api로 바꾸기
	$(".find-address").on("click", function() {
		// 주소로 좌표를 검색합니다
		var address = $("#address").val();
		
			// 정상적으로 검색이 완료됐으면  
			geocoder.addressSearch(address, function(result, status) {
				if (status === kakao.maps.services.Status.OK) {
				latitude_ = result[0].y;
				longitude_ = result[0].x;
				var coords = new kakao.maps.LatLng(latitude_, longitude_);

				marker.setPosition(coords);
				infowindow.setPosition(coords);
				infowindow.setContent('<div style="width:150px;text-align:center;padding:6px 0; margin-bottom: -2px">숙소 위치</div>');
				infowindow.setAltitude(30);
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				$("input[name=latitude]").val(latitude_);
				$("input[name=longitude]").val(longitude_);
				map.setCenter(coords);
			} else {
				alert("정확한 주소를 적어주시고 지도상의 마커를 확인해주세요\nex) 인천광역시 연희로 42번길 ");
			}
		});
	})
});