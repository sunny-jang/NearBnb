<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
$(function(){
	var object = JSON.parse(localStorage.bookInfo);
	console.log(object);
	$.ajax({
		url : 'registerBook.do',
		data : {'book' : object},
		dataType : 'json',
		success : function(data){
			alert(data);
		}, error : function(error) {
			alert(error);
		}		
	});
});
</script>
<section>
  <div class="row">
    <div class="col d-flex flex-column align-items-center justify-content-center">
      <h2 class="mb-5">결제 성공</h2>
      <div class="mb-5">
        <i class="fa fa-check-circle-o" style="font-size: 70px;"></i>
      </div>
      <p>결제가 완료되었습니다.</p>
      
      <div class="btn-group-vertical mt-3 w-25">
        <button type="button" class="btn btn-third w-100" onclick="location.href='index.do'">메인으로</button>
      </div>
    </div>
    
  </div>
</section>
<%@ include file="../include/footer.jsp" %>