<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<jsp:useBean id="today" class="java.util.Date" />
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
		    <c:if test="${boardListCount eq 0 }">
		    	<tr>
					<td colspan="5">
						<br>게시글이 없습니다<br>
					</td>
				</tr>
			</c:if>
		 	<c:if test="${boardListCount ne 0 }">
		 		<c:forEach var="board" items="${boardList }">
					<tr class="List">
						<td>${board.boardType }</td>
						<td><a href="boadSelectOneCon.do?boardCodeSeq=${board.boardCodeSeq }">${board.boardTitle }</a></td>
						<%-- <td>${boardThumb.boardThumb }</td> --%>
						<td>${board.userId }</td>
						<td><fmt:formatDate value="${board.boardDate }" type="DATE" dateStyle="MEDIUM"/></td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 앞 페이지 번호 처리 -->
			<tr height="20">
				<td colspan="5" style="margin: 10px;">
					<c:if test="${currentPage <= 1}">
					</c:if>
		  			<c:if test="${currentPage > 1}">
						<c:url var="boardList" value="board.do">
							<c:param name="page" value="${currentPage-1}" />
						</c:url>
						<a href="${boardList}">[이전]</a>
					</c:if>
					<!-- 끝 페이지 번호 처리 -->
					<c:set var="maxPage" value="${maxPage}" />
					<c:forEach var="endPage" begin="${startPage+1}" end="${maxPage}">
						<c:if test="${endPage eq currentPage}">
							<font color="red" size="4"><b>[${endPage}]</b></font>
						</c:if>
						<c:if test="${endPage ne currentPage}">
							<c:url var="boardListCheck" value="board.do">
								<c:param name="page" value="${endPage}" />
							</c:url>
							<a href="${boardListCheck}">${endPage}</a>
						</c:if>
					</c:forEach>
					<c:if test="${currentPage >= maxPage}">
						[다음]
					</c:if>
					<c:if test="${currentPage < maxPage}">
						<c:url var="boardListEND" value="board.do">
							<c:param name="page" value="${currentPage+1}" />
						</c:url>
						<a href="${boardListEND}">[다음]</a>
					</c:if>
				</td>
			</tr>
		</table>
	</center>
</div>
<input type="button" class="btn write" style="background-color:#FFBF00; height: 34px;" onclick="location.href='boardWrite.do'" value="글쓰기" >
</section>
<%@ include file="../include/footer.jsp" %>