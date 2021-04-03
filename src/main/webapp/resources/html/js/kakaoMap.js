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
	function FindLocationMap() {
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
	}
	
	$(".find-address").on("click", function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address").value = extraAddr;
                
                } else {
                    document.getElementById("address").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addressDetail").focus();
                FindLocationMap();
            }
        }).open();
    });
});