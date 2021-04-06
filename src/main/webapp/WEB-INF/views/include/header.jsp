<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NearBnB</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="${context}/html/css/style.css" rel="stylesheet">
<script src="https://www.gstatic.com/firebasejs/8.3.2/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.2/firebase-analytics.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.2/firebase-storage.js"></script>
<script src="${context}/html/js/firebaseConfig.js"></script>
<script type="text/javascript">
var c = 0;
function pop() {
	if(c == 0) {
		$('#profile-card').css('display', 'block');
		c = 1;
	} else {
		$('#profile-card').css('display', 'none');
		c = 0;
	}
}

function loginCheck() {
	alert('로그인 후 이용가능 합니다.');
	location.href = 'signIn.do';
}

function checkFileType(fileName) {
	var reg = /.+\./;
    var checkFile = fileName.replace(reg.exec(fileName),"").toLowerCase();
    if(checkFile != "jpg" && checkFile != "png") {
    	alert("jpg 또는 png 형식의 사진만 올릴 수 있습니다.")
    	return false;
    }    
    return true;
}
$(function(){
	$('#edit-btn').on('click', function(){
		var formData = new FormData($('aa')[0]);
	});
	
	$('#aa').on('change', function(){
		var file = $('#aa')[0].files[0];
		var userId = "${sessionScope.userId}";
		var downloadUrl = null;
		console.log(file.name);
		
		// 확장자 검사
		if(!checkFileType(file.name)) {
			return;
		}
		
		var storageRef = firebase.storage().ref();
		
		storageRef
		.child(`images/`+file.name)
		.put(file)
		.on('state_changed', snapshot => {
			console.log(snapshot);
		}, error => {
			console.log(error);
		}, (res) => {
			let storageUrl = 'images/'+file.name;
			console.log(storageUrl);
			storageRef.child(storageUrl).getDownloadURL().then(function(url) {
				console.log(url);
				downloadUrl = url;
				console.log(url);
				$.ajax({
					url : 'insertProfile.do',
					data : {'userId' : userId,
							'profileName' : file.name,
							'profilePath' : downloadUrl},
					type : 'POST',
					dataType : 'json',
					success : function() {
						console.log('complete');
						alert('프로필 사진이 변경되었습니다.');
						location.href='index.do';
					},
					error : function() {
						alert('failed');
					}
				});
			});			
		});
	});
});


</script>
</head>
<body>
<header>
  <div class="row">
    <div class="col-3">
      <h1 class="logo">
        <a href="index.do"><img src ="${context}/html/images/logo.png" width="200px"></a>
      </h1>
    </div>
    <div class="col-9 justify-content-end align-self-center">
      <div class="row justify-content-end">
        <div class="col">
        <!-- 비로그인 상태일 때 -->
        <c:if test="${empty userId}">
          <div class="d-flex justify-content-end right-menu">
              <button type="button" class="btn community" onclick="location.href='board.do'">커뮤니티</button>
              <button type="button" class="btn add_room" onclick="loginCheck()">내 숙소 등록하기</button>
              <button type="button" class="btn btn-primary" onclick="location.href='signIn.do'">로그인</button>
              <button type="button" class="btn btn-secondary" onclick="location.href='signUp.do'">회원가입</button>
          </div>
        </c:if>
        <!-- 로그인 상태 & 프로필 사진 없음 -->
        <c:if test="${userProfile eq 'N  '}">
          <div class="d-flex justify-content-end right-menu">
              <button type="button" class="btn community" onclick="location.href='board.do'">커뮤니티</button>
              <button type="button" class="btn add_room" onclick="location.href='placeAdd.do'">내 숙소 등록하기</button>
              <button class="ml-1" onclick="pop()"><img src ="${context}/html/images/defaultprofile.jpg" style="width: 44px; height: 44px;"></button>
          </div>
          <div class="d-flex justify-content-end mt-2">
          	<div id="profile-card">
	          	<div id="card-header">
	          		<div id="pic">
	          			<img src ="${context}/html/images/defaultprofile.jpg">
	          		</div>
	          		<div id="name" style="font-size: 20px;">${userId}</div>
	          		<div id="edit-btn">
	          			<label id="edit-profile" for="aa">프로필 수정하기</label>
	          			<input type="file" id="aa" style="display: none;" />	          				          		
	          		</div>     			
	          	</div>
	          	<div id="card-footer">
	          		<div id="item">
	          			<button type="button" class="btn btn-primary" onclick="location.href='myPage.do'">마이페이지</button>
	              		<button type="button" class="btn btn-secondary" onclick="location.href='signOut.do'">로그아웃</button>	
	          		</div>
	          	</div>
          	</div>
          </div>
        </c:if>
        <!-- 로그인 상태 & 프로필 사진 있음 -->
        <c:if test="${userProfile eq 'Y  '}">
          <div class="d-flex justify-content-end right-menu">
              <button type="button" class="btn community" onclick="location.href='board.do'">커뮤니티</button>
              <button type="button" class="btn add_room" onclick="location.href='placeAdd.do'">내 숙소 등록하기</button>
              <div id="after-pic" onclick="pop()">
	          	<img src ="${profileUrl}">
	          </div>
          </div>
          <div class="d-flex justify-content-end mt-2">
          	<div id="profile-card">
	          	<div id="card-header">
	          		<div id="pic">
	          			<img src ="${profileUrl}">
	          		</div>
	          		<div id="name" style="font-size: 20px;">${userId}</div>
	          		<div id="edit-btn">
	          			<label id="edit-profile" for="aa">프로필 수정하기</label>
	          			<input type="file" id="aa" style="display: none;" />	          				          		
	          		</div>
	          	</div>
	          	<div id="card-footer">
	          		<div id="item">
	          			<button type="button" class="btn btn-primary" onclick="location.href='myPage.do'">마이페이지</button>
	              		<button type="button" class="btn btn-secondary" onclick="location.href='signOut.do'">로그아웃</button>	
	          		</div>
	          	</div>
          	</div>
          </div>
        </c:if>
        </div>
      </div>
    </div>
  </div>
</header>