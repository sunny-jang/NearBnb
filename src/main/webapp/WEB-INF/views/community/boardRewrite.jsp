<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">

<!-- SmartEditor2 라이브러리 --> 
<script type="text/javascript" src="${context}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script>
$(function(){
	// 파일 삭제
		$('#fileDelete').on('click', function(){
		var boardCode = $('#boardCodeSeq').val();
		$.ajax({
			url : 'boardAjaxFileDelete.do',
			method : 'POST',
			data : {
				boardCodeSeq: boardCode,
			},
			success : function(data){
				$('#fileLabel').html('등록된 파일이 없습니다.');
				$('#fileBefore').css('display', 'inline');
				$('#fileAfter').css('display', 'none');
			},
			error: function(request, status, error){
				alert("code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + error);
			}
		});
	}); 
	
	// 파일 업로드
		$('#fileUpload').on('change', function(){
			var boardForm = $('#frm')[0];
			var formData = new FormData();
			var file = $('#files')[0].files[0];
			var fileName = new Date().getTime() + file.name;

			formData.append("file", file);

			var storageRef = firebase.storage().ref();

		    storageRef
		    .child(`images/`+file.name)
		    .put(file)
		    .on('state_changed', snapshot => {
		           console.log(snapshot)
		       }, error => {
		           console.log(error);
		       }, (res) => {
		           let storageUrl = 'images/'+file.name;
		           
		           storageRef.child(storageUrl).getDownloadURL().then(function(url) {

						$.ajax({
							url : 'boardAjaxFileInsert.do',
							method : 'POST',
							data : formData,
							processData : false,
							contentType : false,
							success : function(data){
								var subData = data.substring(13, data.legnth);

								$('#fileLabel').html(subData);
								$('#fileBefore').css('display', 'none');
								$('#fileAfter').css('display', 'inline');
								
								var i = document.createElement("input");
								i.setAttribute("type","hidden");
								i.setAttribute("name","bFileChangedName");
								i.setAttribute("value",fileName);
								$("#frm").append(i);
								
								var j = document.createElement("input");
								j.setAttribute("type","hidden");
								j.setAttribute("name","bFileOriginalName");
								j.setAttribute("value",subData);
								$("#frm").append(j);
								
								var k = document.createElement("input");
								k.setAttribute("type","hidden");
								k.setAttribute("name","bFilePath");
								k.setAttribute("value",url);
								$("#frm").append(k);
							}
						});
		           }).catch(function(error) {});
		       });
		});
});
</script>

<section class="pb-5">
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
									<a href="#" id="fileUpload" style="margin-left: 20px; text-decoration: none;">
										<i class="fas fa-file" id="fileAfter" style="font-size: 25px;"></i>
										<label for="files" id="fileLabel">${boardFile.bFileOriginalName }</label>
										<input type="file" class="opacity-0" id="files" readonly>
									</a>
									<input type="button" id="fileDelete" value="x" style="border: none; background-color: white; color: lightgray;">
								</td>
							</c:when>
						</c:choose>
					</tr>
					<tr>
						<td>글 내용</td>
						<td colspan="2"><textarea id="smartEditor" name="boardContent">${board.boardContent }</textarea>
							<input type="hidden" id="boardCodeSeq" name="boardCodeSeq" value="${board.boardCodeSeq }" />
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