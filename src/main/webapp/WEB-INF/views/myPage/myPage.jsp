<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<!--myPageHostCheck / 마이페이지_내 숙소 예약현황-->
<section>
 
    <div class="row d-flex justify-content-around">
      <!--메인-->
      <main class="col-7 py-md-5 pl-md-4 " >

          <h1>마이페이지</h1>
          <hr>
          <div class="card-deck">
            <div class="card bg-primary pt-3 pb-3">
              <div class="card-body text-center">
                <div class="circle_bg">
                  <i class="fa fa-cogs" style="font-size: 80px;"></i>
                </div>
                <p class="card-text mt-5" style="font-size: 25px;">회원정보</p>
              </div>
            </div>
            <div class="card bg-primary pt-3 pb-3">
              <div class="card-body text-center">
                <div class="circle_bg">
                  <i class="fa fa-check-square-o" style="font-size: 80px;"></i>
                </div>
                <p class="card-text mt-5" style="font-size: 30px;">내 예약 조회</p>
              </div>
            </div>
            <div class="card bg-primary pt-3 pb-3">
              <div class="card-body text-center">
                <div class="circle_bg">
                  <i class="fa fa-calendar-check-o" style="font-size: 70px;"></i>
                </div>
                <p class="card-text mt-5" style="font-size: 30px;">내 숙소 예약 현황</p>
              </div>
            </div>
          </div>
       </main>
      <!--메인-->
    </div>
</section>
<%@ include file="../include/footer.jsp" %>