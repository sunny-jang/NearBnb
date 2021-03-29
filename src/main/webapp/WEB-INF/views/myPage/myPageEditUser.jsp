<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<link href="${context}/html/css/park3.css" rel="stylesheet">
<%@ include file="../include/header.jsp" %>

<!--myPageHostCheck / 마이페이지_내 숙소 예약현황-->
<script>
	$(function(){
		var checkPw = true;
		var checkPwCheck = true;
		var checkPhone = true;
		var checkEmail = true;
		var checkAuthentication = true;
		// 기존 이메일
		var originalEmail = $('#userEmail').val();
		// 인증번호 저장용		
		var saveNum;
		
		// 비밀번호 유효성 검사
		$('#userPw').focusout(function(){
			var userPw = $('#userPw').val();
			var pwCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\,.<>\/?]).{8,20}$/);
			if(userPw != "") {
				if(pwCheck.test(userPw) == false) {
					$('#alertPw').html('<th></th><td style="padding: 0px 0px 0px 15px !important;">8~20자의 영문 대소문자와 숫자, 특수문자가 하나이상 포함되어야 합니다.</td>').css('color','red');
					checkPw = false;
				} else {
					$('#alertPw').html('');
					checkPw = true;
					checkPwCheck = false;
				}				
			} else {
				$('#alertPw').html('');
				$('#alertPwCheck').html('');
				checkPw = true;
				checkPwCheck = true;
			}
		});
		// 비밀번호 중복 검사
		$('#userPwCheck').focusout(function(){
			var userPw = $('#userPw').val();
			var userPwCheck = $('#userPwCheck').val();
			if(userPw != userPwCheck) {
				$('#alertPwCheck').html('<th></th><td style="padding: 0px 0px 0px 15px !important;">비밀번호를 다시 확인해주세요.</td>').css('color','red');
				checkPwCheck = false;
			} else {
				if(checkPw == true) {
					$('#alertPwCheck').html('<th></th><td style="padding: 0px 0px 0px 15px !important;">비밀번호가 일치합니다.</td>').css('color','green');
					checkPwCheck = true;					
				} else {
					$('#alertPwCheck').html('');
				}
			}
			if(userPw == '' && userPwCheck == '') {
				$('#alertPwCheck').html('');
				checkPw = true;
				checkPwCheck = true;
			}
		});
		// 전화번호 유효성 검사
		$('#userPhone').focusout(function(){
			var userPhone = $('#userPhone').val();
			var phoneCheck = RegExp(/^01[0179][0-9]{7,8}$/);
			if(phoneCheck.test(userPhone) == false) {
				$('#alertPhone').html('<th></th><td style="padding: 0px 0px 0px 15px !important;">다시 입력해주세요.</td>').css('color','red');
				checkPhone = false;
			} else {
				$('#alertPhone').html("");
				checkPhone = true;
			}
		});
		// 이메일 유효성 검사
		$('#userEmail').focusout(function(){
			var userEmail = $('#userEmail').val();
			var emailCheck = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
			if(originalEmail != userEmail) {
				if(emailCheck.test(userEmail) == false) {
					$('#alertEmail').html('<th></th><td style="padding: 0px 0px 0px 15px !important;">이메일 형식을 다시 확인해주세요.</td>').css('color','red');
					$('#authButton').attr('disabled', true);
					checkEmail = false;
				} else {
					$('#alertEmail').html("");
					$('#authButton').attr('disabled', false);
					checkEmail = true;
					checkAuthentication = false;
				}
			} else {
				$('#alertEmail').html("");
				$('#authButton').attr('disabled', true);
				checkEmail = true;
				checkAuthentication = true;
			}
		});
		// 인증메일 보내기
		$('#authButton').click(function(){
			var userEmail = $('#userEmail').val();
			$.ajax({
				url : 'authNum.do',
				type : 'POST',
				data : { authNum : userEmail },
				success : function(data) {
					alert('해당 이메일로 인증 메일이 발송되었습니다.');
					saveNum = data;
					console.log(saveNum);
				},
				error : function(request, status, error){}
			});
		});
		// 인증번호 검증
		$('#checkAuthNum').click(function(){
			var userEmail = $('#userEmail').val();
			var authNum = $('#authNum').val();
			if(originalEmail != userEmail) {
				if(authNum != saveNum) {
					$('#alertAuth').html('<th></th><td style="padding: 0px 0px 0px 15px !important;">인증번호가 일치하지 않습니다.</td>').css('color','red');
					checkAuthentication = false;
				} else {
					$('#alertAuth').html('<th></th><td style="padding: 0px 0px 0px 15px !important;">인증되었습니다.</td>').css('color','green');
					checkAuthentication = true;
				}				
			} 
		});
		// 각 항목 null 체크 및 중복, 인증했는지 확인
		$('form').submit(function(){					
			if(checkPw == false) {
				alert('새 비밀번호를 확인해주세요');
				return false;
			}
			if(checkPwCheck == false) {
				alert('비밀번호 확인을 해주세요.');
				return false;
			}
			if(checkPhone == false) {
				alert('전화번호를 입력해주세요.');
				return false;
			}
			if(checkEmail == false) {
				alert('이메일을 입력해주세요');
				return false;
			}
			if(checkAuthentication == false) {
				alert('인증번호를 확인해주세요.');
				return false;
			}			
		});
	});
