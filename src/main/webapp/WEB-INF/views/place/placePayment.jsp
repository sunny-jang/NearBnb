<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
// model checkbox jquery
$(function(){

	var object = JSON.parse(localStorage.bookInfo);
	var placeName = '<c:out value="${place.placeName}" />';	
	var totalPrice = (object.totalPrice).replaceAll(',', ''); 

	init();
	

	$('#allcheck').click(function(){
		if($('#allcheck').prop('checked') == true) {
			$('input[name=check]').prop('checked', true);
		} else {
			$('input[name=check]').prop('checked', false);
		}
	});
	
	function init() {
		var object = JSON.parse(localStorage.bookInfo);
		
		$("#placeImage").css("background-image",object.imagePath);
		$("#checkIn").text(object.bookCheckIn);
		$("#checkOut").text(object.bookCheckOut);
		$("#bookPerson").text(object.bookPerson);
		$("#dateDiff").text(object.dateDiff);
		$("#totalPrice").text(object.totalPrice);
		
	}

	
	$('#kakaoPay').click(function(){
		$.ajax({
			url : 'kakaoPay.do',
			data : {'placeName' : placeName, 'totalPrice' : totalPrice},
			dataType: 'json',
			success : function(data) {				
				 var msg = data.next_redirect_pc_url;
				 location.href = msg;
			}, error : function(error) {
				alert(error);
			}			
		});
	});
});

function openIMP() {
	var object = JSON.parse(localStorage.bookInfo);
	
	var IMP = window.IMP; // 생략가능
	IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '${place.placeName}',
	    amount : (object.totalPrice).replaceAll(',', ''),
	    buyer_email : 'iamport@siot.do',
	    buyer_name : object.uId,
	}, function(rsp) {
	    if ( rsp.success ) {
	        location.href='kakaoPayComplete.do';
	    } 
	});
}
</script>
<section>
  <div class="container">
    <div class="title">
      <h1>결제하기</h1>
    </div>
    <hr>
      <div class="row section-left">
        <!-- main-left -->
        <div class="col">
	      <h2>결제 수단 선택</h2>
	      <div class="payment-box d-flex justify-content-around">
	      	<div class="payment-content bg-warning" data-toggle="modal" data-target="#normalModal" onclick="openIMP()">
	      	  <i class="fas fa-money-check payment-icon" style="font-size: 25px;"></i>
	      	  <h5 class="payment-text1">일반 신용카드 결제</h5>
	      	</div>
	      	<div class="payment-content bg-warning" id="kakaoPay">
	      	  <img class="payment-icon" src="${context}/html/images/ico_pay_320.png" />
	      	  <h5 class="payment-text2">카카오 페이 결제</h5>
	      	</div>
	      </div>
        </div>
        <!-- main-right -->
        <div class="col">
          <div class="d-flex justify-content-between">
            <h2>&nbsp;예약 정보</h2>
          </div>
          <div class="place-li">
          <a href="#" class="row">
            <div class="place-image col-4 align-self-center" id="placeImage">
             
            </div>
            <div class="col-8">
              <span class="place-host">${place.uId}님의 숙소</span>
              <h5 class="place-name ellipsis2">${place.placeName}</h5>
              <span class="place-option">최대인원 ${place.maxGuest}명 . 숙소 유형 ${place.placeType}</span>
              <p class="place-des ellipsis2">${place.placeDesc}</p>
              <div class="d-flex justify-content-between">
                <div>${place.placeThumb} <i class="fa fa-heart"></i></div>
                <div><fmt:formatNumber value="${place.placePrice}" /> 원 / 박</div>
              </div>
            </div>
          </a>          
          </div>
          <div class="content-box">
            <div class="place-info">
              <div class="content-title">날짜</div>
              <div class="content"><span id="checkIn">${book.bookCheckIn}</span> ~ <span id="checkOut">${book.bookCheckOut}</span></div>
            </div>
            <div class="place-info">
              <div class="content-title">게스트</div>
              <div class="content">게스트 <span id="bookPerson">${book.bookPerson}</span>명</div>
            </div>
            <div class="place-info">
              <div class="content-title">요금</div>
              <div class="content">￦&nbsp;<fmt:formatNumber value="${place.placePrice}" /> × <span id="dateDiff"></span>박 = ￦&nbsp;<span id="totalPrice"></span></div>
            </div>           
          </div>       
        </div>
      </div>
    </div>
</section>
<%@ include file="../include/footer.jsp" %>