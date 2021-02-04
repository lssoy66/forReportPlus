<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/cartHeader.jsp"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
	<sec:authentication property="principal.user.email" var="user_email" />
	<sec:authentication property="principal.user.phone" var="user_phone" />
	<sec:authentication property="principal.user.name" var="user_name" />
	<sec:authentication property="principal.user.grade" var="user_grade" />
</sec:authorize>

<!-- Blog Hero Begin -->
<div class="blog-details-hero set-bg"
	data-setbg="/resources/img/blog/details/blog-hero.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-7">
				<div class="blog__hero__text">
					<h2>내 정보</h2>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Blog Hero End -->

<!-- Blog Details Section Begin -->
<section class="blog-details spad2">
	<div class="container">
		<div class="row">
		
			<div class="col-lg-3">
				<div class="blog__sidebar">
					<div class="blog__sidebar__recent" style="text-align:center">
						
						<h5 style="color: #038f88; font-size:30px">${user_id }</h5>
						
						${user_name }님<br><br>
						등급 : 
						<c:choose>
							<c:when test="${user_grade == 1 }">
								브론즈<br><p>상품 5개 이상 업로드</p>
							</c:when>
							<c:when test="${user_grade == 2 }">
								실버<br><p>상품 10개 이상 업로드</p>
							</c:when>
							<c:when test="${user_grade == 3 }">
								골드<br><p>상품 15개 이상 업로드</p>
							</c:when>
							<c:otherwise>
								일반 회원
							</c:otherwise>
						</c:choose>
					</div>
					<div class="blog__sidebar__categories">
						<h6>주문 관리</h6>
						<ul>
	                        <li><a href="/order/myOrderList.fr">주문내역 </a></li>
	                        <li><a href="/order/mySaleList.fr">판매내역 </a></li>
	                    </ul>
                    </div>
					
				</div>
			</div>
			<div class="col-lg-9">
				<div class="blog__details__text">
					
					<h5>나의 주문내역</h5>
					
					<div class="listing__details__comment">
						<table class="table text-center thCustom">
							<c:if test="${orderList.isEmpty() == 'false'}">
								<thead>
									<tr>
										<th colspan="6">
											<fmt:formatDate value="${orderList.get(0).orderdate }" var="day" pattern="yyyy-MM-dd"/>
											<c:out value="${day }" />&nbsp;
										</th>
									</tr>
								</thead>
								<c:forEach items="${orderList }" var="order">
									<fmt:formatDate value="${order.orderdate }" var="orderdate" pattern="yyyy-MM-dd"/>
									<c:if test="${orderdate != day}">
										<c:set value="${orderdate }" var="day"></c:set>
										<thead>
											<tr> 
												<th colspan="6"> 
													<c:out value="${day }" />&nbsp; 
												</th> 
											</tr> 
										</thead>
									</c:if> 
									<tbody>
										<tr>
											<td rowspan="2" class="tdImg">
												<img src='/product/showThumbnail.fr?pronum=${order.pronum}&index=0' 
													alt='' style='width:100px; height: 100px; margin: 0px'>
											</td>
											<td>주문번호</td>
											<td>상품명</td>
											<td>결제금액</td>
											<td>결제방식</td>
											<td>-</td>
										</tr>
										<tr>
											<td><p><c:out value="${order.ordernum }" /></p></td>
											<td><p><a href="/product/view.fr?pronum=${order.pronum}"><c:out value="${order.proname }" /></a></p></td>
											<td><p><c:out value="${order.payprice}" /></p></td>
											<td><p><c:out value="${order.paymethod }" /></p></td>
											<c:if test="${order.paymethod == 'vBank' }">
												<td><button class="site-btn modalVbank" 
													id="customButtonVbank" data-ordernum="${order.ordernum }">
												가상계좌</button></td>
											</c:if>
											<c:if test="${order.paymethod == 'card' }">
												<td><button class="site-btn download" id="btnColorCustom" data-pronum="${order.pronum}">다운로드</button></td>
											</c:if>
										</tr>
									</tbody>
								</c:forEach>
							</c:if>
						</table>
					</div>
					
				</div>

			</div>
			
		</div>
	</div>
	
</section>
<!-- Blog Details Section End -->

	<!-- Modal 추가  -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
	                <h4 class="modal-title" id="myModalLabel">가상계좌 정보</h4>
				</div>
				<div class="modal-body">
					<p>아래 계좌로 입금하셔야 결제가 완료됩니다.</p>
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
							<c:forEach items="${vbankList }" var="vbank">
								<tr data-vordernum="${vbank.ordernum }"
									data-vbnum="${vbank.vbnum }"
									data-vbname="${vbank.vbname }"
									data-vbholder="${vbank.vbholder }"
									data-vbdate='<fmt:formatDate value="${vbank.vbdate }" pattern="yyyy-MM-dd"/>'>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">
						확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- ./modal-dialog -->
	</div>
	<!-- /.modal -->

<script>

	$(document).ready(function(){
		
		// cartHeader.jsp의 로그아웃 처리
		$(".logout").click(function(e){
        			
        	e.preventDefault();
        	$(".logoutForm").submit();
        			
        });
			
		(function(){
			var orderList = '<c:out value="${orderList.isEmpty() }" />';
			checkOrderList(orderList);
		})();
		
		function checkOrderList(orderList){
			console.log("checkOrderList");
			if(orderList == "true"){
				$(".thCustom").html("<h5>구매한 상품이 없습니다.</h5>");
			}
		} 
		
		var strapp = "";
		// modal 창 띄우기
		$(".modalVbank").click(function(e){
			e.preventDefault();
			
			// $("#myModal").find(".modal-body").html("");
			
			// 상품의 주문번호 전달
			var ordernum = $(this).data("ordernum");
			
			$("#myModal tbody tr").each(function(i, obj){
				var vordernum = $(obj).data("vordernum");
				console.log(ordernum);
				if(ordernum == vordernum){
					strapp = "";
					strapp += "<tr><td>" + $(obj).data("vbnum") + "</td>";
					strapp += "<td>" + $(obj).data("vbname") + "</td>";
					strapp += "<td>" + $(obj).data("vbholder") + "</td>";
					strapp += "<td>" + $(obj).data("vbdate") + "</td></tr>";
				}
			});
			console.log(strapp);
			$("#myModal tbody").append(strapp);
			// 모달 창 띄우기
			$("#myModal").modal("show");
        });
		
		$("#myModal").find(".btn").click(function(e){
			$("#myModal").modal("hide");
			strapp = "";
			$("#myModal tbody tr").html("");
		});
		
		// 첨부파일 다운로드
		$(".download").click(function(e){
			
			var pronum = $(this).data("pronum");
			self.location = "/product/download?pronum=" + pronum;
			
		});
		
		
	});
	
</script>

<%@ include file="../includes/footer.jsp"%>