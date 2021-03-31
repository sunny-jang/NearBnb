<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
#kakaoPay {
	width: 100px;
	height: 100px;
}
</style>
<script>
$(function(){
	$('#kakaoPay').click(function(){
		$.ajax({
			url : 'kakaoPay.do',
			dataType: 'json',
			success : function(data) {
				var msg = data.next_redirect_pc_url;
				window.open(msg);
			}, error : function(error) {
				alert(error);
			}
			
		});
	});	
});
</script>
<section>
	<div class="bg-warning" id="kakaoPay"></div>
</section>
<%@ include file="../include/footer.jsp" %>