</script>
<section>
 
    <div class="row flex-nowrap">
      <!--사이드바-->
      <%@ include file="../include/sidemenu.jsp" %>
      <!--사이드바 끝-->

      <!--메인-->
      <main class="col-8 py-md-5 pl-md-4 " >
        <div class="total m-0">
          <h1>회원수정</h1>
          <hr>
          <center>
              <form action="editUserAction.do" method="POST">
                  <table style="width: 600px;">
                      <tr>
                          <th>
                              아이디
                          </th>
                          <td>
                              <input type="text" style="width: 350px;" id="userId" name="userId" value="${m.userId }" class="p-2" readonly />
                          </td>                          
                      </tr>
                      <tr>
                          <th>
                              비밀번호 변경
                          </th>
                          <td>
                              <input type="password" style="width: 350px;" id="userPw" name="userPw" placeholder="새 비밀번호" class="p-2">
                          </td>
                      </tr>
                      <tr id="alertPw">
                    		
                      </tr>
                      <tr>
                          <th>
                              비밀번호 확인
                          </th>
                          <td>
                              <input type="password" style="width: 350px;" id="userPwCheck" placeholder="새 비밀번호 확인" class="p-2">
                          </td>
                      </tr>
                      <tr id="alertPwCheck">
                    		
                      </tr>
                      <tr>
                          <th>
                              전화번호
                          </th>
                          <td>
                              <input type="text" style="width: 350px;" id="userPhone" name="userPhone" value="${m.userPhone }" placeholder=" 01000000000" class="p-2">
                          </td>
                      </tr>
                      <tr>
                          <th>
                              이메일
                          </th>
                          <td>
                              <input type="email" style="width: 350px;" id="userEmail" name="userEmail" value="${m.userEmail }" placeholder=" 이메일@이메일주소.com" class="p-2">
                          </td>
                          <td>
                              <input type="button" class="btn1" id="authButton" value="이메일 인증" disabled="true">
                          </td>
                      </tr>
                      <tr id="alertEmail">
                    	
                      </tr>
                      <tr>
                          <th></th>
                          <td>
                              <input type="text" style="width: 350px;" id="authNum" placeholder=" 인증번호" class="p-2">
                          </td>
                          <td>
                              <input type="button" class="btn1" id="checkAuthNum" value="인증번호 확인">
                          </td>
                      </tr>
                      <tr id="alertAuth">
                    
                      </tr>                      
                      <tr>
                          <td></td>
                          <td align="center">
                              <input type="submit" value="회원 정보 수정" class="btn btn-third">
                          </td>
                          <td></td>
                      </tr>
                  </table>
              </form>
                  <hr>
                  <div>
                  	<div class="d-flex justify-content-end"><a href="withdrawal.do" onclick="return confirm('정말로 탈퇴하시겠습니까?')"><u>회원 탈퇴</u></a></div>
                  </div>                  
          </center>
      </div>
      </main>
      <!--메인-->
    </div>
</section>
<%@ include file="../include/footer.jsp" %>