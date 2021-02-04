<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ include file="../includes_admin/header.jsp"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
</sec:authorize>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">전체 주문 조회</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- 검색 폼 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Search Form</div>
			<!--  /.panel-heading  -->
			<div class="panel-body">
				
				<form id="searchForm" action="/admin/orderList.fr" method="get">

					<table class="table">
							<tr>
								<th>주문번호</th>
								<td><input type="text" name="keywordOnum" value='<c:out value="${pageMaker.criteria.keywordOnum }"/>' /></td>
							</tr>
							<tr>
								<th>기간</th>
								<td>
 									<input type="date" name="keywordDayCustom" id="custom"> &nbsp; 
									<input type="radio" name="keywordDay" id="to"> 오늘 &nbsp;
									<input type="radio" name="keywordDay" id="yester"> 어제 &nbsp;
									<input type="radio" name="keywordDay" id="week"> 일주일
								</td>
							</tr>
							<tr>
								<th>상품명</th>
								<td><input type="text" name="keywordPname" value='<c:out value="${pageMaker.criteria.keywordPname }"/>' /></td>
							</tr>
							<tr>
								<th>결제방식</th>
								<td>
<!-- 										<input type="radio" name="keywordOme" value=""> 모두 &nbsp; -->
										<input type="radio" name="keywordOme" value="card"> 신용카드 &nbsp;
										<input type="radio" name="keywordOme" value="vBank"> 무통장입금
								</td>
							</tr>
					</table>
		
					
