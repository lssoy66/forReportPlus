<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="../includes_admin/header.jsp"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<sec:authorize access="hasRole('admin')">
	<sec:authentication property="principal.username" var="user_id" />
</sec:authorize>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">전체 상품 조회</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- 검색 폼 : 전체보기, 미승인, 승인, 승인거부, 삭제요청 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Search Form</div>
			<!--  /.panel-heading  -->
			<div class="panel-body">
				
				<form id="searchForm" action="/admin/productList.fr" method="get">

					상품 보기
					<select id="approval" name="approval">
						<option value="999">전체보기</option>
						<option value="0">미승인</option>
						<option value="1">승인</option>
						<option value="2">승인거부</option>
						<option value="3">삭제요청</option>
					</select>
					
					<input type="submit" value="search...">
					
<%-- 					<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.criteria.pageNum }"/>' /> --%>
<%-- 					<input type="hidden" name="amount" value='<c:out value="${pageMaker.criteria.amount }"/>' /> --%>
		
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
			<div class="panel-heading">ProductList</div>
			<!--  /.panel-heading  -->
			<div class="panel-body">
				<!-- form:form 태그를 이용해 리스트로 전달 -->
				<form:form modelAttribute="productVO" id="approvalProcess" action="approvalProcess.fr" method="post">		
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>승인 체크</th>
								<th>상품번호</th>
								<td>상품명</td>
								<td>파일명(상품 다운로드)</td>
								<td>판매자ID</td>
								<td>업로드 일자</td>
								<td>승인 여부</td>
							</tr>
						</thead>
						
						<c:forEach items="${productList}" var="product" varStatus="i">
							<tr>
								<c:choose>
									<c:when test="${product.approval==0}">
										<td>
											<form:hidden name="productVOList[${i.index}]" path="productVOList[${i.index}].pronum" value="${product.pronum}"/>
											<form:hidden class="productVOListProdsc" name="productVOList[${i.index}]" path="productVOList[${i.index}].prodsc" value="NoChange"/>
											<form:hidden path="productVOList[${i.index}].id" value="${product.id}"/>
											<form:radiobutton name="productVOList[${i.index}]" path="productVOList[${i.index}].approval" data-value="approval" value="1"/>승인 <!-- 1 -->
											<form:radiobutton name="productVOList[${i.index}]" path="productVOList[${i.index}].approval" data-value="refuse" value="2"/>승인거부<!-- 2 -->
										
<%-- 											<input id="approvalChk${product.pronum}" name="approvalRadio${product.pronum}" type="radio" data-num="${product.pronum}" data-value="approval" value=1>승인  --%>
<%-- 											<input id="approvalChk${product.pronum}" name="approvalRadio${product.pronum}" type="radio" data-num="${product.pronum}" data-value="refuse" value=2>승인거부 --%>
										</td>
									</c:when>
									<c:when test="${product.approval==1}">
										<td>
											<form:hidden path="productVOList[${i.index}].pronum" value="${product.pronum}"/>
											<form:hidden class="productVOListProdsc" name="productVOList[${i.index}]" path="productVOList[${i.index}].prodsc" value="NoChange"/>
											<form:hidden path="productVOList[${i.index}].id" value="${product.id}"/>
											<form:radiobutton path="productVOList[${i.index}].approval" data-value="afterRefuse" value="2"/>승인거부<!-- 2 -->
<%-- 											<input id="approvalChk${product.pronum}" name="refuseRadio${product.pronum}" type="radio" data-num="${product.pronum}" data-value="afterRefuse" value=2>승인거부 --%>
										</td>
									</c:when>
									<c:when test="${product.approval==2}">
										<td>
											<form:hidden path="productVOList[${i.index}].pronum" value="${product.pronum}"/>
											<form:hidden class="productVOListProdsc" name="productVOList[${i.index}]" path="productVOList[${i.index}].prodsc" value="NoChange"/>
											<form:hidden path="productVOList[${i.index}].id" value="${product.id}"/>
											<form:radiobutton  path="productVOList[${i.index}].approval" data-value="reApproval" value="1"/>재승인 <!-- 1 -->
