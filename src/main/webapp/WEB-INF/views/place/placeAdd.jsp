<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section class="row justify-content-center m-0">
  <form action="" class="col-8">
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
                  <input type="file" class="opacity-0">
                </a>
              </div>
              <div class="file-upload">
                <a href="#">
                  <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0">
                </a>
              </div>
              <div class="file-upload">
                <a href="#">
                   <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0">
                </a>
              </div>
              <div class="file-upload">
                <a href="#">
                  <i class="fa fa-camera" style="font-size: 25px;"></i>
                  <input type="file" class="opacity-0">
                </a>
              </div>
              
            </div>
          </div>

          <div class="show-map mt-3 justify-content-center row">
            <a href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false" target="_blank"><img width="500" height="500" src="https://map2.daum.net/map/mapservice?FORMAT=PNG&SCALE=2.5&MX=496065&MY=1129583&S=0&IW=504&IH=310&LANG=0&COORDSTM=WCONGNAMUL&logo=kakao_logo" style="border:1px solid #ccc"></a><div class="hide" style="overflow:hidden;padding:7px 11px;border:1px solid #dfdfdf;border-color:rgba(0,0,0,.1);border-radius:0 0 2px 2px;background-color:#f9f9f9;width:482px;"><strong style="float: left;"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/logo_kakaomap.png" width="72" height="16" alt="카카오맵"></strong><div style="float: right;position:relative"><a style="font-size:12px;text-decoration:none;float:left;height:15px;padding-top:1px;line-height:15px;color:#000" target="_blank" href="https://map.kakao.com/?urlX=496065&urlY=1129583&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false">지도 크게 보기</a></div></div>
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
              <input type="text" placeholder="주소를 입력해주세요." name="" class="w-100 p-2 mb-2">
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