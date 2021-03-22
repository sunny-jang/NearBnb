<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<!--myPageHostCheck / 마이페이지_내 숙소 예약현황-->
	<section>
		<div class="row flex-nowrap">
			<!--사이드바-->
			<div class="col-3 py-md-5 ">
				<div class="sidebar_menu">
					<h2>마이페이지</h2>
					<a href="#"><h5>- 내 예약 조회</h5></a> <a href="#"><h5>- 내 숙소
							예약 현황</h5></a> <a href="#"><h5>- 회원수정 / 탈퇴</h5></a>
				</div>
			</div>
			<!--사이드바 끝-->
			<!--메인-->
			<main class="col-8 py-md-5 pl-md-4 ">
				<h1>내 숙소 예약 현황</h1>
				<hr>
				<div class="card_content">
					<div class="place-li_je">
						<a href="#" class="row">
							<div class="place-image col-2 align-self-center">
								<div class="place-image" style="background-color: black;"></div>
							</div>
							<div class="col-10">
								<div class="d-flex justify-content-between">
									<span class="place-host">User11님의 숙소 </span>
									<div>30,000 원 / 박</div>
								</div>
								<h5 class="place-name ellipsis1">숙소이름 숙소이름 숙소이름 숙소이름 숙소이름
									숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름
									숙소이름</h5>
								<p>
									게스트이름 : <br> 총 결제금액 : 300000<br> 총 인원수 : 4 명
								</p>
							</div>
						</a>
					</div>
				</div>
			</main>
			<!--/메인-->
		</div>
	</section>
<%@ include file="../include/footer.jsp" %>
