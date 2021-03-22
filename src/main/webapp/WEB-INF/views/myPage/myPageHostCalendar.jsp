<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/header.jsp" %>
<head>
<!--myPageHostCalendar-->
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
</head>
<section>
 
  <div class="row flex-nowrap">
    <!--사이드바-->
    <div class="col-3 py-md-5 ">
      <div class="sidebar_menu">
       <h2>마이페이지</h2>
       <a href="#"><h5>- 내 예약 조회</h5></a>
       <a href="#"><h5>- 내 숙소 예약 현황</h5></a>
        <a href="#"><h5>- 회원수정 / 탈퇴</h5></a>
      </div>
     
    </div>
    <!--사이드바 끝-->
    <!--메인-->
    <main class="col-8 py-md-5 pl-md-4 " >
      <h1>내 숙소 예약 현황</h1>
      <hr>
      
      <h5 class="col-8 place-name ellipsis1">숙소이름이에용</h5>
      <!--달력 부분 -->
     <div class="row">
      <div class="col-8">   
      <div id='calendar' style='margin-bottom: 20px; font-size: 13px'></div>
      <div style="text-align: end;"><button type="button" class="btn btn-primary" onclick="location.href='myPageHostCheck.html'" >목록보기</button></div>
       </div>
    </div>
  
    
    </main>
    <!--메인-->
  </div>
</section>
<%@ include file="../include/footer.jsp" %>