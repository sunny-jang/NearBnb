<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">
<section>
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <center style="font-size: 23px;">
    <form class="center" action="boardWriteCon.do" method="post">
      <table>
        <tr>
            <td style="width: 300px;">제목</td>
            <td style="width: 900px; height: 50px;">
                <h2><input type="text" class="title" style="margin-top: 17px;" placeholder=" 제목" name="boardTitle"></h2>
            </td>
            <td style="border-left: 1px solid #ccc; padding: 10px;">
                <select style="border: none;" name="boardType">
                    <option value="1">종류</option>
                    <option value="2">추천</option>
                    <option value="3">주변시설</option>
                    <option value="4">문의</option>
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
                <textarea style="width: 100%;" name="boardContent">
                </textarea>
            </td>
        </tr>
      </table>
      <input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
      <input type="reset" class="btn reset">
      <input type="submit" class="write3 btn" onclick="location.href='boardWrite.html'" value="글쓰기">
  </form>
</center>
</div>
</section>
<%@ include file="../include/footer.jsp" %>