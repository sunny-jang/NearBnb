<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c94691936a8b9eaab5061c790ac82c96&libraries=services,clusterer,drawing"></script>
 <c:set var="context" value="${pageContext.request.contextPath}" />
 <script src="${context}/resources/html/js/dateController.js"></script>
 <script src="${context}/resources/html/js/kakaoMap.js"></script>
<script>
//dateController.js 에 클래스로 분리
var date = new PlaceDate();
	$(function() {
		var date = new PlaceDate();
		$("input[name=placeOpenDate]").attr("min", date.getDateFormat(new Date()))
		
		//TDDO fetch api로 바꾸기
		$("input[name=imageUpload]").on("change", function() {
			var _this = $(this);
			var file = _this[0].files[0];
            var formData = new FormData();
            formData.append("image", file);

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
			var latitude = $("input[name=latitude]").val();
			var longitude = $("input[name=longitude]").val();
		})
	});

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
              <input type="text" placeholder="주소를 입력해주세요." name="placeAddress" id="address" class="w-75 p-2 mb-2" required>
              <button type="button" class="btn btn-primary find-address p-1 pt-2 pb-2" style="box-sizing:border-box">지도에 표시</button>
              <input type="text" placeholder="상세 주소를 입력해주세요." name="placeAddressDetail" class="w-100 p-2" required>
              <input type="hidden" name="latitude" class="w-100 p-2" required>
              <input type="hidden" name="longitude" class="w-100 p-2" required>
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
            <input type="text" placeholder="http://kakao" name="hostKakaoLink" class="w-50 p-2" id="kakao">
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class='fa fa-calendar pr-2' style="font-size:24px"></i>날짜 선택
            </div>
            <div class="d-flex justify-content-end">
              <input type="date" name="placeOpenDate" class="w-50 p-2" required min="" onChange="date.setOpenDate(this)">
              <input type="date" name="placeCloseDate" class="w-50 p-2 ml-2" required min="2021-03-26">
            </div>
            
          </div>
          <div class=" d-flex align-self-stretch mb-3">
            <textarea name="placeDesc" id="" rows="5" class="flex-fill" required></textarea>
          </div>
          <div class="btn-group d-flex justify-content-end  mb-3">
           
            <button type="submit" class="btn btn-primary" id="submitPlace">등록하기</button>
          </div>
        </div>
        </div>
        
    </div>
  </form>
  
</section>
<%@ include file="../include/footer.jsp" %>