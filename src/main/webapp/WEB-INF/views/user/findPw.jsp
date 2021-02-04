<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
		<form action="/user/findPwProcess.fr" method="post">
		<!-- spring security csrf token 설정1 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="w3-center w3-large w3-margin-top">
				<h3>비밀번호 찾기</h3>
			</div>
			<div>
				<p>
					<label>ID</label> <input class="w3-input" type="text" id="id"
						name="id" required="required">
					<div class="check_font" id="idCheck"></div>
				</p>
				<p>
					<label>Email</label> <input class="w3-input" type="text" id="email"
						name="email" required>
					<div class="check_font" id="emailCheck"></div>
				</p>
				<p class="w3-center">
					<button type="submit" id=findBtn
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">찾기</button>
					<button type="button" onclick="history.go(-1);"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">취소</button>
				</p>
			</div>
		</form>
	</div>
</div>

<script>

// spring security csrf token 설정2
var header = "${_csrf.headerName}";
var token = "${_csrf.token}";

var idChk = false;					// 아이디 확인
var emailChk = false;				// 이메일 확인

//아이디 일치 검사
$('#id').keyup(function(){
	var id = $('#id').val();
	
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
				$('#idCheck').text("존재하는 아이디입니다.");
				$('#idCheck').css('color', 'green');
				idChk = true;
				
			} else {
				$('#idCheck').text('일치하는 아이디가 없습니다.');
				$("#idCheck").css("color", "red");
			}
		}
	});
});

//이메일 일치 검사
$("#email").keyup(function() {
	var id = $('#id').val();
	var email = $("#email").val();	// 이메일 주소

	$.ajax({
		url : '/user/infoCheck.fr',
		type : 'post',
		// spring security csrf token 설정3
		beforeSend : function(xhr){
			if(token && header){
				xhr.setRequestHeader(header, token);
			}
		},
		data : {
			id : id
		},
		success : function(infoResult) {

			if (infoResult != 'null') {
				if(result == email){
					$("#emailCheck").text("이메일이 일치합니다.");
					$('#emailCheck').css('color', 'green');
					emailChk = true;	
				}

			} else {

				$('#emailCheck').text('이메일이 일치하지 않습니다.');
				$("#emailCheck").css("color", "red");
			
			}
		}
	});
});

// 이메일 전송 처리
$("#findBtn").click(function() {
	var email = $("#email").val();	// 이메일 주소

	$.ajax({
		url : '/user/findPwProcess.fr',
		type : 'post',
		// spring security csrf token 설정3
		beforeSend : function(xhr){
			if(token && header){
				xhr.setRequestHeader(header, token);
			}
		},
		data : {
			email : email
		},
		success : function() {

			 if (idChk && emailChk) {
				alert('해당 이메일로 임시 비밀번호를 발송하였습니다.');
				$("#findBtn").submit();
			}
		}
	});
});


</script>
<%@ include file="../includes/footer.jsp"%>