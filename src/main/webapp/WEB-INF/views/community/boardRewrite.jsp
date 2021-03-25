<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">
<section style="height: 100vh;">
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <center>
    <form class="center">
      <table style="font-size: 20px;">
        <tr>
            <td style="width: 100px;">제목</td>
            <td style="width: 900px; height: 50px;">
                <h2><input type="text" class="title" style="margin-top: 17px;" placeholder=" 제목" value="${board.boardTitle }"></h2>
            </td>
            <td style="border-left: 1px solid #ccc; padding: 10px;">
                <select style="border: none;">
                    <c:choose>
						<c:when test="${board.boardType eq '종류' }">
							<option value="종류" selected>종류</option>
							<option value="추천">추천</option>
                    		<option value="주변시설">주변시설</option>
                    		<option value="문의">문의</option>
						</c:when>
						<c:when test="${board.boardType eq '추천' }">
							<option value="종류">종류</option>
							<option value="추천" selected>추천</option>
                    		<option value="주변시설">주변시설</option>
                    		<option value="문의">문의</option>
						</c:when>
						<c:when test="${board.boardType eq '주변시설' }">
							<option value="종류">종류</option>
							<option value="추천">추천</option>
                    		<option value="주변시설" selected>주변시설</option>
                    		<option value="문의">문의</option>
						</c:when>
						<c:otherwise>
							<option value="종류">종류</option>
							<option value="추천">추천</option>
                    		<option value="주변시설">주변시설</option>
                    		<option value="문의" selected>문의</option>
						</c:otherwise>
					</c:choose>
                </select>
            </td>
        </tr>
        <tr>
            <td style="width: 80px;">
                첨부파일
            </td>
            <td colspan="2" style="text-align: left;">
                <input type="file" style="margin-left: 5px;">
            </td>
        </tr>
        <tr>
            <td>
                글 내용
            </td>
            <td colspan="2">
                <textarea style="width: 100%;">${board.boardContent }</textarea>
            </td>
        </tr>
      </table>
      <input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
      <input type="reset" class="btn reset">
      <input type="submit" class="write3 btn" onclick="location.href='boardWrite.do'" value="수정하기">
  </form>
</center>
</div>
</section>
<%@ include file="../include/footer.jsp" %>