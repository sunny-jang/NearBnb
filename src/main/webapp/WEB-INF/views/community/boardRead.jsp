<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">
<!-- <script>
	$(function(){
		$('#thumb').on('click', function(){
			$.ajax({
				url : '/NearBnb/thumb.do',
				date : {
					var thumbs : ${boardThumb.boardThumb }
				},
				dataType : 'json',
				success: function(data){
					
				}
			});
		});
	});
</script> -->
<section style="height: 100vh;">
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <center>
    <form class="center" action="boardUpdateCon.do" method="post">
      <table style="font-size: 20px;">
        <tr>
            <td>제목</td>
            <td style="width: 800px; height: 50px;">
                <div class="title" style="margin-top: 30px; text-align: left;"><h2>${board.boardTitle }</h2></div>
            </td>
            <td style="width: 100px;">
              <input type="button" value="♥" class="heart" id="thumb">
              <h2 style="display: inline;">${boardThumb.boardThumb }</h2>
            </td>
            <td style="border-left: 1px solid #ccc; padding: 10px;">
                <div style="width: 100px;">
                	<c:choose>
						<c:when test="${board.boardType eq '종류' }">
							종류
						</c:when>
						<c:when test="${board.boardType eq '추천' }">
							추천
						</c:when>
						<c:when test="${board.boardType eq '주변시설' }">
							주변시설
						</c:when>
						<c:otherwise>
							문의
						</c:otherwise>
					</c:choose>
                </div>
            </td>
        </tr>
        <tr>
            <td style="width: 80px;">
                첨부파일
            </td>
            <td colspan="3" style="text-align: left;">
                <input type="file" style="margin-left: 5px;">
            </td>
        </tr>
        <tr>
            <td>
                글 내용
            </td>
            <td colspan="3">
            	<br>
				<div style="width: 100%; text-align: left;">&nbsp;${board.boardContent }</div>
				<br>
            </td>
        </tr>
        <tr>
          <td>
            댓글
          </td>
          <td colspan="3" style="height: 45px;">
            댓글 내역
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <input type="text" class="commentWrt" placeholder="댓글 작성">
          </td>
          <td colspan="2">
            <input type="button" class="btn commentBtn" value="댓글달기">
          </td>
        </tr>
      </table>
      <div>
      <input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
      <input type="button" class="write1 btn" onclick="location.href='boardDeleteProCon.do?boardCodeSeq=${board.boardCodeSeq }'" value="삭제">
      <input type="button" class="write2 btn" onclick="location.href='boardUpdateProCon.do?boardCodeSeq=${board.boardCodeSeq }'" value="수정">
      </div>
  </form>
</center>
</div>

</section>
<%@ include file="../include/footer.jsp" %>