<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<%@ include file="../includes/cartHeader.jsp"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
	<sec:authentication property="principal.user.email" var="user_email" />
	<sec:authentication property="principal.user.phone" var="user_phone" />
	<sec:authentication property="principal.user.name" var="user_name" />
</sec:authorize>

<!-- Breadcrumb Begin -->
<div class="breadcrumb-area set-bg"
	data-setbg="/resources/img/breadcrumb/breadcrumb-normal.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center"></div>
		</div>
	</div>
</div>
<!-- Breadcrumb End -->

<!-- Work Section Begin -->
<section class="work work-about spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="section-title">
					<h2>주문성공!</h2>
					<p>주문이 정상적으로 확인되었습니다.</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div class="work__item">
					<div class="work__item__number" style="color:#7bdbca">OrderSuccess</div>
						<img src="/resources/img/work/work-2.png" alt="">
						<h5>For Report를 이용해주셔서 감사합니다.</h5>
						<p>
							구매한 상품은 <a href="/order/myOrderList.fr">구매내역</a>에서 확인 가능합니다.
						</p>
						<br>
						
					<div class="row">
						<div class="col-lg-3 col-md-3">

						</div>
						<div class="col-lg-2 col-md-2" id="custom">
							<br>
							<b>구매자</b><br><br>
							<b>휴대폰</b><br><br>
							<b>이메일</b><br><br>
							<br>
							<b>주문번호</b><br><br>
							<b>결제방식</b><br><br>
							<b>주문일자</b><br><br>
							<br>
							<b>총 결제금액</b><br><br>						
						</div>
						<div class="col-lg-4 col-md-4" id="custom">
							<br>
							${order.id }<br><br>
							${user_phone }<br><br>
							${user_email }<br><br>
							<br>
							${order.ordernum }<br><br>
							${order.paymethod }<br><br>
							<fmt:formatDate pattern="yyyy-MM-dd" value="${order.orderdate }"/><br><br>
							<br>
							<p id="customP">${priceAll }</p><br><br>						
						</div>
						
						<div class="col-lg-3 col-md-3">

						</div>
					</div>
					
					<div class="row">
						<div class="col-lg-2 col-md-2">

						</div>
						<div class="col-lg-8 col-md-8" id="custom">
							<div class="about__text">
								<br>
								<table class="table text-center">
									<thead>
										<tr>
											<th>상품명</th>
											<th>판매자</th>
											<th>가격</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${productList }" var="product">
											<tr data-price="${product.price }">
												<td><c:out value="${product.title }" /> </td>
												<td><c:out value="${product.id }" /></td>
												<td><c:out value="${product.price }" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
							<c:if test="${!empty vbank }">
								<c:if test="${order.paymethod == 'vBank'}">
									<div class="about__text">
										<br>
										<div class="section-title">
											<p>아래 계좌로 입금해주셔야 결제가 완료됩니다.</p>
										</div>
										<table class="table text-center">
											<thead>
												<tr>
													<th>입금계좌명</th>
													<th>은행명</th>
													<th>예금주</th>
													<th>입금기한</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><c:out value="${vbank.vbnum }" /></td>
													<td><c:out value="${vbank.vbname }" /> </td>
													<td><c:out value="${vbank.vbholder }" /></td>
													<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vbank.vbdate }"/></td>
												</tr>
											</tbody>
										</table>
									</div>
								</c:if>
							</c:if>
							
							
							<br><br>
							<div class="section-title">
								<a href="/" class="site-btn" id="orderButton2">홈으로</a>&nbsp;
								<a href="/order/myOrderList.fr" class="site-btn" id="orderButton">구매내역</a>
							</div>
							
							
							
						</div>
						<div class="col-lg-2 col-md-2">

						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Work Section End -->

<script>

	$(document).ready(function(){
		
		// cartHeader.jsp의 로그아웃 처리
		$(".logout").click(function(e){
        			
        	e.preventDefault();
        	$(".logoutForm").submit();
        			
        });
		
	});

</script>

<%@ include file="../includes/footer.jsp"%>

