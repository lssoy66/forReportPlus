<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<%@ include file="../includes/cartHeader.jsp"%>

<!-- Blog Hero Begin -->
<div class="blog-details-hero set-bg"
	data-setbg="/resources/img/blog/details/blog-hero.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-7">
				<div class="blog__hero__text">
					<h2></h2>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Blog Hero End -->

<div class="w3-content w3-container w3-margin-top">
	<div class="w3-container w3-card-4">
		<div class="w3-center w3-large w3-margin-top">
			<h3>내 정보 변경</h3>
		</div>
		<div>
			<form id="myForm" action="/user/updateInfo.fr" method="post">
				<!-- spring security csrf token 설정1 -->
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}">
				<p>
					<label>ID</label> <input class="w3-input" type="text" id="id"
						name="id" readonly value="${user_id}">
				</p>
				<p>
					<label>연락처</label> <input class="w3-input" type="text" id="phone"
						name="phone">
					<div class="check_font" id="phoneCheck"></div>	
				</p>
				<p>
					<label>Email</label> <input class="w3-input" type="text" id="email"
						name="email">
					<div class="check_font" id="emailCheck"></div>	
				</p>
				<p class="w3-center">
					<button type="submit"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">회원정보
						변경</button>
				</p>
			</form>
			<br />
			<form id="pwForm" action="/user/updatePw.fr" method="post">
				<!-- spring security csrf token 설정1 -->
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}"> <input type="hidden" name="id"
					value="${user_id}">
				<p>
					<label>새 비밀번호</label> <input class="w3-input" id="password"
						name="password" type="password" required>
						<div class="check_font" id="pwCheck"></div>
				</p>
				<p>
					<label>비밀번호 확인</label> <input class="w3-input" type="password"
						id="password2" required>
						<div class="check_font" id="pwCheck2"></div>
				</p>
				<p class="w3-center">
					<button type="submit" id="updatePwBtn"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" disabled="disabled">비밀번호
						변경</button>
				</p>
			</form>
			<form id="wdForm" action="/user/withdrawal.fr" method="post">
				<!-- spring security csrf token 설정1 -->
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}"> <input type="hidden" name="id"
					value="${user_id}" id="id">
<!-- 				<p> -->
<!-- 					<label>현재 비밀번호</label> <input class="w3-input" name="password" -->
<!-- 						type="password" id="password" required> -->
<!-- 				</p> -->
				<p>
					<label>현재 비밀번호</label> <input class="w3-input" name="inputPassword"
						type="password" id="inputPassword" required>
					 <input type="hidden" name="password" value="${user_pw}" id="password">
				</p>
				<p class="w3-center">
					<button type="submit" id="withdrawalBtn"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">회원탈퇴</button>
				</p>
			</form>
		</div>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
//연락처 유효성 검사
$('#phone').keyup(function(){
	var phone = $('#phone').val();
	var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/; //연락처 정규식

	if(!phoneJ.test(phone)){
		
		$('#phoneCheck').text('연락처를 다시 입력해주세요 :: 10~11자리(숫자)');
		$('#phoneCheck').css('color', 'red');
		
	} else if (phone == "") {

		$('#phoneCheck').text('연락처를 입력해주세요 :: 10~11자리(숫자)');
		$('#phoneCheck').css('color', 'red');
		
	} else {
		$('#phoneCheck').css('display', 'none');
		phoneChk = true;
	}
});

//이메일 유효성 검사
$("#email").keyup(function() {
	var email = $("#email").val();	// 이메일 주소
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	 if (email == "") {

		$('#emailCheck').text('이메일을 입력해주세요');
		$('#emailCheck').css('color', 'red');
		
	} else if (!mailJ.test(email)) {

		$('#emailCheck').text('이메일을 다시 입력해주세요 예)forreport0202@gmail.com');
		$('#emailCheck').css('color', 'red');

	} else {

		$('#emailCheck').text('사용 가능한 이메일입니다');
		$('#emailCheck').css('color', 'green');
	}

});


// 새 비밀번호 유효성 검사
$('#password').keyup(function(){
	var pw = $('#password').val();
	var pwJ = /^[A-Za-z0-9]{4,12}$/; 	// 비밀번호 정규식

	if(!pwJ.test(pw)){
		
		$('#pwCheck').text('비밀번호를 다시 입력해주세요 :: 4~12자리(영대소문자, 숫자)');
		$('#pwCheck').css('color', 'red');
		
	} else if (pw == "") {

		$('#pwCheck').text('비밀번호를 입력해주세요 :: 4~12자리(영대소문자, 숫자)');
		$('#pwCheck').css('color', 'red');
		
	} else {
		$('#pwCheck').css('display', 'none');
		$("#password2").attr("disabled", false); 	
	}
});

// 새 비밀번호 일치 확인
$('#password2').keyup(function(){
	
	var pw = $('#password').val();
	var pw2 = $('#password2').val();
	
	if(pw == pw2){
		
		$('#pwCheck2').text('비밀번호가 일치합니다');
		$('#pwCheck2').css('color', 'green');
		$("#updatePwBtn").attr("disabled", false); 	
		
	} else {
		
		$('#pwCheck2').text('비밀번호가 일치하지 않습니다');
		$('#pwCheck2').css('color', 'red');
	}
});
</script>
<%@ include file="../includes/footer.jsp"%>