<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}/resources" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<link href="${context }/html/css/style.css" rel="stylesheet">
<link href="${context }/html/css/park1.css" rel="stylesheet">
</head>
<body>
<header>
<%@ include file="../include/header.jsp" %>
</header>
<section>
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <select class="boartType1">
    <option value="1">게시글 전체</option>
    <option value="2">추천</option>
    <option value="3">주변시설</option>
    <option value="3">문의</option>
  </select>
  <form class="search">
    <select id="boardSearch">
      <option value="1">전체</option>
      <option value="2">제목</option>
      <option value="3">작성자</option>
    </select>
    <input type="text" style="margin-left: 10px; height: 20px;">
    <input type="submit" class="btn" value="검색">
  </form>
  <table class="comT">
    <tr class="type">
      <td class="boardType2">게시글 종류</td>
      <td class="boardTitle">게시글 제목</td>
      <td class="boardHeart">♥</td>
      <td class="boardWriter">작성자</td>
      <td class="boardDate">작성일</td>
    </tr>
    <tr></tr>
    <tr class="List">
      <td>종류1</td>
      <td><a href="boardRead.html">제목1</a></td>
      <td>12</td>
      <td>홍길동</td>
      <td>2021-03-18</td>
    </tr>
    <tr>
      <td>종류2</td>
      <td><a href="#">제목2</a></td>
      <td>9</td>
      <td>고길동</td>
      <td>2021-03-18</td>
    </tr>
  </table>
</div>
<input type="button" class="write btn" onclick="location.href='boardWrite.do'" value="글쓰기" >
</section>
<footer>
<%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>