<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<link href='${context}/resources/html/css/calendar.css' rel='stylesheet' />
<script src='${context}/resources/html/js/fullcalendar.js'></script>
<script src='${context}/resources/html/js/interaction.js'></script>
<script src='${context}/resources/html/js/daygrid.js'></script>
<script src='${context}/resources/html/js/timegrid.js'></script>
<script src='${context}/resources/html/js/ko.js'></script>
 <script src="${context}/resources/html/js/dateController.js"></script>

<script>
  document.addEventListener('DOMContentLoaded', function() {
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}
	  
	var oDate = $("#openDate").text().substring(0,10);
	var cDate = $("#closeDate").text().substring(0,10);
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      locale:'ko',
      plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
      header : {
          left : 'prev',
          center : 'title',
          right : 'next'
        },
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg) {
    	var date = new PlaceDate();
    	var event_ = calendar.getEventById('book');
    	
    	// 이미 이벤트가 만들어져있으면 삭제
    	if(event_) {
    		event_.remove();
    	}
    	
    	// 예약기간 구함
    	var dateDiff = date.getDateDiff(arg.start, arg.end);
    	
    	//날짜 데이터를 스트링으로 변환
    	argS = date.getDateFormat(arg.start);
    	argE = date.getDateFormat(arg.end);
    	
    	// 이벤트 셋업
    	event_ = {
		    id: 'book',
	        title: "예약 날짜",
	        start: arg.start,
	        end: arg.end,
	        allDay: arg.allDay,
	        color: 'orange'
	      };
    	
    	// 예약 가능날짜 사이에 있는지 여부
    	if(oDate <= argS && cDate >= argE) {
    		alert('예약날짜는 '+ argS +' ~ ' + argE +'입니다.\n체크아웃은 12pm 입니다.');
    		calendar.addEvent(event_);
   	        calendar.unselect();
   	     	var price = $("#placePrice").text();
   	     	var value = '<c:out value="${place.placePrice}" />';   	     	
   	     	
   	         $("#checkIn").html(argS);
   	       	 $("#checkOut").html(argE);
   	       	 $("#dateDiff").html(dateDiff);
	   	     $("#totalPrice").html(numberWithCommas(value * dateDiff));
    	}else {
    		alert("예약 가능 날짜 안에서 선택해주세요.")
    	}
   		
      },
      eventLimit: true, // allow "more" link when too many events
      events: [
        {
          title: '예약 가능 날짜',
          start: oDate,
          end: cDate
        },
      ],
      local:'ko',
      eventDurationEditable: true
    });
    
    function init() {
    	$("#checkIn").text(oDate);
    	$("#checkOut").text(oDate);
    	calendar.render();
    }
    
    init();
    
    $("#selectGuest").on("change", function() {
    	$("#selectedGuest").text($(this).val())
    })
    
    $("#postBookInfo").on("click", function() {
	    var f = document.createElement("form");
	    var object = {
			  uId : $("input[name=uId]").val(),
			  pId : $("input[name=pId]").val(),
			  bookCheckIn : $("#checkIn").text(),
			  bookCheckOut : $("#checkOut").text(),
			  bookPerson : $("#selectGuest").val(),
			  bookPayPrice : $("#totalPrice").text(),
			  dateDiff : $("#dateDiff").text(),
	    	  totalPrice : $("#totalPrice").text(),
	    	  imagePath : $("#placeImage").css("background-image"),
	  }
	    
	  localStorage.bookInfo = JSON.stringify(object);
	    
	  if(calendar.getEventById('book')) {
		  document.body.appendChild(f);
		  location.href="placePayment.do?pId="+object.pId;
	  }else {
		  alert('날짜를 선택해주세요.');
	  }
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
          <select class="form-control" style="margin: 0px 0px 1em" id="selectGuest">
          	<c:forEach var="i" begin="1" end="${place.maxGuest}">
          		<option value="${i}">${i}</option>
          	</c:forEach>
          </select>
        </div>
        <!-- main-right -->
        <div class="col">
          <div class="d-flex justify-content-between">
            <h2>&nbsp;예약 정보</h2>
          </div>
          <div class="place-li">
          <div class="row">
            <div class="place-image col-4 align-self-center" id="placeImage" style="background-image: url(/nearbnb/resources/html/images/${sImage})">
            <input type="hidden" name="uId" value="${userId}">
            <input type="hidden" name="pId" value="${place.placeId }">
            </div>
            <div class="col-8">
              <span class="place-host">${place.uId} 님의 숙소</span>
              <h5 class="place-name ellipsis2">${place.placeName}</h5>
              <span class="place-option">최대인원 ${place.maxGuest}명 . 숙소 유형 ${place.placeType}</span>
              <p class="place-des ellipsis2">${place.placeDesc}</p>
              <div class="d-flex justify-content-between">
                <div>${place.placeThumb} <i class="fa fa-heart"></i></div>
                <div><span id="placePrice"><fmt:formatNumber value="${place.placePrice}" /></span> 원 / 박</div>
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
              <div class="content">
              	<span id="checkIn">${place.placeOpenDate}</span> ~ <span id="checkOut">${place.placeOpenDate}</span></div>
            </div>
            <div class="place-info">
              <div class="content-title">게스트</div>
              <div class="content">게스트 <span id="selectedGuest">1</span>명</div>
            </div>
            <div class="place-info">
              <div class="content-title">요금</div>
              <div class="content">￦ <fmt:formatNumber value="${place.placePrice}" /> × <span id="dateDiff">1</span>박 = ￦&nbsp;<span id="totalPrice"></span></div>
            </div>            
            <div class="d-flex justify-content-center align-self-center">
              <button type="button" class="btn btn-warning btn-lg btn-block" id="postBookInfo">결제하기</button>	
            </div>
          </div>        
        </div>
      </div>      
    </div>
</section>
<%@ include file="../include/footer.jsp" %>