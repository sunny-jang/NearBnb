<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
	$(function(){
		$('form').submit(function(){
			var userPw = $('#userPw').val();
			var pwLength = userPw.length;
			if(pwLength == 0) {
				alert('비밀번호를 입력해주세요.');
				return false;
			}			
		});
	});
</script>
<form action="myPagePwCheckAction.do" method="POST">
<section>
  <div class="row">
    <div class="col d-flex flex-column align-items-center justify-content-center">
      <h2 class="mb-5">비밀번호 재확인</h2>
      <span>안전한 사용을 위해 비밀번호를 다시 한 번 입력해주세요.</span><br>
  	  <input type="text" id="userId" name="userId" value="${userId}" class="p-2" style="width: 300px;" readonly /><br>
      <input type="password" id="userPw" name="userPw" placeholder="비밀번호" class="p-2" style="width: 300px;">
      <div class="btn-group-vertical mt-3">
        <button type="submit" id="checkPw" class="btn btn-third w-100">비밀번호 확인</button>
      </div>
    </div>
    
  </div>
</section>
</form>
<%@ include file="../include/footer.jsp" %>