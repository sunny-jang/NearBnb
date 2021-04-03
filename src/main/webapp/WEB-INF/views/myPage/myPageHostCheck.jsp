<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<link href="${context}/html/css/park3.css" rel="stylesheet">
<%@ include file="../include/header.jsp" %>
	<!--myPageHostCheck / 마이페이지_내 숙소 예약현황-->
	<section>
		<div class="row flex-nowrap">
			<%@ include file="../include/sidemenu.jsp" %>
			<!--메인-->
			<main class="col-8 py-md-5 pl-md-4 ">
				<h1>내 숙소 예약 현황</h1>
				<hr>
				<c:forEach var="p" items="${placeList}" varStatus="status">
				<div class="card_content">
					<div class="place-li_je pt-2">
						<a href="myPageHostCalendar.do?pId=${p.placeId}" class="row justify-content-center">
							<div class="place-image col-2 align-self-center" style="background-image: url(/nearbnb/resources/html/images/${thumbnail[status.index]})">
								
							</div>
							<div class="col-9">
								<div class="d-flex justify-content-between">
									<span class="place-host">${p.uId}님의 숙소 </span>
									<div><fmt:formatNumber value="${p.placePrice}" /> 원 / 박</div>
								</div>
								<h5 class="place-name ellipsis1">${p.placeName}</h5>
								<p>
									주소 : ${p.placeAddress}&nbsp;${p.placeAddressDetail}<br> 최대 인원수 : ${p.maxGuest}명 <br> 추천수 : ${p.placeThumb}
								</p>
							</div>
						</a>
					</div>
				</div>
				<br>
				</c:forEach>
			</main>
			<!--/메인-->
		</div>
	</section>
<%@ include file="../include/footer.jsp" %>