<%-- 											<input id="approvalChk${product.pronum}" name="reApprovalRadio${product.pronum}" type="radio" data-num="${product.pronum}" data-value="reApproval" value=1>재승인 --%>
										</td>
									</c:when>
									<c:when test="${product.approval==3}">
										<td>
											<form:hidden path="productVOList[${i.index}].pronum" value="${product.pronum}"/>
											<form:hidden class="productVOListProdsc" name="productVOList[${i.index}]" path="productVOList[${i.index}].prodsc" value="NoChange"/>
											<form:hidden path="productVOList[${i.index}].id" value="${product.id}"/>
											<form:radiobutton path="productVOList[${i.index}].approval" data-value="delete" value="2"/>삭제승인(승인거부로 처리) <!-- 2 -->
<%-- 											<input id="approvalChk${product.pronum}" name="deleteRadio${product.pronum}" type="radio" data-num="${product.pronum}" data-value="delete" value=2>삭제승인 --%>
										</td>
									</c:when>
								</c:choose>
								<td><c:out value="${product.pronum}" /></td>
								<td><a href="/product/view.fr?pronum=${product.pronum}"><c:out value="${product.title }" /></a></td>				
								<td>
									<a href="download.fr?pronum=${product.pronum}"><c:out value="${product.proname}"/></a>
								</td>
								<td><c:out value="${product.id }" /></td>	
								<td><fmt:formatDate value="${product.uploadDate}" pattern="yyyy-MM-dd"/></td>
								<td>
									<c:choose>
										<c:when test="${product.approval==0}">
											미승인
										</c:when>
										<c:when test="${product.approval==1}">
											승인
										</c:when>
										<c:when test="${product.approval==2}">
											승인거부
										</c:when>
										<c:when test="${product.approval==3}">
											삭제요청
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>
					<button id="approvalProcessBtn" type="submit">승인처리</button>
				</form:form>			
				
				<div class="pull-right">
					<ul class="pagination">
						
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a href="${pageMaker.startPage - 1 }">Previous</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="pagination_button ${pageMaker.searchingVO.pageNum == num ? 'active':''}">
								<a href="${num}">${num}</a></li>
						</c:forEach>

						
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
						</c:if>	
					</ul>
				</div>
				<!-- end Pagination -->
				
				
				<form id="actionForm" action="/admin/productList.fr" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.searchingVO.pageNum }">	
					<input type="hidden" name="amount" value="${pageMaker.searchingVO.amount }">
					<input type="hidden" name="approval" value="${pageMaker.searchingVO.approval}">
				</form>
				
				
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
</div>


<script type="text/javascript">	

