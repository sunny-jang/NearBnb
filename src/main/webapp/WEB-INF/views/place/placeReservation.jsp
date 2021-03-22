<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script type='text/javascript'>
  //켈린더
    $(document).ready(function() {
  
      var date = new Date();
      var d = date.getDate();
      var m = date.getMonth();
      var y = date.getFullYear();
  
      $('#calendar').fullCalendar({
        header : {
          left : 'prev',
          center : 'title',
          right : 'next'
        },
        editable : true,
        events: [
          {
            title: 'All Day Event',
            start: '2021-03-20'
          },
          {
            title: 'All Day Event',
            start: '2021-03-10',
            end: '2021-03-15'
          },
        ]
      });
    });
</script>
<section>
  <div class="container">
    <div class="title">
      <h1>예약하기</h1>
    </div>
    <hr>
      <div class="row section-left">
        <!-- main-left -->
        <div class="col">
	      <h2>날짜선택</h2>        
          <div id='calendar' style='margin: 0px 0px 1em; font-size: 13px'></div>
          <h2>인원</h2>
          <select class="form-control" style="margin: 0px 0px 1em">
          	<option>1</option>
          	<option>2</option>
          	<option>3</option>
          	<option>4</option>
          </select>
        </div>
        <!-- main-right -->
        <div class="col">
          <div class="d-flex justify-content-between">
            <h2>&nbsp;예약 정보</h2>
          </div>
          <div class="place-li">
          <a href="#" class="row">
            <div class="place-image col-4 align-self-center">
              <div class="place-image" style="background-color: black;"></div>
            </div>
            <div class="col-8">
              <span class="place-host">User11님의 숙소</span>
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
          <div class="content-box">
            <div class="place-info">
              <div class="content-title">날짜</div>
              <div class="content">21-03-17 ~ 21-03-19</div>
            </div>
            <div class="place-info">
              <div class="content-title">게스트</div>
              <div class="content">게스트 4명</div>
            </div>
            <div class="place-info">
              <div class="content-title">요금</div>
              <div class="content">￦89,000 × 2박 = ￦178,000</div>
            </div>            
            <div class="d-flex justify-content-center align-self-center">
              <button type="button" class="btn btn-warning btn-lg btn-block">결제하기</button>	
            </div>
          </div>        
        </div>
      </div>      
    </div>
</section>
<%@ include file="../include/footer.jsp" %>