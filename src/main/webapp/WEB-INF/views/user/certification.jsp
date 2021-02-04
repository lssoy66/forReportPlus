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
					<h2>이메일 본인 인증</h2>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Blog Hero End -->

<div class="container">
	<div class="row">
		<div class="col-lg-4" style="margin: auto">
			<div class="hero__text">
				<article id="content" class="cols-d" style="padding-top: 20px">
					<div>

						<!-- 이메일 발송 -->
						<form id="form1">
							<div class="form-group">
							<!-- spring security csrf token 설정1 -->
							<input type="hidden" name="${_csrf.headerName}" value="${_csrf.token}">
								<label for="email">이메일</label> <input type="text"
									class="form-control" name="email" id="email"
									placeholder="이메일 주소를 입력하세요" required style="width: 100%">
								<div class="check_font" id="emailCheck"></div>
								<br>
								<button type="button" id="sendBtn" style="width: 100%"
									class="btn btn-outline-danger btn-sm px-3" disabled="disabled">
									<i class="fa fa-envelope"></i>&nbsp;이메일 인증받기 (이메일 보내기)
								</button>
								&nbsp;
							</div>

						<!-- 인증번호입력 -->
							<div class="form-group">
								<div>
									<input type="number" class="codeCheck" style="width: 100%"
										name="codeCheck" id="codeCheck" placeholder="인증번호 입력" required>
									<div>&nbsp;&nbsp;</div>
									<button type="button" class="btn btn-outline-info btn-sm px-3" style="width: 100%"
										id="codeCheckBtn">
										<i class="fa fa-envelope"></i>&nbsp;확인
									</button>
									<div class="check_font" id="checkResult"></div>
									&nbsp;
								</div>
							</div>
						</form>

						<!-- 취소 | 다음 버튼-->
						<form method="POST">
							<div class="reg_button">
								<a class="btn btn-danger px-3"
									href="${pageContext.request.contextPath}"> <i
									class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
								</a>&emsp;&emsp;
								<button class="btn btn-primary px-3" id="nextBtn"
									type="button" disabled="disabled" style="float: right">
									<i class="fa fa-arrow-right" aria-hidden="true"></i> &nbsp; 다음단계
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
var code = ""; // 이메일 인증번호

// spring security csrf token 설정2
var header = "${_csrf.headerName}";
var token = "${_csrf.token}";

// 이메일 유효성 검사
$("#email").blur(function() {
	var email = $("#email").val();	// 이메일 주소
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	$.ajax({
		url : '/user/emailCheck.fr',
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
		success : function(result) {

			if (result == 'fail') {
				$("#emailCheck").text("사용중인 이메일입니다");
				$("#emailCheck").css("color", "red");

			} else if (email == "") {

				$('#emailCheck').text('이메일을 입력해주세요');
				$('#emailCheck').css('color', 'red');
				
			} else if (!mailJ.test(email)) {

				$('#emailCheck').text('이메일을 다시 입력해주세요 예)forreport0202@gmail.com');
				$('#emailCheck').css('color', 'red');

			} else {

				$('#emailCheck').text('사용 가능한 이메일입니다');
				$('#emailCheck').css('color', 'green');
				$("#sendBtn").attr("disabled", false); // 메일 보내기 버튼 활성화 변경						
			}
		}
	});
});

// 인증번호 이메일 전송
$("#sendBtn").click(function() {
	var email = $("#email").val();	// 이메일 주소

	$.ajax({
		type : 'get',
		url : 'certificationProcess.fr?email=' + email,
		// spring security csrf token 설정3
		beforeSend : function(xhr){
			if(token && header){
				xhr.setRequestHeader(header, token);
			}
		},
		success : function(data) {

			code = data;
		}
	});
	$("#codeCheck").focus();
});

// 인증번호 비교
$("#codeCheckBtn").click(function() {
	var inputCode = $("#codeCheck").val(); //입력 코드
	var checkResult = $("#checkResult"); // 비교 결과
	
	if(inputCode == code){
		checkResult.text("인증번호가 일치합니다");
		checkResult.css('color', 'green');
		$("#nextBtn").attr('disabled', false);		// 다음단계 버튼 활성화

	} else {
		checkResult.text("인증번호를 다시 확인해주세요");
		checkResult.css('color', 'red');
	}

});

// 회원가입 페이지 이동(이메일 주소 포함)
$("#nextBtn").click(function(){
	var email = $("#email").val();	// 이메일 주소
	

	$("#form1").attr('action', '/user/join.fr');
	$("#form1").submit();
	
});
</script>
<%@ include file="../includes/footer.jsp"%>