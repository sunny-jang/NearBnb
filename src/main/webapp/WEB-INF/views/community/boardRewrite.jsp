<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">

<!-- SmartEditor2 라이브러리 --> 
<script type="text/javascript" src="${context}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>

<section style="height: 100vh;">
	<div class="total">
		<h2>커뮤니티</h2>
		<hr>
		<center>
			<form class="center" action="boardUpdateCon.do" method="post" id="frm">
				<table style="font-size: 20px;">
					<tr>
						<td style="width: 100px;">제목</td>
						<td style="width: 900px; height: 50px;">
							<h2>
								<input type="text" class="title" style="margin-top: 17px;" name="boardTitle" id="boardTitle" value="${board.boardTitle }">
							</h2>
						</td>
						<td style="border-left: 1px solid #ccc; padding: 10px;">
							<select style="border: none;" name="boardType" id="boardType">
								<c:choose>
									<c:when test="${board.boardType eq '추천' }">
										<option value="종류">종류</option>
										<option value="추천" selected>추천</option>
										<option value="주변시설">주변시설</option>
										<option value="문의">문의</option>
									</c:when>
									<c:when test="${board.boardType eq '주변시설' }">
										<option value="종류">종류</option>
										<option value="추천">추천</option>
										<option value="주변시설" selected>주변시설</option>
										<option value="문의">문의</option>
									</c:when>
									<c:otherwise>
										<option value="종류">종류</option>
										<option value="추천">추천</option>
										<option value="주변시설">주변시설</option>
										<option value="문의" selected>문의</option>
									</c:otherwise>
								</c:choose>
							</select>
						</td>
					</tr>
					<tr>
						<td style="width: 80px;">
							첨부파일
						</td>
						<c:choose>
							<c:when test="${boardFile.boardCodeSeq eq null}">
								<td colspan="3">
									<h5>
										등록된 파일이 없습니다.
									</h5>
								</td>
							</c:when>
							<c:when test="${boardFile.boardCodeSeq ne null }">
								<td colspan="3" style="text-align: left;">
									<a href="#" id="fileDownload" style="margin-left: 20px; text-decoration: none;">
										<i class="fas fa-file" id="fileAfter" style="font-size: 25px;"></i>
										<label for="files" id="fileLabel">${boardFile.bFileOriginalName }</label>
										<input type="text" class="opacity-0" id="files" readonly>
									</a>
								</td>
							</c:when>
						</c:choose>
					</tr>
					<tr>
						<td>글 내용</td>
						<td colspan="2"><textarea id="smartEditor" name="boardContent">${board.boardContent }</textarea>
							<input type="hidden" name="boardCodeSeq" value="${board.boardCodeSeq }" />
						</td>
					</tr>
				</table>
				<input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
				<input type="submit" id="save" class="write3 btn" value="수정하기">
			</form>
		</center>
	</div>
</section>
<script type="text/javascript">
	var oEditors = [];
	$(function() {
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "smartEditor", //textarea에서 지정한 id와 일치해야 합니다. 
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI : "${context}/editor/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
				fOnBeforeUnload : function() {
				}
			},
			fCreator : "createSEditor2"
		});

		// 저장버튼 클릭 시 form 전송
		$("#save").click(
				function() {
					oEditors.getById["smartEditor"].exec(
							"UPDATE_CONTENTS_FIELD", []);
					var selcatd = $("#boardType > option:selected").val();
					var title = $("#boardTitle").val();
					var content = document.getElementById("smartEditor").value;

					if (selcatd == "종류") {
						alert("카테고리를 선택해주세요.");
						return false;
					}
					if (title == null || title == "") {
						alert("제목을 입력해주세요.");
						$("#boardTitle").focus();
						return false;
					}
					if (content == "" || content == null || content == '&nbsp;'
							|| content == '<br>' || content == '<br/>'
							|| content == '<p>&nbsp;</p>') {
						alert("본문을 작성해주세요.");
						oEditors.getById["smartEditor"].exec("FOCUS");
						return false;
					}
					var result = confirm("글을 수정 하시겠습니까?");
					if (result) {
						$("#frm").submit();
					} else {
						return false;
					}
				});
	});
</script>
<%@ include file="../include/footer.jsp" %>