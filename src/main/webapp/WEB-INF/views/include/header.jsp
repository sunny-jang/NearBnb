<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script type='text/javascript' src='${context}/html/js/fullcalendar.min.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="${context}/html/css/style.css" rel="stylesheet">
<link href="${context}/html/css/calender.css" rel="stylesheet">

</head>
<body>
<header>
  <div class="row">
    <div class="col-3">
      <h1 class="logo">
        <a href="index.do"><img src ="${context}/html/images/logo.png"></a>
      </h1>
    </div>
    <div class="col-9 justify-content-end align-self-center">
      <div class="row justify-content-end">
        <div class="col">
          <div class="d-flex justify-content-end right-menu">
              <button type="button" class="btn community" onclick="location.href='board.do'">커뮤니티</button>
              <!-- <button type="button" class="btn btn-primary">로그인</button> -->
              <button type="button" class="btn add_room">내 숙소 등록하기</button>
              <button type="button" class="btn btn-secondary">회원가입</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>