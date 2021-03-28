<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section>
  <div class="row">
    <div class="col d-flex flex-column align-items-center justify-content-center">
      <h2 class="mb-5">비밀번호 변경</h2>
      <div class="mb-5">
        <i class="fa fa-check-circle-o" style="font-size: 70px;"></i>
      </div>
      <p>새 비밀번호로 변경이 완료되었습니다!</p>
      
      <div class="btn-group-vertical mt-3 w-25">
        <button type="button" class="btn btn-third w-100" onclick="location.href='signIn.do'">로그인</button>
      </div>
    </div>
    
  </div>
</section>
<%@ include file="../include/footer.jsp" %>