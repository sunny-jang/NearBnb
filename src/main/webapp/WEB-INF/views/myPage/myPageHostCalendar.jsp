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
<!--myPageHostCalendar-->
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      locale:'ko',
      plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
      header : {
          left : 'prev',
          center : 'title',
          right : 'next'
        },
      defaultDate: '2020-02-12',
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,      
      editable: false,
      eventLimit: true, // allow "more" link when too many events
      events: [
        {
          title: '예약 가능 날짜',
          start: '2020-02-07',
          end: '2020-02-10'
        },
      ],
      local:'ko'
    });

    calendar.render();
  });

</script>
<section>
 
  <div class="row flex-nowrap">
    <%@ include file="../include/sidemenu.jsp" %>
    <!--메인-->
    <main class="col-8 py-md-5 pl-md-4 " >
      <h1>내 숙소 예약 현황</h1>
      <hr>
      
      <h4 class="col-8 place-name ellipsis1">숙소이름이에용</h4>
      <!--달력 부분 -->
     <div class="row justify-content-center">
      <div class="col-10">   
      	<div id='calendar' style='margin-bottom: 20px; font-size: 13px;'></div>
      </div>
  	 </div>
     <div style="text-align: end;"><button type="button" class="btn btn-primary" onclick="location.href='myPageHostCheck.html'" >목록보기</button></div>
  
    
    </main>
    <!--메인-->
  </div>
</section>
<%@ include file="../include/footer.jsp" %>