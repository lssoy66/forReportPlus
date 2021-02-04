<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 차트 그리기 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

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
					
					<h5>나의 판매내역</h5>
					
					<!-- 총 금액 & 차트 -->
					<div class="listing__details__comment chart">
						<div class="container">
							<div class="row">
								<div class="col-lg-5" style="text-align: center">
									<br><br>
									<h5>총 수익금</h5>
									<h1 style="color: #038f88; font-size: 60px; display: inline">
									<b><c:out value="${priceAll }" /></b></h1><p style="display: inline; font-size: 25px">원</p>
									<br><br>
									<p style="display: inline">내가 등록한 자료</p> : 
									<p style="display: inline; font-size: 20px; color: #038f88">${saleCount }개</p>
									
								</div>
								<div class="col-lg-7" style="text-align: center">
									<h5>판매 수 TOP 5</h5>
									<canvas id="myChart1"></canvas>
								</div>
							</div>
						</div>
						<br>
					</div>
					
					
					
<!-- 					차트 -->
<!-- 					<div class="listing__details__comment"> -->
<%-- 						<canvas id="myChart1"></canvas> --%>
<!-- 					</div> -->
					
					<!-- 판매내역 테이블 -->
					<div class="listing__details__comment saleList">
					
						<table class="table text-center thCustom2">
							<tr>
								<th>상품번호</th>
								<th>상품명</th>
								<th>가격</th>
								<th>등록일</th>
								<th>판매 수</th>
								<th>승인여부</th>
							</tr>
							<c:forEach items="${saleList }" var="sale">
							<tbody>
								<tr data-price="${sale.price }">
									<td><p><c:out value="${sale.pronum }" /></p></td>
									<td><p><a href="/product/view.fr?pronum=${sale.pronum}"><c:out value="${sale.proname }" /></a></p></td>
									<td><p><c:out value="${sale.price}" /></p></td>
									<td><p><fmt:formatDate value="${sale.uploadDate }" pattern="yyyy-MM-dd"/></p></td>
									<td><c:out value="${sale.count }" /> </td>
									<c:choose>
										<c:when test="${sale.approval == 1 }">
											<td style="color: blue">승인</td>
										</c:when>
										<c:when test="${sale.approval == 2 }">
											<td style="color: red">승인거부</td>
										</c:when>
										<c:when test="${sale.approval == 3 }">
											<td style="color: red">삭제요청</td>
										</c:when>
										<c:otherwise>
											<td style="color: black">승인대기</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</tbody>
							</c:forEach>
							
						</table>
						
						<div class="saleListDescCountDiv">
							<c:forEach items="${saleListDescCount }" var="saleListCount">
								<div data-proname="${saleListCount.proname }"
									data-count="${saleListCount.count}"></div>
							</c:forEach>
						</div>
						
						<!-- start Pagination -->
						<div class="pull-right">
							<div class="blog__pagination">
								
								<c:if test="${pageMaker.prev }">
									<a href="${pageMaker.startPage - 1 }">
										<i class="fa fa-long-arrow-left"></i> Previous
									</a>
								</c:if>
								
								<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
									<c:choose>
										<c:when test="${pageMaker.criteria.pageNum==num}">
											<a href="${num }">
												<strong style="color:#038f88">${num}</strong>
											</a>
										</c:when>
										<c:otherwise>
											<a href="${num }">
												${num}
											</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
								<c:if test="${pageMaker.next }">
									<a href="${pageMaker.endPage + 1 }">
										Next<i class="fa fa-long-arrow-right"></i>
									</a>
								</c:if>	
								
							</div>
						</div>
						<!-- end Pagination -->
						
						<form id="actionForm" action="/order/mySaleList.fr" method="get">
							<input type="hidden" name="pageNum" value="${pageMaker.criteria.pageNum }">	
							<input type="hidden" name="amount" value="${pageMaker.criteria.amount }">
						</form>
					
					</div>
					
				</div>

			</div>
			
		</div>
	</div>
	
</section>
<!-- Blog Details Section End -->


<script>

	$(document).ready(function(){
		
		// cartHeader.jsp의 로그아웃 처리
		$(".logout").click(function(e){
        			
        	e.preventDefault();
        	$(".logoutForm").submit();
        			
        });
		 
		(function(){
			var saleList = '<c:out value="${saleList.isEmpty() }" />';
			checkSaleList(saleList);
		})();
		
		function checkSaleList(saleList){
			console.log("checkSaleList");
			if(saleList == "true"){
				$(".chart").remove();
				$(".thCustom2").html("<h5>판매한 상품이 없습니다.</h5>");
			}
		} 
		
		// 페이징 처리
		var actionForm = $("#actionForm");
		
		$(".blog__pagination a").on("click", function(e){
			e.preventDefault();
			console.log("click");
			actionForm.find("input[name='pageNum']")
						.val($(this).attr("href"));
			actionForm.submit();
		}); 
		
		
		// 차트를 만들기 위해 판매개수로 정렬된 상품을 다섯 개 가져온다(판매 수(count) + 상품명(proname))
		var arrCount = [];
		var arrProname = [];
		
		// 즉시실행함수
		(function(){
			$(".saleListDescCountDiv div").each(function(i, obj){
				if(i < 5){
					arrCount[i] = $(obj).data("count");
					arrProname[i] = $(obj).data("proname");
				}
			});
		})();
		
		// 차트1 - 도넛(판매 수 TOP 5)
		data = { 
				datasets: [{ 
					backgroundColor: ['#48d4a3','#038f88','#83c9a9', '#b7c9c5', '#8be8d3'], 
					data: arrCount
				}], 
				// 라벨의 이름이 툴팁처럼 마우스가 근처에 오면 나타남 
				labels: arrProname
		}; 
		
		var ctx1 = $("#myChart1"); 
		var donutOptions = { 
				legend: {position:'bottom', padding:5, 
				labels: {pointStyle:'circle', usePointStyle:true}} 
		};

		var myPieChart = new Chart(ctx1, { 
			type: 'doughnut', 
			data: data, 
			options: donutOptions
		});

		
		
	});
	
</script>

<%@ include file="../includes/footer.jsp"%>