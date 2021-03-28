<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
	$(function(){
		$('form').submit(function(){
			var idLength = $('#userId').val().length;
			var emailLength = $('#userEmail').val().length;
			if(idLength == 0) {
				alert('아이디를 입력해주세요.');
				return false;
			}
			if(emailLength == 0) {
				alert('이메일을 입력해주세요.');
				return false;
			}			
		});
	});
</script>
<form action="findPwAction.do" method="POST">
	<section>
	  <div class="row">
	    <div class="col d-flex flex-column align-items-center justify-content-center">
	      <h2 class="mb-5">비밀번호 찾기</h2>
	      <input type="text" id="userId" name="userId" placeholder="아이디" class=" p-2" style="width: 300px;"><br>
	      <input type="text" id="userEmail" name="userEmail" placeholder="가입시 입력한 이메일" class="p-2" style="width: 300px;">
	  
	      <div class="underline mt-4">
	        <a href="findId.do">아이디 찾기</a>
	      </div>
	  
	      <div class="btn-group-vertical mt-3">
	        <button type="submit" class="btn btn-third w-100">비밀번호 찾기</button>
	      </div>
	    </div>
	    
	  </div>
	</section>
</form>
<%@ include file="../include/footer.jsp" %>