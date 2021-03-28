<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
	$(function(){
		var authKey = "<c:out value='${authKey}' />";
		$('form').submit(function(){
			var authNum = $('#authNum').val();
			var authLength = authNum.length;
			if(authLength == 0) {
				alert('인증번호를 입력해주세요.');
				return false;
			}
			if(authKey != authNum) {
				alert('인증번호가 일치하지 않습니다.');
				return false;
			}
		});
	});
</script>
<form action="changePassword.do" method="POST">
<section>
  <div class="row">
    <div class="col d-flex flex-column align-items-center justify-content-center">
      <h2 class="mb-5">인증번호 전송 완료</h2>
      <span>입력하신 이메일에서 인증번호를 확인하고 입력해주세요.</span><br>
      <input type="text" id="authNum" name="authNum" placeholder="인증번호" class="p-2" style="width: 300px;">
  	  <input type="hidden" id="userId" name="userId" value="${userId }" />
      <div class="btn-group-vertical mt-3">
        <button type="submit" id="checkAuthNum" class="btn btn-third w-100">인증번호 확인</button>
      </div>
    </div>
    
  </div>
</section>
</form>
<%@ include file="../include/footer.jsp" %>