<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c94691936a8b9eaab5061c790ac82c96&libraries=services,clusterer,drawing"></script>
 <c:set var="context" value="${pageContext.request.contextPath}" />
<script>
	$(function() {
		
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();
		
		var latitude;
		var longitude;
		
		$(".find-address").on("click", function() {
			// 주소로 좌표를 검색합니다
			var address = $("#address").val();
			geocoder.addressSearch(address, function(result, status) {

			    // 정상적으로 검색이 완료됐으면  
			     if (status === kakao.maps.services.Status.OK) {
			    	
			    	latitude = result[0].y;
			    	longitude = result[0].x;
			    	var coords = new kakao.maps.LatLng(latitude, longitude);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">숙소 위치</div>'
			        });
			        infowindow.open(map, marker);

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});    
		})
		
		
		
		$("input[name=imageUpload]").on("change", function() {
			var _this = $(this);
			console.log(_this)
			var file = _this[0].files[0];
            var formData = new FormData();
            formData.append("image", file);
            
            console.log(formData.entries().next())

			$.ajax({
				url: 'addFile',
				method: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function(data) {
					_this.closest("div").css("background-image", "url(/nearbnb/resources/html/images/"+data+")");
					$(".big-image").css("background-image", "url(/nearbnb/resources/html/images/"+data+")");
					
				},
				error: function(error) {
					console.log();
				}
			})
		})
		
		$("#submitPlace").on("click", function() {
			
			var formData = new FormData($("#addForm")[0]);
			
			formData.append("latitude", latitude);
			formData.append("longitude", longitude);
			
			
			$("#addForm").submit();
			 $.ajax({
				url: 'placeAdd.do',
				method: 'post',
				processData: false,
				contentType: false,
				data: formData,
				success: function(data) {
					console.log("성공");
					location.href="placeList.do"
				}
			}) 
		})
	
	});
	
	// 오픈일 선택시
	function setOpenDate(e) {
		var openDate = new Date(e.value);
		// min 날짜를 설정
		setMinDate(openDate);
		// 마감일 보다 큰 날짜를 선택했는지 체크
		checkOverDate(openDate);
	}
	
	// 마감일 보다 큰 날짜를 선택했는지 체크
	function checkOverDate(date) {
		var openDate = date;
		var closeDate = new Date($("input[name=placeCloseDate]").val())
		
		if(closeDate <= openDate) {
			alert("마감 날짜보다 클 수는 없습니다. 다시 선택해주세요.");
			
			$("input[name=placeOpenDate]").val(getDateFormat(new Date()));
		}
	}
	
	// min 날짜를 설정
	function setMinDate(date) {
		var date_ = new Date();
			date_.setDate(date.getDate()+1)
		var nextDate = getDateFormat(date_)
		
		$("input[name=placeCloseDate]").attr("min", nextDate);
	}
	
	// 숫자형 날짜 데이터를 포멧에 맞게 변환
	function getDateFormat(date) {
		var yyyy_mm_dd;
		
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		
		yyyy_mm_dd = year + "-" + month + "-" + day;
		
		return yyyy_mm_dd;
	}
</script>
<section class="row justify-content-center m-0">
  <form action="" class="col-8" method="POST" enctype="multipart/form-data" id="addForm" accept-charset="utf-8">
    <h2 class="mt-3 mb-3">
      이름님이 호스팅하는 아파트
    </h2>
    <div class="row">
      <div class="col justify-content-center">
          <div class="image-add-form">
            <div class="big-image align-self-center"></div>
            <div class="d-flex justify-content-between w-100 mt-3">
              <div class="file-upload">
                <a href="#">
                  <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0 aa" name="imageUpload" required>
                </a>
              </div>
              <div class="file-upload">
                <a href="#">
                  <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0 bb" name="imageUpload">
                </a>
              </div>
              <div class="file-upload">
                <a href="#">
                   <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0" name="imageUpload">
                </a>
              </div>
              <div class="file-upload">
                <a href="#">
                  <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0" name="imageUpload">
                </a>
              </div>
              
            </div>
          </div>

          <div class="show-map mt-3 justify-content-center row">
          <div id="map" style="width:500px;height:400px;"></div>
          </div>
         
      </div>
  
      <div class="col add-form">
        <div class="add-fixed">
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <input type="text" placeholder="숙소명" name="placeName" class="w-75 p-2" required>
            <i class="fa fa-user-circle" style="font-size: 35px;"></i>
          </div>
          <div class="d-flex justify-content-between mb-3">
            <div class="d-flex">
              <i class="fa fa-address-card-o pr-2" style="font-size:24px"></i>주소
            </div>
            <div class="w-50">
              <input type="text" placeholder="주소를 입력해주세요." name="placeAddress" id="address" class="w-100 p-2 mb-2" required><button type="button" class="btn btn-primary find-address">지도에 표시</button>
              <input type="text" placeholder="상세 주소를 입력해주세요." name="placeaddressDetail" class="w-100 p-2" required>
            </div>
            
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-users pr-2" style="font-size:24px"></i>최대 인원수 지정
            </div>
            <input type="number" placeholder="ex) 4" name="maxGuest" class="w-50 p-2" required>
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa fa-home pr-2" style="font-size:24px"></i>숙소 유형
            </div>
            <select name="placeType" id="" class="w-50 p-2" required>
              <option value="아파트">아파트</option>
              <option value="빌라">빌라</option>
              <option value="콘도">콘도</option>
            </select>
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-credit-card pr-2" style="font-size:24px"></i>1박 당 금액
            </div>
            <input type="text" placeholder="ex) 89000" name="placePrice" class="w-50 p-2" required>
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-phone pr-2" style="font-size:24px"></i>비상 연락망
            </div>
            <input type="text" placeholder="ex) 010-2222-3333" name="hostPhone" class="w-50 p-2" required>
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-chain pr-2" style="font-size:24px"></i>카카오톡
            </div>
            <input type="text" placeholder="http://kakao" name="hostKakaoLink" class="w-50 p-2" required>
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class='fa fa-calendar pr-2' style="font-size:24px"></i>날짜 선택
            </div>
            <div class="d-flex justify-content-end">
              <input type="date" name="placeOpenDate" class="w-50 p-2" required min="2021-03-25" onChange="setOpenDate(this)">
              <input type="date" name="placeCloseDate" class="w-50 p-2 ml-2" required min="2021-03-26">
            </div>
            
          </div>
          <div class=" d-flex align-self-stretch mb-3">
            <textarea name="placeDesc" id="" rows="5" class="flex-fill" required></textarea>
          </div>
          <div class="btn-group d-flex justify-content-end  mb-3">
           
            <button type="button" class="btn btn-primary" id="submitPlace">등록하기</button>
          </div>
        </div>
        </div>
        
    </div>
  </form>
  
</section>
<%@ include file="../include/footer.jsp" %>