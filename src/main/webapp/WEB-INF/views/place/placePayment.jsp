<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
// model checkbox jquery
$(function(){
	$('#allcheck').click(function(){
		if($('#allcheck').prop('checked') == true) {
			$('input[name=check]').prop('checked', true);
		} else {
			$('input[name=check]').prop('checked', false);
		}
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
	      	<div class="payment-content bg-warning">
	      	  <img class="payment-icon" src="images/ico_pay_320.png" />
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
            <div class="place-image col-4 align-self-center">
              <div class="place-image" style="background-color: black;"></div>
            </div>
            <div class="col-8">
              <span class="place-host">User11님의 숙소</span>
              <h5 class="place-name ellipsis2">숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름 숙소이름</h5>
              <span class="place-option">최대인원 4명 . 숙소 유형 아파트</span>
              <p class="place-des ellipsis2">여름휴가 간 동안 집이 비어서 올리게 되었습니다~ 깨끗하게 써주실 분 찾습니다~^^* 주실 분 찾습니다~^^* 주실 분 찾습니다~^^* .....</p>
              <div class="d-flex justify-content-between">
                <div>16 <i class="fa fa-heart"></i></div>
                <div>30,000 원 / 박</div>
              </div>
            </div>
          </a>          
          </div>
          <div class="content-box">
            <div class="place-info">
              <div class="content-title">날짜</div>
              <div class="content">21-03-17 ~ 21-03-19</div>
            </div>
            <div class="place-info">
              <div class="content-title">게스트</div>
              <div class="content">게스트 4명</div>
            </div>
            <div class="place-info">
              <div class="content-title">요금</div>
              <div class="content">￦89,000 × 2박 = ￦178,000</div>
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