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
<link href="${context }/html/css/park2.css" rel="stylesheet">
</head>
<body>
<header>
<%@ include file="../include/header.jsp" %>
</header>
<section style="height: 100vh;">
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <center>
    <form class="center">
      <table>
        <tr>
            <td style="width: 100px;">제목</td>
            <td style="width: 900px; height: 50px;">
                <h2><input type="text" class="title" placeholder=" 제목"></h2>
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
            <td colspan="2" style="text-align: left;">
                <input type="file" style="margin-left: 5px;">
            </td>
        </tr>
        <tr>
            <td>
                글 내용
            </td>
            <td colspan="2">
                <textarea style="width: 100%;">
                </textarea>
            </td>
        </tr>
      </table>
      <input type="button" class="btn toList" onclick="location.href='board.html'" value="목록">
      <input type="reset" class="btn reset">
      <input type="submit" class="write3 btn" onclick="location.href='boardWrite.html'" value="글쓰기">
  </form>
</center>
</div>

</section>
<footer>
<%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>