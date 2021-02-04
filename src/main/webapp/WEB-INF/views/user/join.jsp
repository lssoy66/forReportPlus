<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/cartHeader.jsp"%>

<!-- Blog Hero Begin -->
<div class="blog-details-hero set-bg"
	data-setbg="/resources/img/blog/details/blog-hero.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-7">
				<div class="blog__hero__text">
					<h2>회원 가입</h2>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Blog Hero End -->

<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<div class="hero__text">
				<article id="content" class="cols-d">
					<div>
						<form method="POST" id="joinForm">
						<!-- spring security csrf token 설정1 -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<!-- 아이디 -->
							<div class="form-group">
								<label for="user_id">아이디</label> <input type="text"
									class="form-control" id="id" name="id"
									placeholder="ID" required>
								<div class="check_font" id="idCheck"></div>
							</div>
							<!-- 비밀번호 -->
							<div class="form-group">
								<label for="user_pw">비밀번호</label> <input type="password"
									class="form-control" id="password" name="password"
									placeholder="PASSWORD" required>
								<div class="check_font" id="pwCheck"></div>
							</div>
							<!-- 비밀번호 재확인 -->
							<div class="form-group">
								<label for="user_pw2">비밀번호 확인</label> <input type="password"
									class="form-control" id="password2" name="password2" disabled="disabled"
									placeholder="Confirm Password" required>
								<div class="check_font" id="pwCheck2"></div>
							</div>
							<!-- 이름 -->
							<div class="form-group">
								<label for="user_name">이름</label> <input type="text"
									class="form-control" id="name" name="name"
									placeholder="Name" required>
								<div class="check_font" id="nameCheck"></div>
							</div>
							<!-- 본인확인 이메일 -->
							<div class="form-group">
								<label for="user_email">이메일</label> <input type="text"
									 class="form-control" name="email" id="email"
									 value="${param.email }" readonly
									 required>
							</div>
							<!-- 휴대전화 -->
							<div class="form-group">
								<label for="user_phone">휴대전화 ('-' 없이 번호만 입력해주세요)</label> <input
									type="text" class="form-control" id="phone"
									name="phone" placeholder="Phone Number" required>
								<div class="check_font" id="phoneCheck"></div>
							</div>
							<div class="reg_button">
								<a class="btn btn-danger px-3"
									href="${pageContext.request.contextPath}"> <i
									class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
								</a>&emsp;&emsp;
								<button class="btn btn-primary px-3" id="joinBtn">
									<i class="fa fa-user-plus" aria-hidden="true"></i>가입하기
								</button>
							</div>
						</form>
					</div>
				</article>
			</div>
		</div>
	</div>
</div>

<script>
//spring security csrf token 설정2
var header = "${_csrf.headerName}";
var token = "${_csrf.token}";

// 유효성 검사 통과 유무 변수
var idChk = false;					// 아이디 정규식, 중복 확인
var pwChk = false;					// 비밀번호 정규식 확인
var pwCheckChk = false;			// 비밀번호 일치 확인
var nameChk = false;				// 이름 정규식 확인
var phoneChk = false;				// 연락처 정규식 확인


//아이디 유효성 검사
$('#id').keyup(function(){
	var id = $('#id').val();
	var idJ = /^[a-z0-9]{4,12}$/; // 아이디 정규식

	
	$.ajax({
		type : "post",
		url : "/user/idCheck.fr",
		// spring security csrf token 설정3
		beforeSend : function(xhr){
			if(token && header){
				xhr.setRequestHeader(header, token);
			}
		},
		data : {id : id},
		success : function(result){
			if(result == 'fail'){
				$('#idCheck').text("사용중인 아이디입니다.");
				$("#idCheck").css("color", "red");
				

			} else if (!idJ.test(id)) {

				$('#idCheck').text('아이디를 다시 입력해주세요 :: 4~12자리(영소문자, 숫자)');
				$('#idCheck').css('color', 'red');

			} else {

				$('#idCheck').text('사용 가능한 아이디입니다');
				$('#idCheck').css('color', 'green');
				idChk = true;
			}
		}
	});
});

// 비밀번호 유효성 검사
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
		pwChk = true;
	}
});

// 비밀번호 일치 확인
$('#password2').keyup(function(){
	
	var pw = $('#password').val();
	var pw2 = $('#password2').val();
	
	if(pw == pw2){
		
		$('#pwCheck2').text('비밀번호가 일치합니다');
		$('#pwCheck2').css('color', 'green');
		pwCheckChk = true;
		
	} else {
		
		$('#pwCheck2').text('비밀번호가 일치하지 않습니다');
		$('#pwCheck2').css('color', 'red');
	}
});

// 이름 유효성 검사
$('#name').keyup(function(){
	var name = $('#name').val();
	var nameJ = /^[가-힣]{2,6}$/;		// 이름 정규식

	if(!nameJ.test(name)){
		
		$('#nameCheck').text('이름을 다시 입력해주세요 :: 2~6자리(한글)');
		$('#nameCheck').css('color', 'red');
		
	} else if (name == "") {

		$('#nameCheck').text('이름을 입력해주세요 :: 2~6자리(한글)');
		$('#nameCheck').css('color', 'red');
		
	} else {
		$('#nameCheck').css('display', 'none');
		nameChk = true;
	}
});

// 연락처 유효성 검사
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

//회원가입 처리
$("#joinBtn").click(function(){

	if(idChk && pwChk && pwCheckChk && nameChk && phoneChk){
		$("#joinForm").attr("action", "/user/joinProcess.fr");
		$("#joinForm").submit();
	} else {
		alert("정보를 다시 입력해주세요");
	}

});
	
</script>
<%@ include file="../includes/footer.jsp"%>