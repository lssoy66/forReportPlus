<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>ForReport</title>

</head>

<%@ include file="../includes/header.jsp"%>


<!-- 상단표시: Listing Section Begin -->
<section class="listing-hero set-bg"
	data-setbg="/resources/img/listing/details/listing-hero.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-8">
				<div class="listing__hero__option">

					<div class="listing__hero__text">						
						<div class="listing__hero__widget">

							<div>
								<div>
									<h3>작성자: 관리자</h3>
								</div>

							</div>

						</div>
					</div>

				</div>
			</div>
</section>
<!-- 상단표시: Listing Section End -->

<!-- 상품 정보: 상품 썸네일, 상품 설명 -->
<!-- 별점 & 댓글 -->
<!-- Listing Details Section Begin -->
<section class="listing-details spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="listing__details__text">
					<div class="listing__details__about">
						<h4>
							<c:out value="제목: ${QuestionVO.questiontitle}" />
						</h4>
						<br>
						<h4>내용</h4>
						<p>
							<c:out value="${QuestionVO.question}"></c:out>
						</p>
					</div>
				</div>
			</div>
</section>
<!-- Listing Details Section End -->

<!-- AJAX를 사용하기 위해 review.js 가져오기 -->
<script type="text/javascript" src="/resources/js/review.js"></script>

<!-- 자바스크립트 효과 -->
<script type="text/javascript">
	$(document).ready(function() {

	}); // ready 끝
</script>
<!-- footer에서 가져옴 -->

<%@ include file="../includes/footer.jsp"%>