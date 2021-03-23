<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park1.css" rel="stylesheet">
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
    <input type="submit" class="btn" style="font-size: 17px;" value="검색">
  </form>
  <center>
  <table class="comT" style="font-size: 20px;">
    <tr class="type">
      <td class="boardType2" style="width: 250px;">게시글 종류</td>
      <td class="boardTitle">게시글 제목</td>
      <td class="boardHeart">♥</td>
      <td class="boardWriter">작성자</td>
      <td class="boardDate">작성일</td>
    </tr>
    <tr></tr>
    <tr class="List">
      <td>종류1</td>
      <td><a href="boardRead.do">제목1</a></td>
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
  </center>
</div>
<input type="button" class="btn write" style="background-color:#FFBF00; height: 34px;" onclick="location.href='boardWrite.do'" value="글쓰기" >
</section>
<%@ include file="../include/footer.jsp" %>