<!-- 					<input type="hidden" name="keywordDay" value="" /> -->
<!-- 					<input type="hidden" name="keywordOme" value="" /> -->
					
					<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.criteria.pageNum }"/>' />
					<input type="hidden" name="amount" value='<c:out value="${pageMaker.criteria.amount }"/>' />
		
					<button class="btn btn-default">Search</button>
				</form>
				
				
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-info">
			<div class="panel-heading">Order List(${pageMaker.total })</div>
			<!--  /.panel-heading  -->
			<div class="panel-body">
				
								
				<table class="table table-striped table-bordered table-hover">
				
					<thead>
						<tr>
							<th>주문번호</th>
							<td>상품명</td>
							<td>구매자ID</td>
							<td>결제방식</td>
							<td>결제금액</td>
							<td>주문일자</td>
						</tr>
					</thead>
					<c:forEach items="${orderList }" var="order">
						<tr>
							<td><c:out value="${order.ordernum }" /></td>
							<td><a href="/product/view.fr?pronum=${order.pronum}"><c:out value="${order.proname }" /></a></td>
							<c:if test="${order.id == null}">
								<td>탈퇴회원</td>	
							</c:if>
							<c:if test="${order.id != null}">
								<td><c:out value="${order.id }" /></td>	
							</c:if>
							<td><c:out value="${order.paymethod }" /></td>	
							<td><c:out value="${order.payprice }" /></td>
							<td><fmt:formatDate value="${order.orderdate }" pattern="yyyy-MM-dd"/> </td>
						
						</tr>
					</c:forEach>
				</table>
				
				<div class="pull-right">
					<ul class="pagination">
						
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous"><a href="${pageMaker.startPage - 1 }">Previous</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.criteria.pageNum == num ? "active":"" }" >
								<a href="${num }">${num }</a></li>
						</c:forEach>
						
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
						</c:if>	
					</ul>
				</div>
				<!-- end Pagination -->
				
				<form id="actionForm" action="/admin/orderList.fr" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.criteria.pageNum }">	
					<input type="hidden" name="amount" value="${pageMaker.criteria.amount }">
					
					<!-- 추가 -->
					<input type="hidden" name="type" value='<c:out value="${pageMaker.criteria.type }"/>'>
					<input type="hidden" name="keywordOnum" value='<c:out value="${pageMaker.criteria.keywordOnum }"/>'>
					<input type="hidden" name="keywordDay" value='<c:out value="${pageMaker.criteria.keywordDay }"/>' >
					<input type="hidden" name="keywordPname" value='<c:out value="${pageMaker.criteria.keywordPname }"/>' >
					<input type="hidden" name="keywordOme" value='<c:out value="${pageMaker.criteria.keywordOme }"/>' >
					
				</form>
				
				
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		
// 		$("input[id='custom']").change(function(){
// 			alert($(this).val().toString());
// 		});

		// header.jsp의 로그아웃 처리
		$("#logout").click(function(e){
        			
        	e.preventDefault();
        	$(".logoutForm").submit();
        			
        });

		// 페이징 처리
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log("click");
			actionForm.find("input[name='pageNum']")
						.val($(this).attr("href"));
			actionForm.submit();
		}); 
		
		// 검색
		var date = new Date();
		var newDate = "";
		var str = "";
		var searchForm = $("#searchForm");
		
		// 즉시실행함수
		(function(){
			
			$("input[id='custom']").change(function(){
				$("input[name='keywordDay']").each(function(){
					$(this).prop("checked", false);
				});
			});
			
			$("input[name='keywordDay']").change(function(){
				$("input[id='custom']").val(null);
				
			});
			
		})();	// end function 
		
		
		$("#searchForm button").on("click", function(e){
			
			e.preventDefault();
			
			if($("input:radio[id='to']").is(':checked')){
				newDate = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();	
				$("input:radio[id='to']").attr("value", newDate);
			} else if($("input:radio[id='yester']").is(':checked')) {
				var yesterMonth = date.getMonth() + 1;
				var yesterDate = date.getDate() - 1;
				if(date.getDate() - 1 < 0){
					// 이전 달의 마지막 날짜 구하기
					var lastDate = new Date(date.getFullYear(), date.getMonth(), -1);
					yesterDate = lastDate.getDate() - (-(date.getDate() - 1));
					yesterMonth = date.getMonth();
				}
				newDate = date.getFullYear() + "-" + yesterMonth + "-" + yesterDate;
				$("input:radio[id='yester']").attr("value", newDate);
			} else if($("input:radio[id='week']").is(':checked')) {
				var weekMonth = date.getMonth() + 1;
				var weekDate = date.getDate() - 7;
				if(date.getDate() - 7 < 0){
					// 만약 2월 4일인 경우 -7을 하면 -3이 반환
					// 이 경우 일주일 전 날짜를 구하려면 지난 달 마지막 날짜에서 -3을 빼야한다
					// 이전 달의 마지막 날짜 구하기
					var lastDate = new Date(date.getFullYear(), date.getMonth(), -1);
					weekDate = lastDate.getDate() - (-(date.getDate() - 7));
					weekMonth = date.getMonth();	// 지난달
				}
				newDate = date.getFullYear() + "-" + weekMonth + "-" + weekDate;
				$("input:radio[id='week']").attr("value", newDate);
			}
			
			var type = "";
			if($("input[name='keywordOnum']").val()){
				//alert("dd");
				type += "N";
			}
			if($("input:radio[name='keywordDay']").is(':checked')){
				type += "D";
			}
			if($("input[id='custom']").val()){
				newDate = $("input[id='custom']").val().toString();
				$("input:radio[id='week']").prop("checked", true);
				$("input:radio[id='week']").attr("value", newDate);
				$("input[id='custom']").remove();
				type += "C";
			}
			if($("input[name='keywordPname']").val()){
				type += "P";
			}
			if($("input:radio[name='keywordOme']").is(':checked')){
				type += "O";
			}
			
			str += "<input type='hidden' name='type' value='" + type + "' />";
			
			// 1페이지로 이동하도록
			searchForm.find("input[name='pageNum']").val("1");
			searchForm.append(str);
			searchForm.submit();
			
		});
		
		var checkDay = '<c:out value="${pageMaker.criteria.keywordDay }"/>';
		var checkOme = '<c:out value="${pageMaker.criteria.keywordOme }"/>';
		
		// 즉시 실행 함수
		(function(){
			
			// 기간 라디오 버튼에 체크(검색조건 유지)
			if(checkDay == (date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate())){
				$("input:radio[id='to']").prop('checked', true);
			} else if (checkDay == (date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + (date.getDate() - 1))){
				$("input:radio[id='yester']").prop('checked', true);
			} else if (checkDay == (date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + (date.getDate() - 7))){
				$("input:radio[id='week']").prop('checked', true);
			}
			
			// 결제방식 라디오 버튼에 체크(검색조건 유지)
			if(checkOme == 'card'){
				$("input[value='card']").prop('checked', true);
			} else if(checkOme == 'vBank'){
				$("input[value='vBank']").prop('checked', true);
			}

		})();	// end function
		
		
	});
</script>


<%@ include file="../includes_admin/footer.jsp"%>
