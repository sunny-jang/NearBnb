<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">
<script>
	$(function(){
		$('#deleteB').on('submit', function(){
			var beforePw = $('#beforePw').val();
			var nowPw = $('#userPw').val();
			if(nowPw == ""){
				alert('비밀번호를 입력하세요.');
			}
			if(beforePw != nowPw){
				alert('비밀번호가 일치하지 않습니다!');
			}
		});
	});
</script>
<section style="height: 100vh;">
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <center>
    <form id="deleteB" action="boardDeleteCon.do" method="post">
      <table style="font-size: 20px; text-align: center; border: none;">
      	<tr>
      		<th>
      			게시글 삭제를 위해 비밀번호를 입력하세요.
      		</th>
      	</tr>
        <tr>
            <td style="width: 900px; height: 30px; border: none;">
                <h2><input type="password" style="margin-top: 8px; height: 30px;" id="userPw" name="userPw"></h2>
            </td>
        </tr>
      </table>
      <input type="password" id="beforePw" value="${board.userPw }" style="display: none;">
      <input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
      <input type="reset" class="btn reset">
      <input type="submit" class="write3 btn" onclick="return confirm('게시글을 삭제하시겠습니까?')" value="삭제하기">
  </form>
</center>
</div>
</section>
<%@ include file="../include/footer.jsp" %>