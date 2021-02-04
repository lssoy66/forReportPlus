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
			<h3>아이디 찾기 검색결과</h3>
		</div>
		<div>
			<h5>${ id}</h5>
			<p class="w3-center">
				<button type="button" id=loginBtn
					class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Login</button>
				<button type="button" onclick="history.go(-1);"
					class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
			</p>
		</div>
	</div>
</div>

<script>
$(function(){
	$("#loginBtn").click(function(){
		location.href='../login/customLogin.fr';
	});
});
</script>

<%@ include file="../includes/footer.jsp"%>