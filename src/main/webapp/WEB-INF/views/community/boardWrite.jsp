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
		$('#check').on('submit', function(){
			var boardType = $('#boardType').val();
			if(boardType == '종류'){
				alert('게시글의 종류를 선택해주세요.');
				return "";
			}else{
				return true;
			}
		});
	});
</script>
<section>
<div class="total">
  <h2>커뮤니티</h2>
  <hr>
  <center style="font-size: 23px;">
    <form class="center" action="boardWriteCon.do" method="post" id="frm">
      <table>
        <tr>
            <td style="width: 300px;">제목</td>
            <td style="width: 900px; height: 50px;">
                <h2><input type="text" class="title" style="margin-top: 20px;" placeholder=" 제목" name="boardTitle"></h2>
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
                <input type="file" style="margin-left: 5px;">
            </td>
        </tr>
        <tr>
            <td>
                글 내용
            </td>
            <td colspan="2">
                <textarea name="boardContent" id="smartEditor" style="width: 100%; height: 430px;"></textarea>
            </td>
        </tr>
      </table>
      <input type="button" class="btn toList" onclick="location.href='board.do'" value="목록">
      <input type="reset" class="btn reset">
      <input type="submit" class="write3 btn" id="save" value="글쓰기">
  </form>
</center>
</div>
</section>
<script type="text/javascript">
	var oEditors = [];
	$(function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "smartEditor", //textarea에서 지정한 id와 일치해야 합니다. 
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI: "${context}/editor/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
				fOnBeforeUnload : function(){
				}
			}, 
			fCreator: "createSEditor2"
		});
			
		//저장버튼 클릭시 form 전송
		$("#save").click(function(){
		oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#frm").submit();
	});    
});
</script>
<%@ include file="../include/footer.jsp" %>