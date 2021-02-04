<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes_admin/header.jsp"%>
<div class="row">
	<div class="col-lg-12">

	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				공지사항 페이지


				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group">
						<label>번호</label> <input class="form-control" name='questionnum'
							value='<c:out value="${question.questionnum}"/>' readonly="readonly" />
					</div>
					<div class="form-group">
						<label>제목</label> <input class="form-control" name='title'
							value='<c:out value="${question.questiontitle}"/>' readonly="readonly" />
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" name='content'
							readonly="readonly"><c:out value="${question.question}" />
					</textarea>
					</div>

					<button data-oper='modify' class="btn btn-default"
						onclick="location.href='/admin/modify2.fr?questionnum=<c:out value="${question.questionnum}"/>'">수정</button>
					<button data-oper='list' class="btn btn-info"
						onclick="location.href='/admin/list2.fr'">리스트</button>

					
				</div>
			</div>
		</div>
	</div>

	


<script type="text/javascript">
		$(document).ready(function(){
			
			var operForm = $("#operForm");
			
			$("button[data-oper='modify']").on("click", function(e){
				operForm.attr("action", "/admin/modify2.fr").submit();
			});
			
			$("button[data-oper='list']").on("click", function(e){
				operForm.find("#noticenum").remove();
				operForm.attr("action","/admin/list2.fr")
				operForm.submit();
			});
		});
	</script>

<%@ include file="../includes_admin/footer.jsp"%>