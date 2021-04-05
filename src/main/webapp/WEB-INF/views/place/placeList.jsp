<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}" />
<%@ include file="../include/header.jsp" %>
<script>
$(function() {
	console.log(localStorage.placeList);
	var pList = JSON.parse(localStorage.placeList);
	
	pListAjax(pList);
	
});

</script>

<section>

  <div class="row">
    <div class="col main-left">
      <div class="place-list">
        <div class="place-li ">
          <a href="#" class="row">
            <div class=" col-5 align-self-center">
              <div class="place-image" style="background-color: black;"></div>
            </div>
            <div class="col-7">
              <span class="place-host">${ }님의 숙소</span>
              <h5 class="place-name ellipsis2">숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름</h5>
              <span class="place-option">최대인원 4명 . 숙소 유형 아파트</span>
              <p class="place-des ellipsis2">여름휴가 간 동안 집이 비어서 올리게 되었습니다~ 깨끗하게 써주실 분 찾습니다~^^* 주실 분 찾습니다~^^* 주실 분 찾습니다~^^* .....</p>
              <div class="d-flex justify-content-between">
                <div>16 <i class="fa fa-heart"></i></div>
                <div>30,000 원 / 박</div>
              </div>
            </div>
          </a>
          
        </div>
        
      </div>
    </div>
    
    <div class="col">
      <!-- <a href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false" target="_blank"><img width="600" height="600" src="https://map2.daum.net/map/mapservice?FORMAT=PNG&SCALE=2.5&MX=496065&MY=1129583&S=0&IW=504&IH=310&LANG=0&COORDSTM=WCONGNAMUL&logo=kakao_logo" style="border:1px solid #ccc"></a><div class="hide" style="overflow:hidden;padding:7px 11px;border:1px solid #dfdfdf;border-color:rgba(0,0,0,.1);border-radius:0 0 2px 2px;background-color:#f9f9f9;width:482px;"><strong style="float: left;"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/logo_kakaomap.png" width="72" height="16" alt="카카오맵"></strong><div style="float: right;position:relative"><a style="font-size:12px;text-decoration:none;float:left;height:15px;padding-top:1px;line-height:15px;color:#000" target="_blank" href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false">지도 크게 보기</a></div></div> -->
  	<%@ include file="../mainMap.jsp" %>
    </div>
  </div>
</section>
<%@ include file="../include/footer.jsp" %>