<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c94691936a8b9eaab5061c790ac82c96&libraries=services,clusterer,drawing"></script>
 <c:set var="context" value="${pageContext.request.contextPath}" />
 <script src="${context}/resources/html/js/dateController.js"></script>
 <script src="${context}/resources/html/js/kakaoMap.js"></script>
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
var date = new PlaceDate();
	$(function() {
		
		$("input[name=placeOpenDate]").attr("min", date.getDateFormat(new Date()));
		
		$("#submitPlace").on("click", function() {
			var formData = new FormData($("#addForm")[0]);
			var latitude = $("input[name=latitude]").val();
			var longitude = $("input[name=longitude]").val();
		});
		
		$("input[name=imageUpload]").on("change", function() {
			var _this = $(this);
			var file = _this[0].files[0];
			var fileName = new Date().getTime() + file.name;
			
		    // 확장자 검사
		    if(!checkFileType(fileName)) {
		    	return;
		    }
		    
		    var storageRef = firebase.storage().ref();

		    storageRef
		    .child(`images/`+fileName)
		    .put(file)
		    .on('state_changed', snapshot => {
		           console.log(snapshot)
		       }, error => {
		           console.log(error);
		       }, (res) => {
		           let storageUrl = 'images/'+fileName;
		           
		           storageRef.child(storageUrl).getDownloadURL().then(function(url) {   // 저장된 파일의 http url 주소 받아오기
		            // 이미지 표시
		        	   _this.closest("div").css("background-image", "url("+url+")");
		           	$(".big-image").css("background-image", "url("+url+")");
		           	
		           	// input에 값 넣어서 form에 추가
		           	let i = document.createElement("input");
		           	i.setAttribute("type","hidden");
					i.setAttribute("name","imagePath");
					i.setAttribute("value",url);
					$("#addForm").append(i);
		          }).catch(function(error) {});
		           
		           let i = document.createElement("input");
					i.setAttribute("type","hidden");
					i.setAttribute("name","changedImages");
					i.setAttribute("value",fileName);
					
					$("#addForm").append(i);
		       }
		    );
		})
	});
	
	// 확장자 체크
	function checkFileType(fileName) {
		var reg = /.+\./;
	    var checkFile = fileName.replace(reg.exec(fileName),"").toLowerCase();
	    if(checkFile != "jpg" && checkFile != "png") {
	    	alert("jpg 또는 png 형식의 사진만 올릴 수 있습니다.")
	    	return false;
	    }
	    
	    return true;
	}

</script>
<section class="row justify-content-center m-0">
  <form action="" class="col-8" method="POST" enctype="multipart/form-data" id="addForm" accept-charset="utf-8">
    <input type="hidden" name="getLocation" value="current">
    <h2 class="mt-3 mb-3">
      ${userId }님이 호스팅하는 숙소
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

          <div class="show-map mt-3 mb-3 justify-content-center row">
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
            	<div class="d-flex">
            		<input type="text" placeholder="주소를 입력해주세요." readonly name="placeAddress" id="address" class="w-75 p-2 mb-2 col-8" required style="background-color: #eee">
              		<button type="button" class="btn btn-primary find-address p-1 pt-2 pb-2 w-25 mb-2 col" style="box-sizing:border-box; font-size: 14px">주소 검색</button>
            	</div>
              
              <input type="text" placeholder="상세 주소를 입력해주세요." name="placeAddressDetail" class="w-100 p-2" required id="addressDetail">
              <input type="hidden" name="latitude" class="w-100 p-2" required>
              <input type="hidden" name="longitude" class="w-100 p-2" required>
            </div>
            
          </div>
          <div class="d-flex justify-content-between mb-3 align-items-center">
            <div>
              <i class="fa fa-users pr-2" style="font-size:24px"></i>최대 인원수 지정
            </div>
            <input type="number" placeholder="ex) 4" name="maxGuest" class="w-50 p-2" required min="1">
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
            <input type="text" placeholder="ex) 01022223333" name="hostPhone" class="w-50 p-2" required>
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
              <input type="date" name="placeCloseDate" class="w-50 p-2 ml-2" required>
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
<script>
    
</script>
<%@ include file="../include/footer.jsp" %>