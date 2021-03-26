<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section>
  <div class="container">
    <div class="title align-self-center">
      <h1>${place.placeName}</h1>
    </div>
    <hr>
      <div class="row section-left">
        <!-- main-left -->
        <div class="col">
          <div class="main-pic"></div>
          <div class="d-flex justify-content-between mt-3">
            <div class="sub-pic"></div>
            <div class="sub-pic"></div>
            <div class="sub-pic"></div>
            <div class="sub-pic"></div>
          </div>
          <div class="show-map mt-3 justify-content-center row">
            <a href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false" target="_blank"><img width="500" height="500" src="https://map2.daum.net/map/mapservice?FORMAT=PNG&SCALE=2.5&MX=496065&MY=1129583&S=0&IW=504&IH=310&LANG=0&COORDSTM=WCONGNAMUL&logo=kakao_logo" style="border:1px solid #ccc"></a><div class="hide" style="overflow:hidden;padding:7px 11px;border:1px solid #dfdfdf;border-color:rgba(0,0,0,.1);border-radius:0 0 2px 2px;background-color:#f9f9f9;width:482px;"><strong style="float: left;"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/logo_kakaomap.png" width="72" height="16" alt="카카오맵"></strong><div style="float: right;position:relative"><a style="font-size:12px;text-decoration:none;float:left;height:15px;padding-top:1px;line-height:15px;color:#000" target="_blank" href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false">지도 크게 보기</a></div></div>
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
              <div class="content">호스트 전화번호 들어가는 곳</div>
            </div>
            <div class="d-flex justify-content-start align-self-center">
              <div id="detail" class="content">숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 숙소 상세 들어가는 곳 </div>
            </div>
            <div class="d-flex justify-content-center align-self-center">
              <div id="like">♥ 12</div>
            </div>
            <div class="d-flex justify-content-center align-self-center">
              <button type="button" class="btn btn-warning btn-lg btn-block">예약하기</button>	
            </div>
          </div>        
        </div>
      </div>      
    </div>
</section>
<%@ include file="../include/footer.jsp" %>