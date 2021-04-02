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
		})
	})
</script>
<section>
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
         		 url(./resources/html/images/<c:if test="${not empty images[i]}">${images[i].fileChangedName});</c:if>
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
          <div class="d-flex justify-content-between">
            <h2>&nbsp;${place.uId}님이 호스팅하는 아파트</h2>
            <div class="profile" style="background-color: black;"></div>
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
              <div id="like">♥ ${place.placeThumb}</div>
            </div>
            <div class="d-flex justify-content-center align-self-center">
              <button type="button" class="btn btn-warning btn-lg btn-block" onClick="location.href='placeReservation.do?pId=${place.placeId}'">예약하기</button>	
            </div>
          </div>        
        </div>
      </div>      
    </div>
</section>
<%@ include file="../include/footer.jsp" %>