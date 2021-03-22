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
      <table>
        <tr>
            <td>제목</td>
            <td style="width: 800px; height: 50px;">
                <h2><input type="text" class="title" placeholder=" 제목"></h2>
            </td>
            <td style="width: 100px;">
              <input type="button" value="♥"  class="heart">
              <h2 style="display: inline;">12</h2>
            </td>
            <td style="border-left: 1px solid #ccc; padding: 10px;">
                <select style="border: none;">
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
            <td colspan="3" style="text-align: left;">
                <input type="file" style="margin-left: 5px;">
            </td>
        </tr>
        <tr>
            <td>
                글 내용
            </td>
            <td colspan="3">
                <textarea style="width: 100%;">
                </textarea>
            </td>
        </tr>
        <tr>
          <td>
            댓글 작성자
          </td>
          <td colspan="3" style="height: 45px;">
            댓글 내역
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <input type="text" class="commentWrt" placeholder="댓글 작성">
          </td>
          <td colspan="2">
            <input type="button" class="btn commentBtn" value="댓글달기">
          </td>
        </tr>
      </table>
      <div>
      <input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
      <input type="button" class="write1 btn" onclick="location.href='#'" value="삭제">
      <input type="button" class="write2 btn" onclick="location.href='boardRewrite.do'" value="수정">
      </div>
  </form>
</center>
</div>

</section>
<%@ include file="../include/footer.jsp" %>