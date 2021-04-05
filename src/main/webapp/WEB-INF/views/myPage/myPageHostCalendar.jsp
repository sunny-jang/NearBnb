<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<link href="${context}/html/css/park3.css" rel="stylesheet">
<link href='${context}/html/css/calendar.css' rel='stylesheet' />
<script src='${context}/html/js/fullcalendar.js'></script>
<script src='${context}/html/js/interaction.js'></script>
<script src='${context}/html/js/daygrid.js'></script>
<script src='${context}/html/js/timegrid.js'></script>
<script src='${context}/html/js/ko.js'></script>
<script src="${context}/resources/html/js/dateController.js"></script>
<!--myPageHostCalendar-->
<style>
.book-list {
	padding: 0;
	margin: 0;
}
.book-list li {
	list-style:none;
	padding: 15px;
	border: 1px solid #eee;
	margin-bottom: 15px;
	font-size: 14px;
	background-color: #eee;
}
</style>
<script>
  document.addEventListener('DOMContentLoaded', function() {
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}
	
	var oDate = $("#openDate").val().substring(0,10);
	var cDate = $("#closeDate").val().substring(0,10);
	var calendarEl = document.getElementById('calendar');
	
	// 예약가능날짜 셋업
	async function getFullEvents() {
		var events_ = await getEventList();
		events_.unshift(
			{
		          title: '예약 가능 날짜',
		          start: oDate,
		          end: cDate,
		        }
		)
		return events_
	}
	
	async function getEventList() {
		var a = await fetch('bookList.do?pId=${place.placeId}').then(res=>res.json());
		var result = a.map((item,i)=> {
			return {
				id: 'index-'+i,
				title: '예약된 날짜',
				start: item.start.substring(0,10),
				end: item.end.substring(0,10),
				color: 'red',
			}
		})
		
		return result;
	}
	
	async function getEventEle() {
		var bList = await fetch('bookList.do?pId=${place.placeId}').then(res=>res.json());
		let temp = '<ul class="book-list">';
		bList.map(item=>{
			temp+= '<li>예약자명 : '+item.userId+'<br />'
			+ '총 결제금액 : '+item.bookPayPrice+'<br />'
			+ '총 예약 인원 : '+item.bookPerson+'<br />'
			+ '체크인 날짜 : '+item.start.substring(0,10)+'<br />'
			+ '체크아웃 날짜 : '+item.end.substring(0,10)+'<br />'
			+ '</li>';
		})
		temp+='</ul>'
		
		return temp;
	}
	
	(async function() {
		// 캘린더 객채 생성
		// var date = new PlaceDate();
		var events = await getFullEvents();
		var calendar = new FullCalendar.Calendar(calendarEl, {
		      locale:'ko',
		      plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
		      header : {
		          left : 'prev',
		          center : 'title',
		          right : 'next',
		        },
		      selectable: true,
		      select: function(arg) {
		    	var event_ = calendar.getEventById('newbook');
		    	
		    	// 이미 이벤트가 만들어져있으면 삭제
		    	if(event_) {
		    		event_.remove();
		    	}
		    	
		    	// 이벤트 셋업
		    	event_ = {
				    id: 'newbook',
			        title: "예약 날짜",
			        start: arg.start,
			        end: arg.end,
			        allDay: arg.allDay,
			        color: 'orange'
			      };
		      },
		      eventLimit: true, // allow "more" link when too many events
		      events: events,
		      local:'ko',
		      display: 'background'
		    });
		
		init();
    	
		// 화면 처음 불러와질때 값 셋팅
    	function init() {			
	    	calendar.render();
    	}  	
    	
    	// 예약된 날짜들 배열로 생성
    	function getBookedDates (events) {
			let eventArray = [];
	    	for(let i = 1;i<events.length;i++) {
	    		const es = new Date(events[i].start);
	    		const ee = new Date(events[i].end);
	    		const diffDate = date.getDateDiff(es, ee);
	    		
	    		for(let j=0;j<diffDate;j++) {
	    			const es = new Date(events[i].start);
	    			eventArray.push(new Date(es.setDate(es.getDate()+j)));
	    		};
	    	}
	    	return eventArray;
		}
    	
    	$("#bookInfo").append(await getEventEle());
    	
    	console.log(await getEventEle());
    	
	})();
});
  
function deletePlace(pId) {
	var confirmDelete = confirm("정말 삭제하시겠습니까?");
	
	if(confirmDelete) {
		fetch("deletePlace.do?pId="+pId, {
			method: 'get',
		}).then(res=>res.json()).then((res)=>{
			if(res.result == "failed") {
				alert("예약이 잡힌 숙소는 취소할 수 없습니다.")
			}else {
				location.href="myPageHostCheck.do";
			}
		})
	}else {
		return;
	}
	
}
</script>
<section class="pb-5">
 
  <div class="row flex-nowrap">
    <%@ include file="../include/sidemenu.jsp" %>
    <!--메인-->
    <main class="col-8 py-md-5 pl-md-4 " >
      <h1>내 숙소 예약 현황</h1>
      <hr>
      
      <h4 class="col-8 place-name ellipsis1">${place.placeName }</h4>
      <a class="btn btn-third mb-2 ml-2" style="font-size:14px" href="placeDetail.do?pId=${place.placeId}">내 숙소 상세페이지 바로가기</a>
      <!--달력 부분 -->
      <br>
      <input type="hidden" id="openDate" name="placeOpenDate" value="${place.placeOpenDate }" />
      <input type="hidden" id="closeDate" name="placeCloseDate" value="${place.placeCloseDate }" />
     <div class="row justify-content-center">
      <div class="col-8 " id="bookInfo">   
      	<div id='calendar' style='margin-bottom: 20px; font-size: 13px;'></div>
      </div>
     <div class="col-8 justify-content-between d-flex">
     	<button type="button" class="btn btn-secondary" onclick="deletePlace(${place.placeId});" >삭제하기</button>
     	<button type="button" class="btn btn-primary" onclick="history.back();" >목록보기</button>
     </div>
  	 </div>
  
    
    </main>
    <!--메인-->
  </div>
</section>
<%@ include file="../include/footer.jsp" %>