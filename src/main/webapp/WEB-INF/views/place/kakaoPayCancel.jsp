<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section>
  <div class="row">
    <div class="col d-flex flex-column align-items-center justify-content-center">
      <h2 class="mb-5">결제 취소</h2>
      <div class="mb-5">
        <i class="fas fa-ban" style="font-size: 70px;"></i>
      </div>
      <p>결제가 취소되었습니다. 다시 시도 해주세요.</p>
      
      <div class="btn-group-vertical mt-3 w-25">
        <button type="button" class="btn btn-third w-100" onclick="location.href='index.do'">메인으로</button>
      </div>
    </div>
    
  </div>
</section>
<%@ include file="../include/footer.jsp" %>