$(document).ready(function(){
	
	/////////////////////////////////////////////////////////////////////
	
	/** 시큐리티를 위해 토큰 추가 */
	
	/////////////////////////////////////////////////////////////////////
	
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	console.log("header: " + header);
	console.log("token: " + token);
	
	/////////////////////////////////////////////////////////////////////
	
	/** 페이징처리 */
	
	/////////////////////////////////////////////////////////////////////
	
	var actionForm = $("#actionForm");
		
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log("click");
		actionForm.find("input[name='pageNum']")
					.val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".pagination_button a").on("click", function(e){
		e.preventDefault();
		console.log("click");
		actionForm.find("input[name='pageNum']")
					.val($(this).attr("href"));
		actionForm.submit();
	});
	
	
	/////////////////////////////////////////////////////////////////////
	
	/** 선택된 승인 종류를 새로고침후에 select에서 표시 */	
	
	/////////////////////////////////////////////////////////////////////
	
	var pageApproval = '<c:out value="${approval}"/>'	
	console.log("pageApproval: " + pageApproval);
	
	$("#approval").val(pageApproval).prop("selected", true);
	
	/////////////////////////////////////////////////////////////////////
	
	/** 승인 버튼 눌러서 처리 */
	
	/////////////////////////////////////////////////////////////////////
	
	$("#approvalProcessBtn").on("click",function(e){
		//e.preventDafault();
		e.preventDefault()
		
// 		// 미승인 -> 승인  approvalList에 넣기
		var approval =  $("input:radio[data-value=approval]:checked");
		var approvalCnt = approval.length;
		console.log("미승인 -> 승인 개수: " + approvalCnt);
		approval.each(function(){
			$(this).parent().children(".productVOListProdsc").val("change");
		});
// 		approval.each(function(){
// 			var data = new Object();
// 			data.pronum = $(this).attr("data-num");
// 			data.approval = $(this).val()
// 			console.log("approval.attr('data-num'): " + data.pronum);
// 			console.log("approval.val(): " + data.approval);
// 			approvalList.push(data);
// 		});
		
// 		// 미승인 -> 승인 거부 approvalList에 넣기
		var refuse = $("input:radio[data-value=refuse]:checked");
		var refuseCnt = refuse.length;
		console.log("미승인 -> 승인 거부: " + refuseCnt);
		refuse.each(function(){
			$(this).parent().children(".productVOListProdsc").val("change");
		});
// 		refuse.each(function(){
// 			var data = new Object();
// 			data.pronum = $(this).attr("data-num");
// 			data.approval = $(this).val()
// 			console.log("refuse.attr('data-num'): " + data.pronum);
// 			console.log("refuse.val(): " + data.approval);
// 			approvalList.push(data);
// 		});
		
// 		// 승인 -> 승인거부 approvalList에 넣기
		var afterRefuse = $("input:radio[data-value=afterRefuse]:checked");
		var afterRefuseCnt = afterRefuse.length;
		console.log("승인 -> 승인거부 " + afterRefuseCnt);
		afterRefuse.each(function(){
			$(this).parent().children(".productVOListProdsc").val("change");
		});
// 		afterRefuse.each(function(){
// 			var data = new Object();
// 			data.pronum = $(this).attr("data-num");
// 			data.approval = $(this).val()
// 			console.log("afterRefuse.attr('data-num'): " + data.pronum);
// 			console.log("afterRefuse.val(): " + data.approval);
// 			approvalList.push(data);
// 		});
		
// 		// 승인거부 -> 재승인 approvalList에 넣기
		var reApproval = $("input:radio[data-value=reApproval]:checked");
		var reApprovalCnt = reApproval.length;
		console.log("승인거부 -> 재승인 " + reApprovalCnt);
		reApproval.each(function(){
			$(this).parent().children(".productVOListProdsc").val("change");
		});
// 		reApproval.each(function(){
// 			var data = new Object();
// 			data.pronum = $(this).attr("data-num");
// 			data.approval = $(this).val()
// 			console.log("reApproval.attr('data-num'): " + data.pronum);
// 			console.log("reApproval.val(): " + data.approval);
// 			approvalList.push(data);
// 		});
		 
// 		// 삭제요청 -> 승인(미승인->승인거부와 동일 처리: 즉 숨김처리) approvalList에 넣기
		var deleteToApproval = $("input:radio[data-value=delete]:checked");
		var deleteToApprovalCnt = deleteToApproval.length;
		console.log("삭제요청 -> 승인(미승인->승인거부와 동일 처리: 즉 숨김처리) " + deleteToApprovalCnt);
		deleteToApproval.each(function(){
			$(this).parent().children(".productVOListProdsc").val("change");
		});
// 		deleteToApproval.each(function(){
// 			var data = new Object();
// 			data.pronum = $(this).attr("data-num");
// 			data.approval = $(this).val()
// 			console.log("deleteToApproval.attr('data-num'): " + data.pronum);
// 			console.log("deleteToApproval.val(): " + data.approval);
// 			approvalList.push(data);
// 		});
		
// 		// 테스트
// 		console.log(approvalList[2]);
// 		console.log(approvalList[9]);

		
		var confirmStmt = "";
		
// 		// 선택한 개수를 confirm창에서 표시
		if(approvalCnt!=0){
			confirmStmt += "미승인 -> 승인: " + approvalCnt + "\r\n"; 
		}
		if(refuseCnt!=0) {
			confirmStmt += "미승인 -> 승인거부: " + refuseCnt + "\r\n";
		}
		if(afterRefuseCnt!=0) {
			confirmStmt += "승인 -> 승인거부 : " + afterRefuseCnt + "\r\n";
		}
		if(reApprovalCnt!=0) {
			confirmStmt += "승인거부 -> 재승인: " + reApprovalCnt + "\r\n";
		}
		if(deleteToApprovalCnt!=0) {
			confirmStmt += "삭제요청 -> 승인: " + deleteToApprovalCnt + "\r\n";
		}
				
		var answer = confirm(confirmStmt);
		
		if(answer){ // 확인
			//approvalProcess(approvalMap);
			//console.log('<input type="hidden" name="approval" value="'+approval+'">');
			
			console.log("answer누르고 pageApproval: " + pageApproval);
			$("#approvalProcess").append('<input type="hidden" name="approval" value="'+pageApproval+'">');
			$("#approvalProcess").submit();
			return true;
		} else {
			return false;
		}
	});
		
});
</script>


<%@ include file="../includes_admin/footer.jsp"%>
