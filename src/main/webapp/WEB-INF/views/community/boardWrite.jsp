<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park2.css" rel="stylesheet">

<!-- SmartEditor2 라이브러리 --> 
<script type="text/javascript" src="${context}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script>
	// 파일 업로드
	$(function(){
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
		<center style="font-size: 23px;">
			<form class="center" action="boardWriteCon.do" enctype="multipart/form-data" method="post" id="frm">
				<table>
					<tr>
						<td style="width: 300px;">제목</td>
						<td style="width: 900px; height: 50px;">
							<h3 class="m-0">
								<input type="text" class="title" placeholder=" 제목" name="boardTitle" id="boardTitle">
							</h3>
						</td>
						<td style="border-left: 1px solid #ccc; padding: 10px;">
							<select style="border: none;" name="boardType" id="boardType">
								<option value="종류">종류</option>
								<option value="추천">추천</option>
								<option value="주변시설">주변시설</option>
								<option value="문의">문의</option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="width: 80px;">
							첨부파일
						</td>
						<td colspan="2" style="text-align: left;">
							<a href="#" id="fileUpload" style="margin-left: 20px;">
								<i class="far fa-file" id="fileBefore"></i>
								<i class="fas fa-file" id="fileAfter" style="display: none;"></i>
								<label for="files" id="fileLabel">
									파일
								</label>
								<input type="file" class="opacity-0" id="files">
							</a>
						</td>
					</tr>
					<tr>
						<td>
							글 내용
						</td>
						<td colspan="2">
						<textarea name="boardContent" id="smartEditor"></textarea>
						</td>
					</tr>
				</table>
				<input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
				<input type="submit" class="write3 btn" id="save" value="글쓰기">
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

		//		// 리셋버튼 클릭 시
		//		$("#reset").click(function(){
		//			document.getElementById("smartEditor").value = "apple";
		//			oEditors.getById["smartEditor"].exec("FOCUS");
		//		});

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
					var result = confirm(selcatd + " 글을 작성 하시겠습니까?");
					if (result) {
						$("#frm").submit();
					} else {
						return false;
					}
				});
	});
</script>
<%@ include file="../include/footer.jsp" %>