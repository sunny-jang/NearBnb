<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section>
  <div class="row">
    <div class="col d-flex flex-column align-items-center justify-content-center">
      <h2 class="mb-5">로그인</h2>
      <input type="text" name="" placeholder="로그인" class=" p-2" style="width: 300px;"><br>
      <input type="text" name="" placeholder="비밀번호" class="p-2" style="width: 300px;">
  
      <div class="mt-4">비밀번호를 잊으셨나요?</div>
      <div class="underline">
        <a href="#">아이디</a> / 
        <a href="#">비밀번호 찾기</a>
      </div>
  
      <div class="btn-group-vertical mt-3">
        <button type="button" class="btn btn-third w-100">로그인</button><br>
        <button type="button" class="btn btn-secondary w-100">회원가입</button>
      </div>
    </div>
    
  </div>
</section>
<%@ include file="../include/footer.jsp" %>