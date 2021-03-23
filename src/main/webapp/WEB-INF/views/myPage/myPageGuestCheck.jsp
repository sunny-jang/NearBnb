<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/header.jsp" %>
<!--myPageGuestCheck / 마이페이지_내 예약 조회페이지-->
<section>
 
    <div class="row ">
      <%@ include file="../include/sidemenu.jsp" %>

      <!--메인-->
      <main class="col-8 py-md-5 pl-md-4 " >
        <h1>내 예약 조회 페이지</h1>
        <hr>
        <h6 style="color: rgb(206, 0, 0);">※ 모든 숙소의 체크인 시간은 3시 / 체크아웃 시간은 12시 입니다.</h6>
<!--place-list-->
        <div class="card_content">
          <div class="place-li_je">
            <a class="row"  data-toggle="modal" data-target="#myModal">
              <div class="place-image col-2 align-self-center">
                <div class="place-image" style="background-color: black;"></div>
              </div>
              <div class="col-8 card-item">
                <h5 class="place-name ellipsis2 "> 숙소이름 숙소이름 숙소이름숙소이름 숙소이름 숙소이름숙소이름 숙소이름 숙소이름숙소이름 숙소이름 숙소이름숙소이름 숙소이름 숙소이름숙소이름 숙소이름 숙소이름</h5>
                  <p>총 인원수 : 4 명</p>
                 
                  <div class="btn-more" ><!--맨 밑으로 붙일부분-->
                    <div  data-toggle="modal" data-target="#myModal">상세보기</div>
                  </div>
              </div>
              <div class="col-2 card-item"> 
                <div class="side-text">
                  <div >
                    결제일<br>
                    2021-03-20</div>
                </div>
              </div>
            </a>
          </div>
        </div>
      <!--/place-list-->
      <hr>
      
      </main>
      <!--/메인-->
   
      <!--모달-->
      <div class="container">
       
        <div class="modal fade" id="myModal">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
            
              <!-- Modal Header -->
              <div class="modal-header">
                <h2 class="place-name ">숙소이름</h2>
              </div>
              
              <!-- Modal body -->
              <div class="modal-body">
                <div class="place-image col-4 align-self-center float-right">
                  <div class="place-image" style="background-color: black;"></div>
                </div>
                <div>
                  <br>
                  <div>
                    인원
                    <h5> 4 명</h5>
                    <br>
                    금액
                    <h5> 150,000 원</h5>
                  </div>
                  <br>
                  <div >
                   <div class="modal-text">
                    체크인
                    <h5>2021.03.24</h5>
                   </div>
                 <div class="modal-text"><h3>~</h3></div>
                   <div class="modal-text">
                    체크아웃
                    <h5>2021.03.27</h5>
                   </div>
                  </div>
                  <br>
                  <div>
                    주소
                    <h5>서울특별시 중구 충무로 3길, 202동 305호
                      <br>@@동 @@@@아파트
                    </h5>
                  </div>
                  <hr>
                  <div>
                    <h5>이용 시 주의사항 </h5>
                    <p>
                      1. 청소 및 시설 보증금 2만원(입실전에 입금) *퇴실 후 방 확인 뒤에 당일~익일 사이에 반환됩니다.<br>
                      2.숙소 내부 절대 금연입니다. (내부 흡연으로 인한 오염 및 기물 훼손 시 클리닝 비용 청구됩니다)<br>
                      3.기물 파손 / 분실 시 구매가로 청구됩니다.<br>
                      4.미성년자 이용 불가능합니다.(적발 시 즉시 퇴장 및 환불 불가)  <br>
                      5.퇴실 30분 전 사전 연락드리고 있으며 퇴실 시 정리 정돈 및 분리수거 부탁드립니다.<br>
                      6.24시간 카톡문의 가능합니다. 카카오톡 오픈채팅<br>
                      7.예약 시 정확한 인원수를 입력해 주세요(인원수 1명으로 예약시 예약 취소됩니다) 예약 완료 후 추가 인원 발생 시 사전에 반드시 말씀해 주셔야 합니다.<br>
                    </p>
                  </div>
                  <div>
                    연락처
                    <h5>
                      <i class="fa fa-phone" style="font-size:24px"></i> : 010 - 1234 -1234 / <a href="#"><i class="fa fa-comments-o" style="font-size:24px"></i> </a>
                    </h5>
                  </div>
                  <br>
                 <div class="text-price">
                  <h7>결제일<br>2021-03-20</h7>
                 </div>
                </div>
                
              </div>
              <!-- Modal footer -->
              <div class="modal-footer d-flex justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">예약취소</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal"> 닫기</button>
              </div>  
            </div>
          </div>
        </div>
        
      </div>
      <!--/모달-->
</section>
<%@ include file="../include/footer.jsp" %>