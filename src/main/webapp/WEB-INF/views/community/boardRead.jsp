<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">
<script>

//댓글 단 후 
function afterInsertComment(data){
	var tableEle = $(".asd");
	$(".cmtTr").remove();
	var trStr
	for(var i = 0; i <  data.commentListCnt ; i++ ){
		trStr += '<tr class = "cmtTr">'
        	 	  + '<td style="height: 35px;">' + data.commentList[i].userId + '</td>'
        		  + '<td style="text-align: left; padding-left: 30px; padding-top: 10px;" colspan="3">' 
        		  + data.commentList[i].commentContent + '<br>'
          		  + '<p style="font-size: 11px; color: #BEBEBE;">'
        		  + data.commentList[i].commentDate
          		  + '</p>'
        		  + '</td>'
      		      + '</tr>';
	}
	tableEle.after(trStr);
	$("#commentIns").prop("disabled", false);
}

	$(function(){
		$('#thumb').on('click', function(){
			// alert($('#boardCodeSeq').val());
			// alert("${userId}");
			if("${userId}" == ""){
				alert('로그인이 필요한 서비스입니다.');
			}else{
				$.ajax({
					url : 'boardAjaxThumbsUp.do',
					data : {
						boardCodeSeq : $('#boardCodeSeq').val(),
						userId : "${userId}"
					},
					type : 'GET',
					dataType : 'json',
					success: function(data){
						if(data.heart == 'unSignIn'){
							alert('로그인이 필요한 서비스입니다.');
						}
 						if(data.heart == 'notThumbsUp'){
							$('#thumb').html("♡");
						}
 						if(data.heart == 'thumbsUp'){
							$('#thumb').html("♥");
						}
						$('#maxThumb').html(data.maxThumb);
					},
					error: function(request, status, error){
						alert("code : " + request.status + "\n"
								+ "message : " + request.responseText + "\n"
								+ "error : " + error);
					}
				});
			}
		});
		
		//댓글달기
		$('#commentIns').on('click', function(){
			// Ajax로 폼 넘기기
			var commentForm = $('#commentForm')[0];
			var commentData = new FormData(commentForm);
			$("#commentIns").prop("disabled", true);
			if("${userId}" == ""){
				alert('로그인이 필요한 서비스입니다.');
				$(location).attr("href", "signIn.do");
			}else {
				$.ajax({
					url : "boardCommentInsert.do",
					enctype: 'multipart/form-data',
					data: commentData,
		            processData: false,
		            contentType: false,
		            cache: false,
					data : commentData,
					type : 'POST',
					dataType : 'json',
					success : function(data){
						var data = JSON.stringify(data);
						data = JSON.parse(data);
						afterInsertComment(data);
					},
					error: function(request, status, error){
						alert("code : " + request.status + "\n"
								+ "message : " + request.responseText + "\n"
								+ "error : " + error);
					}
				});
			}
		});
		
		// 게시글 수정
		$('#rewrite').on('click', function(){
			if("${userId}" == ""){
				alert('로그인이 필요한 서비스입니다.');
				$(location).attr("href", "signIn.do");
			}else if($('#userId').val() != "${sessionScope.userId}"){
				alert('수정 권한이 없습니다.');
			}
		});
		
		// 게시글 삭제
		$('#delete').on('click', function(){
			if("${userId}" == ""){
				alert('로그인이 필요한 서비스입니다.');
				$(location).attr("href", "signIn.do");
			}else if($('#userId').val() != "${sessionScope.userId}"){
				alert('삭제 권한이 없습니다.');
			}
		});
	});
</script>
<section>
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <center>
  	<form method="get" id="commentForm">
      <input type="hidden" name="boardCodeSeq" id="boardCodeSeq" value="${board.boardCodeSeq }" />
      <input type="hidden" name="userId" id="userId" value="${sessionScope.userId }" />
      <table style="font-size: 20px;" id="tableEle">
        <tr>
            <td style="width: 150px;">제목</td>
            <td style="width: 800px; height: 50px;">
                <div class="title" style="margin-top: 30px; text-align: left;"><h2>${board.boardTitle }</h2></div>
            </td>
            <td style="width: 100px;">
              <c:choose>
                <c:when test="${heart eq 'unSignIn' }">
              	  <button type="button" class="heart" id="thumb"  style="outline: none;">♡</button>
              	</c:when>
              	<c:when test="${heart eq 'notThumbsUp' }">
              	  <button type="button" class="heart" id="thumb"  style="outline: none;">♡</button>
              	</c:when>
              	<c:otherwise>
              	  <button type="button" class="heart" id="thumb" style="outline: none;">♥</button>
              	</c:otherwise>
              </c:choose>
              <h2 style="display: inline;" id="maxThumb">${thumbs }</h2>
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
            <td style="height: 472px;">
                글 내용
            </td>
            <td colspan="3">
            	<br>
				<div style="width: 100%; text-align: left;">&nbsp;${board.boardContent }</div>
				<br>
            </td>
        </tr>
        
        <c:if test="${comments eq 0 }">
        <tr>
          <td colspan="5">
첫 댓글을 남겨주세요!
          </td>
        </tr>
        </c:if>
        <c:if test="${comments ne 0 }">
          <tr class="asd">
            <td colspan="4" style="height: 45px;">
           	  댓글
            </td>
          </tr>
          <c:forEach var="bC" items="${boardComment }">
          <tr class = "cmtTr">
            <td style="height: 35px;" class="userId">
              ${bC.userId }
            </td>
            <td style="text-align: left; padding-left: 30px; padding-top: 10px;" colspan="3" class="commentContent">
              ${bC.commentContent }<br>
              <p style="font-size: 11px; color: #BEBEBE;" class="commentDate">
              	<fmt:formatDate value="${bC.commentDate}" pattern="YYYY-MM-dd hh:mm" /> 
              </p>
            </td>
          </tr>
          </c:forEach>
        </c:if>
        <tr>
          <td colspan="2">
            <input type="text" class="commentWrt" name="commentContent" id="commentContent" placeholder="댓글 작성">
          </td>
          <td colspan="2">
            <input type="submit" class="btn commentBtn" id="commentIns" value="댓글달기">
          </td>
        </tr>
      </table>
      </form>
  <div>
      <input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
      <a href="boardDeleteCon.do?boardCodeSeq=${board.boardCodeSeq }" id="delete" class="write1 btn" onclick="return confirm('정말 삭제 하시겠습니까?')">삭제</a>
      <input type="button" class="write2 btn" id="rewrite" onclick="location.href='boardUpdateProCon.do?boardCodeSeq=${board.boardCodeSeq }'" value="수정">
  </div>
</center>
</div>

</section>
<%@ include file="../include/footer.jsp" %>