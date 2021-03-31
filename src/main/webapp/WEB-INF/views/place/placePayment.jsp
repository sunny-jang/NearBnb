<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
// model checkbox jquery
$(function(){
	var object = JSON.parse(localStorage.bookInfo);
	var placeName = '<c:out value="${place.placeName}" />';	
	console.log(object);
	init();
	
	$('#allcheck').click(function(){
		if($('#allcheck').prop('checked') == true) {
			$('input[name=check]').prop('checked', true);
		} else {
			$('input[name=check]').prop('checked', false);
		}
	});
	
	function init() {
		
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
			data : {'itemName' : placeName, 'totalPrice' : '100000'},
			dataType: 'json',
			success : function(data) {				
				 var msg = data.next_redirect_pc_url;
				 window.open(msg);
			}, error : function(error) {
				alert(error);
			}			
		});
	});
});
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
	      	<div class="payment-content bg-warning" data-toggle="modal" data-target="#normalModal">
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
              <h5 class="place-name ellipsis2" id="placeName">${place.placeName}</h5>
              <span class="place-option">최대인원 ${place.maxGuest}명 . 숙소 유형 ${place.placeType}</span>
              <p class="place-des ellipsis2">${place.placeDesc}</p>
              <div class="d-flex justify-content-between">
                <div>${place.placeThumb} <i class="fa fa-heart"></i></div>
                <div>${place.placePrice} 원 / 박</div>
              </div>
            </div>
          </a>          
          </div>
          <div class="content-box">
            <div class="place-info">
              <div class="content-title">날짜</div>
              <div class="content"><span id="checkIn"></span> ~ <span id="checkOut"></span></div>
            </div>
            <div class="place-info">
              <div class="content-title">게스트</div>
              <div class="content">게스트 <span id="bookPerson"></span>명</div>
            </div>
            <div class="place-info">
              <div class="content-title">요금</div>
              <div class="content">￦${place.placePrice} × <span id="dateDiff"></span>박 = <span id="totalPrice"></span></div>
            </div>           
          </div>       
        </div>
      </div>
      <div class="d-flex justify-content-center align-self-center">
        <button type="button" class="btn btn-warning btn-lg">결제확인</button>	
      </div>      
    </div>
    <!-- normalModal -->
    <div class="modal fade" id="normalModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content container">
          <div class="modal-header align-self-center mt-2">
            <h1>일반 신용 결제</h1>
          </div>
          <div class="modal-body">
            <div>
              <h3>결제 수단</h3>
            </div>
            <select class="form-control" >
              <option>신용카드 또는 체크카드</option>
            </select>
            <input type="text" class="form-control mt-2" placeholder="카드번호" />
            <div class="input-group">
              <input type="text" class="form-control" placeholder="만료일" />
              <input type="text" class="form-control" placeholder="CVV" />
            </div>
            <div class="form-check mt-3">
              <input type="checkbox" name="check" id="allcheck" class="form-check-input" value=""><h5>전체 동의</h5>
            </div>
            <div class="form-check mt-2">
              &nbsp;&nbsp;<input type="checkbox" name="check" class="form-check-input" value=""><u>숙소이용규칙 및 취소/환불규정 동의</u><span style="font-color: red;">(필수)</span>
            </div>
            <div class="form-check mt-2">
              &nbsp;&nbsp;<input type="checkbox" name="check" class="form-check-input" value=""><u>개인정보 수집 및 이용 동의</u><span style="font-color: red;">(필수)</span>
            </div>
            <div class="form-check mt-2">
              &nbsp;&nbsp;<input type="checkbox" name="check" class="form-check-input" value=""><u>개인정보 제 3자 제공 동의</u><span style="font-color: red;">(필수)</span>
            </div>  
            <div class="form-check mt-2">
              &nbsp;&nbsp;<input type="checkbox" name="check" class="form-check-input" value=""><u>숙소이용규칙 및 취소/환불규정 동의</u><span style="font-color: red;">(필수)</span>
            </div>
          </div>
          <div class="pt-3">
            <div class="d-flex justify-content-start ml-5">
      	      <h4>총 결제금액</h4>
            </div>
            <div class="d-flex justify-content-end mr-5">
            	<h1>178,000 원</h1>
            </div>
          </div>
          <div class="d-flex justify-content-center align-self-center m-3">
        	<button type="button" class="btn btn-warning btn-lg">결제하기</button>	
          </div>
        </div>
      </div>
    </div>  
</section>
<%@ include file="../include/footer.jsp" %>