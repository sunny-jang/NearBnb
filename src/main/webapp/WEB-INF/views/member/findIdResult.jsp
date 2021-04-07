<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section>
  <div class="row">
    <div class="col d-flex flex-column align-items-center justify-content-center">
      <h2 class="mb-5">아이디 찾기</h2>
      <c:if test="${not empty foundId}">
	      <p>조회하신 아이디는 <span class="id-result">${foundId}</span>입니다.</p>
      </c:if>
      <c:if test="${empty foundId }">
	      <p>아이디 조회 결과가 없습니다.</p>
      </c:if>
  
      <div class="underline mt-4">
        <a href="findPassword.do">비밀번호 찾기</a>
      </div>
  
      <div class="btn-group-vertical mt-3">
        <button type="button" class="btn btn-third w-100" onclick="location.href='signIn.do'">로그인</button>
      </div>
    </div>
    
  </div>
</section>
<%@ include file="../include/footer.jsp" %>