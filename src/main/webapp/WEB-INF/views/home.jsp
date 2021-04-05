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
  <div class="col">

  <%@ include file="mainMap.jsp" %>
<!--  <script src="/nearbnb/resources/html/js/kakaoMap.js"></script> -->
  <!--  
    <a href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false" target="_blank"><img width="600" height="600" src="https://map2.daum.net/map/mapservice?FORMAT=PNG&SCALE=2.5&MX=496065&MY=1129583&S=0&IW=504&IH=310&LANG=0&COORDSTM=WCONGNAMUL&logo=kakao_logo" style="border:1px solid #ccc"></a><div class="hide" style="overflow:hidden;padding:7px 11px;border:1px solid #dfdfdf;border-color:rgba(0,0,0,.1);border-radius:0 0 2px 2px;background-color:#f9f9f9;width:482px;"><strong style="float: left;"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/logo_kakaomap.png" width="72" height="16" alt="카카오맵"></strong><div style="float: right;position:relative"><a style="font-size:12px;text-decoration:none;float:left;height:15px;padding-top:1px;line-height:15px;color:#000" target="_blank" href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false">지도 크게 보기</a></div></div>
-->
  </div>
</div>
</section>
<%@ include file="include/footer.jsp" %>
