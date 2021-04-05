<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<jsp:useBean id="today" class="java.util.Date" />
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<%@ include file="../include/header.jsp" %>
<link href="${context}/html/css/park1.css" rel="stylesheet">
<script>
	$(function(){
		$('#boardWrite').on('click', function(){
			if("${userId}" == ""){
				alert('로그인이 필요한 서비스입니다.');
				$(location).attr("href", "signIn.do");
			}
		});
		
		// 게시글 검색
 		$('#searchBtn').on('click', function(){
			var searchType = $("#boardSearchType > option:selected").val();
			var searchData = $("#boardSearch").val();
			if(searchData == ""){
				alert('검색어를 입력해주세요.')
			}else{
				document.location.href = "printBoardAjaxSearch.do?boardType=" + searchType + "&boardContent="+searchData;
			}
		});
		
		// 게시글 분류
		$('#boardType').on('change',function(){
			var boardType = $("#boardType > option:selected").val();
/* 			$.ajax({
				url : 'boardAjaxType.do',
				data : {
					boardType : boardType
				},
				type : 'get',
				dataType : 'json',
				success: function(data){ */
					document.location.href = "printBoardAjaxType.do?boardType=" + boardType;
/* 				},
				error: function(request, status, error){
					alert("code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + error);
				}
			}); */
		});
	});
</script>
<section class="row d-flex justify-content-center pb-5 m-0">
<div class="total col-10">
  <h2>커뮤니티</h2>
  <hr>
  <select class="boartType1" id="boardType" name="boardType" style="height:30px">
    <c:choose>
		<c:when test="${board.boardType eq '추천' }">
			<option value="전체">전체</option>
			<option value="추천" selected>추천</option>
            <option value="주변시설">주변시설</option>
           	<option value="문의">문의</option>
		</c:when>
		<c:when test="${board.boardType eq '주변시설' }">
			<option value="전체">전체</option>
			<option value="추천">추천</option>
        	<option value="주변시설" selected>주변시설</option>
        	<option value="문의">문의</option>
		</c:when>
		<c:when test="${board.boardType eq '문의' }">
			<option value="전체">전체</option>
			<option value="추천">추천</option>
        	<option value="주변시설">주변시설</option>
        	<option value="문의" selected>문의</option>
		</c:when>
		<c:otherwise>
			<option value="전체" selected>전체</option>
			<option value="추천">추천</option>
          	<option value="주변시설">주변시설</option>
         	<option value="문의">문의</option>
		</c:otherwise>
	</c:choose>
  </select>
  <div class="search">
    <select id="boardSearchType" name="boardSearchType" style="height:30px">
      <option value="전체">전체</option>
      <option value="제목">제목</option>
      <option value="작성자">작성자</option>
    </select>
    <input type="text" id="boardSearch" name="boardSearch" style="height:30px">
    <input type="button"id="searchBtn" class="btn btn-third" value="검색">
  </div>
	<center>
		<input type="hidden" name="userId" id="userId" value="${board.userId }" />
		<table class="comT">
			<c:if test="${check ne null }">
				<tr>
					<th colspan="5" id="searchResult">
						"${check }" 의 검색 결과
					</th>
				</tr>
			</c:if>
		    <tr class="type">
		      <td class="boardType2" style="width: 250px;">게시글 종류</td>
		      <td class="boardTitle">게시글 제목</td>
		      <td class="boardHeart">♥</td>
		      <td class="boardWriter">작성자</td>
		      <td class="boardDate">작성일</td>
		      <td class="boardCount">조회</td>
		    </tr>
	    	<tr></tr>
		    <c:if test="${boardListCount eq 0 }">
		    	<tr>
					<td colspan="5">
						<br>게시글이 없습니다<br>
					</td>
				</tr>
			</c:if>
		 	<c:if test="${boardListCount ne 0 }">
		 		<c:forEach var="bestBoard" items="${bestList }">
					<tr id="bestList">
						<td>${bestBoard.boardType }</td>
						<td class="ellipsis1 pl-2 pr-2 pt-2 pb-2">
							<a href="boadSelectOneCon.do?boardCodeSeq=${bestBoard.boardCodeSeq }" class="Btitle">${bestBoard.boardTitle }</a>
							<c:choose>
								<c:when test="${bestBoard.commentCnt eq 0 }">
								</c:when>
								<c:when test="${bestBoard.commentCnt ne 0 }">
									<p style="display: inline; color: tomato;">[${bestBoard.commentCnt}]</p>
								</c:when>
							</c:choose>
						</td>
						<td>
							${bestBoard.thumbsCnt }
						</td>
						<td>
							${bestBoard.userId }
						</td>
						<td>
							<fmt:formatDate value="${bestBoard.boardDate }" type="DATE" dateStyle="MEDIUM"/>
						</td>
						<td>
							${bestBoard.boardCount }
						</td>
					</tr>
				</c:forEach>
		 		<c:forEach var="board" items="${boardList }" varStatus="status">
					<tr id="boardList">
						<td>${board.boardType }</td>
						<td class="ellipsis1 pl-3 pr-3 pt-2 pb-2">
							<a href="boadSelectOneCon.do?boardCodeSeq=${board.boardCodeSeq }" class="Btitle">${board.boardTitle }</a>
							<c:choose>
								<c:when test="${board.commentCnt eq 0 }">
								</c:when>
								<c:when test="${board.commentCnt ne 0 }">
									<p style="display: inline; color: tomato;">[${board.commentCnt}]</p>
								</c:when>
							</c:choose>
						</td>
						<td>
							${board.thumbsCnt }
						</td>
						<td>
							${board.userId }
						</td>
						<td>
							<fmt:formatDate value="${board.boardDate }" type="DATE" dateStyle="MEDIUM"/>
						</td>
						<td>
							${board.boardCount }
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 앞 페이지 번호 처리 -->
			<tr height="20">
				<td colspan="5" style="margin: 10px; padding-top:20px">
					<c:if test="${currentPage <= 1}"></c:if>
		  			<c:if test="${currentPage > 1}">
						<c:url var="boardList" value="board.do">
							<c:param name="page" value="${currentPage-1}" />
						</c:url>
						<a href="${boardList}" class="beforePage">
							<b>
								< 이전
							</b>
						</a>
					</c:if>
					<!-- 번호 처리 -->
					<c:set var="maxPage" value="${maxPage}" />
					<c:forEach var="endPage" begin="${startPage+1}" end="${maxPage}">
						<c:if test="${endPage eq currentPage}">
							<font size="4">
								<b class="myButton1">
									${endPage}
								</b>
							</font>
						</c:if>
						<c:if test="${endPage ne currentPage}">
							<c:url var="boardListCheck" value="board.do">
								<c:param name="page" value="${endPage}" />
							</c:url>
							<a href="${boardListCheck}" class="myButton2">${endPage}</a>
						</c:if>
					</c:forEach>
					<!-- 끝 페이지 번호 처리 -->
					<c:if test="${currentPage >= maxPage}"></c:if>
					<c:if test="${currentPage < maxPage}">
						<c:url var="boardListEND" value="board.do">
							<c:param name="page" value="${currentPage+1}" />
						</c:url>
						<a href="${boardListEND}" class="afterPage">
							<b>
								다음 >
							</b>
						</a>
					</c:if>
				</td>
			</tr>
		</table>
	</center>
	<div class="d-flex justify-content-end m-0">
		<input type="button" class="btn write" id="boardWrite" onclick="location.href='boardWrite.do'" value="글쓰기" >
	</div>
	
</div>

</section>
<%@ include file="../include/footer.jsp" %>