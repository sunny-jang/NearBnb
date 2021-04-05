<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}" />

<%@ include file="include/header.jsp" %>

<script>
  function getInstaFeed() {
    $.ajax({
     url: 'https://graph.instagram.com/me/media?fields=id,media_type,media_url,permalink,caption,username,timestamp&access_token=IGQVJYVlhhMjJmOVA3cTFqeDFSVGJjOHJaaUF2cmdDNGhwZAXp4WVRUVmdlQ1BTX19janVLRDR2dlNDanpzMG8yLVF2ekpTTXZA0RkVMclptTmNUcHAzZA29Bc05ONlhvQ2lXTTF0YVZAVcFdod0xDbjk4eQZDZD',
     method: 'get',
     dataType: 'json',
     success: function(data) {
       $("#instafeed").text(data.data[0].id);
       $("#aaa").text(data.data[0].media_url).attr("href",data.data[0].media_url);
      
       for( var i=0; i<6; i++){
         $("#instaurl"+[i]).attr("href",data.data[i].permalink);
         $("#instacaption"+[i]).text(data.data[i].caption);
         $("#imageaaa"+[i]).css("background-image","url("+data.data[i].media_url+")");//이미지
       }
     }
   })         
 };

(function() {
 	getInstaFeed()
})()
//instagramAPI   

function searchList(data){
	for(var i=0; i<3; i++){
	$('#list'+[i]).html(data.pointList[i].placeName);
	listImg = "url("+data.pointList[i].placeImage+")";
	$("#listImg"+[i]).css("background-image", listImg); 
	$("#plink"+[i]).attr("href", "placeDetail.do?pId="+data.pointList[i].placeId);
	}
}

//정보저장
function placeList(data){
	var placeList = [];
	
	for(var i=0; i<data.pointList.length; i++){
		var placeObj = {
			placeId : data.pointList[i].placeId,
			placeName : data.pointList[i].placeName, 	
			placeImage : data.pointList[i].placeImage,
		}	
		placeList.push(placeObj);
	}
	localStorage.placeList = JSON.stringify(placeList);
}


</script>

<section>
<div class="row">
  <div class="col main-left">
    <h2>현재 위치의 숙소</h2>
    <span>예약하기 전에 코로나19 관련 여행 제한 사항을 확인하세요.</span>
	<br/>
	<h5>위치로 숙소를 검색할 수 있습니다. :)</h5>
	<br/>
	<input type="text" name="address" id="address" placeholder="위치를 입력해 주세요."  class="w-75"/>
	<button class="find-location btn-primary">검색</button>
    <div class="group-place">
      <div class="d-flex justify-content-between">
        <h2><span id="centerAddr"></span></h2><!-- 주소표시 -->
        <a href="placeList.do">더보기 > </a>
      </div>
      <div class="row">
      
      <c:forEach var="i" begin="0" end="2">
        <div class="col place-item" >
          <a href="#" id="plink${i}">
            <div class="place-image" id ="listImg${i}"></div>
            <span id="list${i}"></span>
          </a>
        </div>
       </c:forEach> 
      </div>
    </div>

    <div class="group-place">
    <div class="d-flex justify-content-between">
      <h3>Instagram</h3>
    </div>
    <div class="row row-cols-3">
     <c:forEach var="i" begin="0" end="5">
      <div class="col place-item">
        <a href="" id="instaurl${i}">
          <div class ="place-image" id="imageaaa${i}">
          </div>

          <span id="instacaption${i}" class="ellipsis2"></span>
        </a>
      </div>
      
      </c:forEach> 
    </div>
  </div>

    
  </div>
  <div class="col m-0 p-0">

  <%@ include file="mainMap.jsp" %>
  </div>
</div>
</section>
<%@ include file="include/footer.jsp" %>
