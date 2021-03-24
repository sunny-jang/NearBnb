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
		$(".find-address").on("click", function() {
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {

			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
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
        
            
            console.log(new FormData($("#addForm")[0]).entries().next())
            
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
	});
</script>
<section class="row justify-content-center m-0">
  <form action="" class="col-8" enctype="multipart/form-data" id="addForm" accept-charset="utf-8">
    <h2 class="mt-3 mb-3">
      이름님이 호스팅하는 아파트
    </h2>
    <div class="row">
      <div class="col justify-content-center">
          <div class="image-add-form">
            <div class="big-image align-self-center">dd</div>
            <div class="d-flex justify-content-between w-100 mt-3">
              <div class="file-upload">
                <a href="#">
                  <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0 aa" name="imageUpload">
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
            <input type="text" placeholder="숙소명" name="" class="w-75 p-2">
            <i class="fa fa-user-circle" style="font-size: 35px;"></i>
          </div>
          <div class="d-flex justify-content-between mb-3">
            <div class="d-flex">
              <i class="fa fa-address-card-o pr-2" style="font-size:24px"></i>주소
            </div>
            <div class="w-50">
              <input type="text" placeholder="주소를 입력해주세요." name="" class="w-100 p-2 mb-2"><button type="button" class="btn btn-primary find-address">등록하기</button>
              <input type="text" placeholder="상세 주소를 입력해주세요." name="" class="w-100 p-2">
            </div>
            
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-users pr-2" style="font-size:24px"></i>최대 인원수 지정
            </div>
            <input type="number" placeholder="ex) 4" name="" class="w-50 p-2">
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa fa-home pr-2" style="font-size:24px"></i>숙소 유형
            </div>
            <select name="" id="" class="w-50 p-2">
              <option value="아파트">아파트</option>
              <option value="빌라">빌라</option>
              <option value="콘도">콘도</option>
            </select>
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-credit-card pr-2" style="font-size:24px"></i>1박 당 금액
            </div>
            <input type="text" placeholder="ex) 89,000" name="" class="w-50 p-2">
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-phone pr-2" style="font-size:24px"></i>비상 연락망
            </div>
            <input type="text" placeholder="ex) 010-2222-3333" name="" class="w-50 p-2">
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-chain pr-2" style="font-size:24px"></i>카카오톡
            </div>
            <input type="text" placeholder="http://kakao" name="" class="w-50 p-2">
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class='fa fa-calendar pr-2' style="font-size:24px"></i>날짜 선택
            </div>
            <div class="d-flex justify-content-end">
              <input type="date" name="" class="w-50 p-2">
              <input type="date" name="" class="w-50 p-2 ml-2">
            </div>
            
          </div>
          <div class=" d-flex align-self-stretch mb-3">
            <textarea name="" id="" rows="5" class="flex-fill"></textarea>
          </div>
          <div class="btn-group d-flex justify-content-end  mb-3">
           
            <button type="button" class="btn btn-primary">등록하기</button>
          </div>
        </div>
        </div>
        
    </div>
  </form>
  
</section>
<%@ include file="../include/footer.jsp" %>