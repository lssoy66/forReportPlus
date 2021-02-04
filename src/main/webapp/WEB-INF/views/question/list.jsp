<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- header.jsp에 있는 내용으로 여기서는 주석처리: <meta charset="UTF-8"> -->
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
						<h2>
							 <h2>자주묻는 질문</h2>
						</h2>



					</div>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
</section>
<!-- 상단표시: Listing Section End -->


<!-- 상품 목록 -->
<section class="blog-section spad4">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<table class="table text-center">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="list">
							<tr>
								<td><c:out value="${list.questionnum}" /></td>

								<td><a href="view.fr?questionnum=${list.questionnum}"> <c:out
											value="${list.questiontitle}" />
								</a></td>
								
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>

<!-- 페이징 처리: Blog Section Begin -->
<section class="blog-section spad3">
	<div class="container">
		<div class="row">
			<div class="col-lg-12" >
				<div class="blog__pagination">
					<ul class="pagination">

						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous"><a
								href="${pageMaker.startPage - 1 }">Previous</a></li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }">
							
							<c:choose>
							<c:when test="${pageMaker.criteria.pageNum==num}">
							<li class="paginate_button">
								<a href="${num }">
									<strong style="color:#038f88">${num}</strong>
								</a>
								</li>
							</c:when>
							<c:otherwise>
							<li class="paginate_button">
								<a href="${num }">
									${num}
								</a>
								</li>
							</c:otherwise>
						</c:choose>
						</c:forEach>

						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage + 1 }">Next</a></li>
						</c:if>
					</ul>
				</div>
				<!-- end Pagination -->

				<form id="actionForm" action="/question/list.fr" method="get">
					<input type="hidden" name="pageNum"
						value="${pageMaker.criteria.pageNum }"> <input
						type="hidden" name="amount" value="${pageMaker.criteria.amount }">

					

				</form>
			</div>
		</div>
	</div>
</section>
<!-- 페이징 처리:Blog Section End -->


<script type="text/javascript" src="/resources/js/review.js"></script>

<script>
	$(document).ready(function() {
		
		// 페이징 처리
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log("click");
			actionForm.find("input[name='pageNum']")
						.val($(this).attr("href"));
			actionForm.submit();
		}); 

	});
</script>


<%@ include file="../includes/footer.jsp"%><%@ include file="../includes/footer.jsp"%>