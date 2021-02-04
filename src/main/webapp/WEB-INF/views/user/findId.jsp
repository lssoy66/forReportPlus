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
		<form action="/user/findIdProcess.fr" method="post">
		<!-- spring security csrf token 설정1 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="w3-center w3-large w3-margin-top">
				<h3>아이디 찾기</h3>
			</div>
			<div>
				<p>
					<label>회원 가입 시 입력한 이메일 주소</label> <input class="w3-input" type="text" id="email"
						name="email" required>
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
/* //spring security csrf token 설정2
var header = "${_csrf.headerName}";
var token = "${_csrf.token}";

$('#findBtn').click(function(){
	var email = $('#email').val();
	
	$.ajax({
		type : "post",
		url : "/user/findIdProcess.fr",
		// spring security csrf token 설정3
		beforeSend : function(xhr){
			if(token && header){
				xhr.setRequestHeader(header, token);
			}
		},
		data : {email : email},
		success : function(result){
			if(result == null){
				
				alert('해당하는 이메일이 없습니다.');
//				history.go(-1);
				$('#email').focus();
				
			} else {
				var id = result;
				
				console.log(id);
				
// 				$("form").data('id', id);
// 				$("form").attr('action', '/user/findIdResult.fr');
// 				$("form").submit();
			}
		}
	});
}); */

</script>
<%@ include file="../includes/footer.jsp"%>