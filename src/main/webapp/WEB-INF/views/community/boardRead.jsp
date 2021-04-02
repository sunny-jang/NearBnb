<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">
<script>
// 댓글 수정
function boardCommentUpdate(index){
	$('.viewContent'+index.value).css("display", "none");
	$('.subComment'+index.value).css("display", "none");
	$('.hideContent'+index.value).css("display", "inline");
	$('.reBtn'+index.value).on('click', function(){
		var reCommentCode = $('#commentCodeSeq'+index.value).val();
		var reCommentContent = $('.reContent'+index.value).val();

 		$.ajax({
 			url : 'boardCommentAjaxUpdate.do',
 			cache: false,
			data : {
				reCode : reCommentCode,
				reContent : reCommentContent
			},
			type : 'POST',
			dataType : 'json',
			success : function(data){
				$('.hideContent'+index.value).css("display", "none");
				$('.viewContent'+index.value).html(data.reC);
				$('.viewContent'+index.value).css("display", "inline");
			},
			error: function(request, status, error){
				alert("code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + error);
			}
		});
	});
	
	// 댓글 삭제
	$('.delComment'+index.value).on('click', function(){
		if("${userId}" == ""){
			alert('로그인이 필요한 서비스입니다.');
			$(location).attr("href", "signIn.do");
		}else if($('#commentId').val() != "${sessionScope.userId}"){
			alert('삭제 권한이 없습니다.');
		}
	});
	
}

// 대댓글 달기
function subCommentIns(index){
	$('.subComment'+index.value).css("display", "inline");
	$('.hideContent'+index.value).css("display", "none");
	$('.viewContent'+index.value).css("display", "inline");
	
 	$('.subBtn'+index.value).on('click', function(){
 		var subComment = [];
		subComment.push($("#boardCodeSeq").val());
		subComment.push("${sessionScope.userId}");
		subComment.push($('#commentCodeSeq'+index.value).val());
		subComment.push($(".subCommentContent"+index.value).val());

		$.ajax({
			url: 'subCommentInsert.do',
			traditional : true,
			data: {
				'sub': subComment
			},
			type: 'POST',
			success: function(data){
				location.reload();
			},
			error: function(request, status, error){
				alert("code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + error);
			}
		});
	});
 	
 	// 대댓글 취소
	$('.subCancle').on('click', function(){
		$('.subComment'+index.value).css("display", "none");
	});

}

$(function(){
	// 게시글 추천
	$('#thumb').on('click', function(){
		// alert($('#boardCodeSeq').val());
		// alert("${userId}");
		if("${userId}" == ""){
			alert('로그인이 필요한 서비스입니다.');
			$(location).attr("href", "signIn.do");
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
	
	// 게시글 수정
	$('#rewrite').on('click', function(){
		if("${userId}" == ""){
			alert('로그인이 필요한 서비스입니다.');
			$(location).attr("href", "signIn.do");
		}else if($('#userId').val() != "${sessionScope.userId}"){
			alert('수정 권한이 없습니다.');
		}else{
			document.location.href = 'boardUpdateProCon.do?boardCodeSeq=' + ${board.boardCodeSeq };
		}
	});
	
	// 게시글 삭제
	$('#delete').on('click', function(){
		var result = confirm('정말 삭제 하시겠습니까?');
		if("${userId}" == ""){
			alert('로그인이 필요한 서비스입니다.');
			$(location).attr("href", "signIn.do");
		}else if($('#userId').val() != "${sessionScope.userId}"){
			alert('삭제 권한이 없습니다.');
		}else if(result){
			document.location.href = 'boardDeleteCon.do?boardCodeSeq=' + ${board.boardCodeSeq };
		}
	});
	
	//댓글 달기
	$('#commentIns').on('click', function(){
		if("${userId}" == ""){
			alert('로그인이 필요한 서비스입니다.');
			$(location).attr("href", "signIn.do");
		}
	});
	
});
</script>
<section>
	<div class="total">
		<h2>커뮤니티</h2>
		<hr>
		<center>
			<form method="get" id="commentForm" action="boardCommentInsert.do">
				<input type="hidden" name="boardCodeSeq" id="boardCodeSeq"
					value="${board.boardCodeSeq }" /> <input type="hidden"
					name="userId" id="userId" value="${board.userId }" />
				<table style="font-size: 20px;" id="tableEle">
					<tr>
						<td style="width: 150px;">제목</td>
						<td style="width: 800px; height: 50px;">
							<div class="title">
								<h2>${board.boardTitle }</h2>
							</div>
						</td>
						<td style="width: 100px;"><c:choose>
								<c:when test="${heart eq 'unSignIn' }">
									<button type="button" class="heart" id="thumb">♡</button>
								</c:when>
								<c:when test="${heart eq 'notThumbsUp' }">
									<button type="button" class="heart" id="thumb">♡</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="heart" id="thumb">♥</button>
								</c:otherwise>
							</c:choose>
							<h2 style="display: inline;" id="maxThumb">${thumbs }</h2></td>
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
						<td style="width: 80px;">첨부파일</td>
						<c:choose>
							<c:when test="${boardFile.boardCodeSeq eq null}">
								<td colspan="3">
									<h5>등록된 파일이 없습니다.</h5>
								</td>
							</c:when>
							<c:when test="${boardFile.boardCodeSeq ne null }">
								<td colspan="3" style="text-align: left;">
									<a href="boardFileDownload.do?boardCodeSeq=${boardFile.boardCodeSeq }" id="fileDownload" style="margin-left: 20px;">
										<i class="fas fa-file" id="fileAfter"></i>
										<label for="files" id="fileLabel">${boardFile.bFileOriginalName }</label>
										<input type="text" class="opacity-0" id="files" readonly>
									</a>
								</td>
							</c:when>
						</c:choose>
					</tr>
					<tr>
						<td style="height: 472px;">글 내용</td>
						<td colspan="3"><br>
							<div style="width: 100%; text-align: left;">&nbsp;${board.boardContent }</div>
							<br>
						</td>
					</tr>
					<tr class="commentBoard">
						<td colspan="4" style="height: 45px;">
							댓글
						</td>
					</tr>
					<c:if test="${comments eq 0 }">
						<tr class="cmtTr">
							<td colspan="5">
								첫 댓글을 남겨주세요!
							</td>
						</tr>
					</c:if>
					<c:if test="${comments ne 0 }">
						<c:forEach var="bC" items="${boardComment }" varStatus="status">
							<tr class="cmtTr">
								<input type="hidden" name="userId" id="commentId" value="${bC.userId }">
								<td style="height: 35px;" class="userId" id="commentId">
									${bC.userId }
								</td>
								<td style="text-align: left; padding-left: 30px; padding-top: 10px;" colspan="3" class="commentContent${status.index }">
									<input type="hidden" name="commentCodeSeq" id="commentCodeSeq${status.index}" value="${bC.commentCodeSeq }">
									<input type="hidden" name="currentComment${status.index }" id="commentCodeSeq" value="${status.index }"> 
									<c:choose>
										<c:when test="${sessionScope.userId eq bC.userId }">
											<a href="boardCommentDelete.do?commentCodeSeq=${bC.commentCodeSeq }&boardCodeSeq=${board.boardCodeSeq }"
												class="delComment${status.index }" id="delComment"
												onclick="return confirm('정말 삭제 하시겠습니까?')">
												 x 
											</a>
											<input type="button" class="updComment" value="∴" onclick="boardCommentUpdate(currentComment${status.index})">
											<input type="button" class="insSubComment" value="+" onclick="subCommentIns(currentComment${status.index})">
										</c:when>
										<c:otherwise>
											<input type="button" class="insSubComment" value="+" onclick="subCommentIns(currentComment${status.index})">
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${bC.parentCommentCode eq 0}">
											<h5 class="viewContent${status.index}">
												${bC.commentContent }
											</h5>
										</c:when>
										<c:when test="${bC.parentCommentCode ne 0}">
											<h5 class="viewContent${status.index}" style="margin-left: 20px;">
												└ ${bC.commentContent }
											</h5>
										</c:when>
									</c:choose>
									<div style="display: none;" class="hideContent${status.index}">
										<input type="button" class="write2 btn reBtn${status.index}" value="댓글 수정">
										<input type="text" value="${bC.commentContent }" class="reContent${status.index}" style="width: 450px; height: 30px;">
									</div>
									<p style="font-size: 11px; color: #BEBEBE;" class="commentDate">
										<fmt:formatDate value="${bC.commentDate}" pattern="YYYY-MM-dd hh:mm" />
									</p>
									<div style="display: none; margin-left: 20px;" class="subComment${status.index}">
										<input type="text" class="subCommentContent${status.index}" style="width: 450px; height: 30px;">
										<input type="button" class="write4 btn subBtn${status.index}" value="댓글 달기">
										<input type="button" class="subCancle subCancle${status.index}" value="x">
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<tr>
						<td colspan="2">
							<input type="text" class="commentWrt" name="commentContent" id="commentContent" placeholder="댓글 작성" required>
						</td>
						<td colspan="2">
							<input type="submit" class="btn commentBtn" id="commentIns" value="댓글달기">
						</td>
					</tr>
				</table>
			</form>
			<div>
				<input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
				<input type="button" id="delete" class="write1 btn" value="삭제">
				<input type="button" class="write2 btn" id="rewrite" value="수정">
			</div>
		</center>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>