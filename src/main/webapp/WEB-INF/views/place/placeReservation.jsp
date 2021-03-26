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
      var oDate = $("#openDate").text().substr(0,10);
      var cDate = $("#closeDate").text().substr(0,10);
      
      console.log(oDate);
      
  
      $('#calendar').fullCalendar({
        header : {
          left : 'prev',
          center : 'title',
          right : 'next'
        },
        editable : true,
        eventDurationEditable : true,
        eventAllow: function(allDay, draggedEvent) {
        	alert("test");
        },
        events: [
          {
            title:"가능날짜",
            start: oDate,
            end: cDate,
          },
          
          {
              title:"선택날짜",
              start: '2021-03-29',
              end: '2021-03-30',
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
          <div class="row">
            <div class="place-image col-4 align-self-center">
              <div class="place-image"></div>
            </div>
            <div class="col-8">
              <span class="place-host">${place.uId} 님의 숙소</span>
              <h5 class="place-name ellipsis2">${place.placeName}</h5>
              <span class="place-option">최대인원 ${place.maxGuest}명 . 숙소 유형 ${place.placeType}</span>
              <p class="place-des ellipsis2">${place.placeDesc}</p>
              <div class="d-flex justify-content-between">
                <div>${place.placeThumb} <i class="fa fa-heart"></i></div>
                <div>${place.placePrice} 원 / 박</div>
              </div>
            </div>
          </div>          
          </div>
          <div class="content-box">
            <div class="place-info">
              <div class="content-title">날짜</div>
              <div class="content" style="height:0px; font-size:0px">
             	 <span id="openDate">${place.placeOpenDate}</span>
              	 <span id="closeDate">${place.placeCloseDate}</span>
              </div>
              <div class="content">${place.placeOpenDate}dd ~ ${place.placeOpenDate}</div>
            </div>
            <div class="place-info">
              <div class="content-title">게스트</div>
              <div class="content">게스트 <span id="selectedGuest">4</span>명</div>
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