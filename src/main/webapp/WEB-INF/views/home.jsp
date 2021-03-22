<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}" />
<%@ include file="include/header.jsp" %>
<section>
<div class="row">
  <div class="col main-left">
    <h2>현재 위치의 숙소</h2>
    <span>예약하기 전에 코로나19 관련 여행 제한 사항을 확인하세요.</span>

    <div class="group-place">
      <div class="d-flex justify-content-between">
        <h3>서울틀별시 종로구</h3>
        <a href="#">더보기 > </a>
      </div>
      <div class="row">
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        
      </div>
    </div>

    <div class="group-place">
      <div class="d-flex justify-content-between">
        <h3>Instagram</h3>
      </div>
      <div class="row row-cols-3">
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        <div class="col place-item">
          <a href="#">
            <div class="place-image" style="background-image: url(https://a0.muscache.com/im/pictures/5b89cc73-f1e4-40e8-bb08-747fd7be786e.jpg?im_w=1200);">
            </div>
            <span>오직 당신만을 위한 루프탑</span>
          </a>
        </div>
        
      </div>
    </div>

    
  </div>
  <div class="col">
    <a href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false" target="_blank"><img width="600" height="600" src="https://map2.daum.net/map/mapservice?FORMAT=PNG&SCALE=2.5&MX=496065&MY=1129583&S=0&IW=504&IH=310&LANG=0&COORDSTM=WCONGNAMUL&logo=kakao_logo" style="border:1px solid #ccc"></a><div class="hide" style="overflow:hidden;padding:7px 11px;border:1px solid #dfdfdf;border-color:rgba(0,0,0,.1);border-radius:0 0 2px 2px;background-color:#f9f9f9;width:482px;"><strong style="float: left;"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/logo_kakaomap.png" width="72" height="16" alt="카카오맵"></strong><div style="float: right;position:relative"><a style="font-size:12px;text-decoration:none;float:left;height:15px;padding-top:1px;line-height:15px;color:#000" target="_blank" href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false">지도 크게 보기</a></div></div>

  </div>
</div>
</section>
<%@ include file="include/footer.jsp" %>
