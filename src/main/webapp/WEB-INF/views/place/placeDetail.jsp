<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c94691936a8b9eaab5061c790ac82c96&libraries=services,clusterer,drawing"></script>
<c:set var="context" value="${pageContext.request.contextPath}" />
<script src="${context}/resources/html/js/kakaoMap.js"></script>

 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<script>
	$(function() {
		function init() {
			var initBg = $(".sub-pic:first-child").css("background-image");
			$(".big-image").css("background-image", initBg);
		}
		
		init();
		
		$(".sub-pic").on("click", function() {
			var $this = $(this);
			var bgImage = $this.css("background-image");
			if(bgImage != 'none') {
				$(".big-image").css("background-image", bgImage);
			}
		});
		
		$('#like').on('click', function(){
			var user = "${sessionScope.userId}";
			if(user == ""){
				alert('로그인이 필요한 서비스입니다.');
				$(location).attr("href", "signIn.do");
			}else{
				$.ajax({
					url : 'placeAjaxThumbsUp.do',
					data : {
						placeCodeSeq : $('#placeCodeSeq').val(),
						userId : user
					},
					type : 'GET',
					dataType : 'json',
					success: function(data){
						$('.likes').html(data.maxLikes);
						if(data.like == 'login'){
							alert('로그인이 필요한 서비스입니다.');
						}
							if(data.like == 'didnt'){
							$('#like').html("♡");
						}
							if(data.like == 'did'){
							$('#like').html("♥");
						}
					},
					error: function(request, status, error){
						alert("code : " + request.status + "\n"
								+ "message : " + request.responseText + "\n"
								+ "error : " + error);
					}
				});
			}
		});
		
		$('#reserve').on('click', function() {
			var user = "${sessionScope.userId}";
			if(user == "") {
				alert('로그인이 필요한 서비스입니다.');
				location.href = 'signIn.do';
			}
		});
	});
</script>
<section>
  <input type="hidden" id="placeCodeSeq" value="${place.placeId }">
  <div class="container">
    <div class="title align-self-center">
      <h1>${place.placeName}</h1>
    </div>
    <hr>
      <div class="row section-left">
        <!-- main-left -->
        <div class="col">
          <div class="big-image"></div>
          <div class="d-flex justify-content-between mt-3">
          	<c:forEach var="i" begin="0" end="3">
         		<div class="sub-pic"
         		 style="background-image:
         		 url(<c:if test="${not empty images[i]}">${images[i].filePath});</c:if>
         		  background-size: cover; background-repeat: no-repeat"></div>
          	</c:forEach>
            
          </div>
          <div class="show-map mt-3 justify-content-center row">
          	<input type="hidden" name="latitude" value="${pp.latitude}" />
          	<input type="hidden" name="longitude" value="${pp.longitude}" />
          	<div id="map" style="width:500px;height:400px;"></div>
          </div>
        </div>
        <!-- main-right -->
        <div class="col">
          <div class="d-flex justify-content-between align-self-center">
            <div class="align-item-center" id="userId" style="margin: 0;"><span style="font-size: 32px;">&nbsp;${place.uId}님이 호스팅하는 아파트</span></div>
            <c:if test="${empty hostProfile}">
            	<div id="after-pic"><img src ="${context}/html/images/defaultprofile.jpg"></div>
            </c:if>
            <c:if test="${not empty hostProfile}">
	            <div id="after-pic"><img src ="${hostProfile}"></div>
            </c:if>
          </div>
          <hr>
          <div class="content-box">
            <div class="d-flex justify-content-start align-self-center">
              <i class='far fa-address-card icon'></i>&nbsp;
              <div class="content">${place.placeAddress} ${place.placeAddressDetail} </div>
            </div>
            <div class="d-flex justify-content-start align-self-center">
              <i class='fas fa-user-friends icon'></i>&nbsp; 
              <div class="content">${place.maxGuest} 명</div>
            </div>
            <div class="d-flex justify-content-start align-self-center">
              <i class='fas fa-home icon'></i>&nbsp;
              <div class="content">${place.placeType}</div>
            </div>
            <div class="d-flex justify-content-start align-self-center">
              <i class='fas fa-money-check icon'></i>&nbsp;
              <div class="content">${place.placePrice} / 박</div>
            </div>
            <div class="d-flex justify-content-start align-self-center">
              <i class='fas fa-phone icon'></i>&nbsp;
              <div class="content">${place.hostPhone}</div>
            </div>
            <c:if test="${not empty place.placeKakaoLink}">
            <div class="d-flex justify-content-start align-self-center">
              <i class='fas fa-link icon'></i>&nbsp;
              <div class="content">${place.placeKakaoLink}</div>
            </div>
            </c:if>
            <div class="d-flex justify-content-start align-self-center">
              <i class='fas fa-calendar icon'></i>&nbsp;
              <div class="content">
              ${fn:substring(place.placeOpenDate,0,10)} ~ ${fn:substring(place.placeCloseDate,0,10)}
              </div>
            </div>
            <div class="d-flex justify-content-start align-self-center">
              <div id="detail" class="content">${place.placeDesc}</div>
            </div>
            <div class="d-flex justify-content-center align-self-center">
            	<c:choose>
            	  <c:when test="${like eq 'login' }">
            	  	<b><button type="button" class="like" id="like">♡</button></b>
            	  </c:when>
            	  <c:when test="${like eq 'didnt' }">
            	  	<b><button type="button" class="like" id="like">♡</button></b>
            	  </c:when>
				  <c:otherwise>
				  	<b><button type="button" class="like" id="like">♥</button></b>
              	  </c:otherwise>
				</c:choose>
				<p class="likes" style="font-size: 30px;">${likes}</p>
            </div>
            <div class="d-flex justify-content-center align-self-center">
              <button type="button" id="reserve" class="btn btn-warning btn-lg btn-block" onClick="location.href='placeReservation.do?pId=${place.placeId}'">예약하기</button>	
            </div>
          </div>        
        </div>
      </div>      
    </div>
</section>
<%@ include file="../include/footer.jsp" %>