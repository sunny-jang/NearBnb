<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
	$(function(){
		// 비밀번호 유효성 검사
		$('#newPw').focusout(function(){
			var newPw = $('#newPw').val();
			var pwCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\,.<>\/?]).{8,20}$/);
			if(pwCheck.test(newPw) == false) {
				$('#alertPw').text('8~20자의 영문 대소문자와 숫자, 특수문자가 하나이상 포함되어야 합니다.').css('color','red');
				
			} else {
				$('#alertPw').text('');
				
			}
		});
		// 비밀번호 중복 검사
		$('#newPwCheck').focusout(function(){
			var newPw = $('#newPw').val();
			var newPwCheck = $('#newPwCheck').val();
			if(newPw.length != 0 && newPwCheck.length != 0) {
				if(newPw != newPwCheck) {
					$('#alertPwCheck').text('비밀번호를 다시 확인해주세요.').css('color','red');				
				} else {
					$('#alertPwCheck').text('비밀번호가 일치합니다.').css('color','green');
					
				}				
			}
		});
		$('form').submit(function(){
			var newPw = $('#newPw').val();
			var newPwCheck = $('#newPwCheck').val();
			if(newPw.length == 0) {
				alert('새 비밀번호를 입력해주세요.');
				return false;
			}
			if(newPwCheck.length == 0) {
				alert('비밀번호 확인을 해주세요.');
				return false;
			}			
		});
	});
</script>
<form action="changePwAction.do" method="POST">
	<section>
	  <div class="row">
	    <div class="col d-flex flex-column align-items-center justify-content-center">
	      <h2 class="mb-5">비밀번호 변경</h2>
	      <input type="hidden" id="userId" name="userId" value="${memberId }" />
	      <input type="password" id="newPw" name="userPw" placeholder="새 비밀번호" class=" p-2" style="width: 300px;">
	      <p class="mt-1 mb-0" id="alertPw"></p>
	      <br>
	      <input type="password" id="newPwCheck" placeholder="새 비밀번호 확인" class="p-2" style="width: 300px;">
	  	  <p class="mt-1 mb-0" id="alertPwCheck"></p>
	  	  
	      <div class="btn-group-vertical mt-3">
	        <button type="submit" class="btn btn-third w-100">비밀번호 변경</button>
	      </div>
	    </div>
	    
	  </div>
	</section>
</form>
<%@ include file="../include/footer.jsp" %>