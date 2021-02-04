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
		<h1 class="page-header">전체 회원 조회</h1>
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
				
				<form id="searchForm" action="/admin/userList.fr" method="get">

					회원 보기
					<select name="type">
						<option value=""
						<c:out value="${pageMaker.searchingVO.type == null?'selected':'' }"/>>--</option>
						<option value="A">전체보기</option>
						<option value="I" <c:out value="${pageMaker.searchingVO.type eq 'I'?'selected':'' }"/>>아이디</option>
						<option value="N" <c:out value="${pageMaker.searchingVO.type eq 'N'?'selected':'' }"/>>이름</option>
						<option value="P" <c:out value="${pageMaker.searchingVO.type eq 'P'?'selected':'' }"/>>연락처</option>
						<option value="E" <c:out value="${pageMaker.searchingVO.type eq 'E'?'selected':'' }"/>>이메일</option>
						<option value="G" <c:out value="${pageMaker.searchingVO.type eq 'G'?'selected':'' }"/>>등급</option>
						<option value="T" <c:out value="${pageMaker.searchingVO.type eq 'T'?'selected':'' }"/>>활성화</option>
					</select>
					<input type='text' name='keyword' value='<c:out value="${pageMaker.searchingVO.keyword }"/>'/>
					<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.searchingVO.pageNum }"/>'/>
					<input type='hidden' name='amount' value='<c:out value="${pageMaker.searchingVO.amount }"/>'/>
					<input type="submit" value="search...">
						
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
			<div class="panel-heading">User List</div>
			<!--  /.panel-heading  -->
			<div class="panel-body">
				<!-- form:form 태그를 이용해 리스트로 전달 -->
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>아이디</th>
								<th>비밀번호</th>
								<td>이름</td>
								<td>연락처</td>
								<td>이메일</td>
								<td>등급</td>
								<td>활성화 여부</td>
							</tr>
						</thead>
						
						<c:forEach items="${userList}" var="user" varStatus="i">
							<tr>
								<td><c:out value="${user.id}"/></td>
								<td><c:out value="${user.password}"/></td>
								<td><c:out value="${user.name}"/></td>
								<td><c:out value="${user.phone}"/></td>
								<td><c:out value="${user.email}"/></td>
								<td><c:out value="${user.grade}"/></td>
								<td><c:out value="${user.enabled}"/></td>
							</tr>
						</c:forEach>
					</table>
		
				
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
				
				
				<form id="actionForm" action="/admin/userList.fr" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.searchingVO.pageNum }">	
					<input type="hidden" name="amount" value="${pageMaker.searchingVO.amount }">
					<input type='hidden' name='type' value='${pageMaker.searchingVO.type }'>
					<input type='hidden' name='keyword' value='<c:out value="${pageMaker.searchingVO.keyword }"/>'>
				</form>
				
				
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
</div>


<script type="text/javascript">	

$(document).ready(function(){
	
	
	/** 시큐리티를 위해 토큰 추가 */	
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	
	console.log("header: " + header);
	console.log("token: " + token);
	
	
	/** 페이징처리 */	
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
	
	// 검색 관련
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
				
		e.preventDefault();
		searchForm.submit();
	});

		
});
</script>


<%@ include file="../includes_admin/footer.jsp"%>
