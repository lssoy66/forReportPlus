<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes_admin/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
<!-- 	/.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
<div class="col-lg-12">
	<div class="panel panel-default">
	<div class="panel-heading">Qeustion List Page
		<form action="/admin/register2.fr" method="get" style="float:right" class="btn btn-xs pull-right">		
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="submit" value="Register" id="regBtn"> 			
		</form> 
		</div>		
<!-- 		/.panel-heading -->
		<div class="panel-body">	
			<table class="table table-striped table-bordered table-hover">			
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>				
					</tr>
				</thead>
				
					<c:forEach items="${list2}" var="list">
							<tr>
								<td><c:out value="${list.questionnum}" /></td>

								<td><a href="get2.fr?questionnum=${list.questionnum}"> <c:out
											value="${list.questiontitle}" />
								</a></td>								
							</tr>
						</c:forEach>
			</table>
			
			
<!-- 		p.340 -->
<!-- 		p.343 -->
			<div class='row'>
				<div class="col-lg-12">
					<form id='searchForm' action="/admin/list2.fr" method='get'>
						<select name='type'>
							<option value=""
								<c:out value="${pageMaker.adminCriteria.type == null?'selected':'' }"/>>--</option>
							<option value="T"
								<c:out value="${pageMaker.adminCriteria.type eq 'T'?'selected':'' }"/>>제목</option>
							<option value="C"
								<c:out value="${pageMaker.adminCriteria.type eq 'C'?'selected':'' }"/>>내용</option>
						</select>
						<input type='text' name='keyword' value='<c:out value="${pageMaker.adminCriteria.keyword }"/>'/>
						<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.adminCriteria.pageNum }"/>'/>
						<input type='hidden' name='amount' value='<c:out value="${pageMaker.adminCriteria.amount }"/>'/>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						<button class='btn btn-default'>Search</button>
					</form>
				</div>
			</div>
			
			
<!-- 			p.308 -->
<!-- 			p.310 -->
				<div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage -1 }">Previous</a>
							</li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.adminCriteria.pageNum == num ? "active":"" }">
								<a href="${num }">${num }</a>
							</li>
						</c:forEach>
						
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage +1 }">Next</a>
							</li>
						</c:if>
					</ul>
				</div>
<!-- 			end Pagination -->

<!-- 			p.311 -->
<!-- 			p.344 -->
<!-- 				<form id='actionForm' action="/admin/list1.fr" method='get'> -->
<%-- 					<input type='hidden' name='pageNum' value='${pageMaker.criteria.pageNum }'> --%>
<%-- 					<input type='hidden' name='amount' value='${pageMaker.criteria.amount }'> --%>
<%-- 					<input type='hidden' name='type' value='<c:out value="${pageMaker.criteria.type }"/>'> --%>
<%-- 					<input type='hidden' name='keyword' value='<c:out value="${pageMaker.criteria.keyword }"/>'> --%>
<!-- 				</form> -->
			
				<form id='actionForm' action="/admin/list1.fr" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.adminCriteria.pageNum }'>
					<input type='hidden' name='amount' value='${pageMaker.adminCriteria.amount }'>
					<input type='hidden' name='type' value='${pageMaker.adminCriteria.type }'>
					<input type='hidden' name='keyword' value='<c:out value="${pageMaker.adminCriteria.keyword }"/>'>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
			
<!-- 			Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" arial-labelledby="myModalLabel" arial-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" arial-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
<!-- 		/.modal-content -->
	</div>
<!-- 	/.modal-dialog -->
</div>
<!-- /.modal		 -->

		</div>
<!-- 		end panel-body -->
	</div>
<!-- 	end panel -->
</div>
</div>
<!-- /.row -->


<!-- p.246 -->
<script type="text/javascript">
	$(document).ready(function(){
		
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		function checkModal(result){
			if(result === '' || history.state){
				return;
			}
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글 "+parseInt(result)+" 번이 등록되었습니다.");
			}
			$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function(){
			self.location="/admin/register2.fr";
		});
		
// 		p.312
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			console.log($(this).attr("href"));

			actionForm.submit();
		});
		
		$(".move").on("click",function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='noticenum' value='"	+ $(this).attr("href")	+ "'>");
			actionForm.attr("action","/admin/get2.fr");
			actionForm.submit();
});
		
//	 	p.342
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








