<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- header.jsp에 있는 내용으로 여기서는 주석처리: <meta charset="UTF-8"> -->
<title>ForReport</title>

</head>

<%@ include file="../includes/header.jsp"%>

<!-- 카테고리 분류 부분: Breadcrumb Begin -->
<div class="breadcrumb-area set-bg"
	data-setbg="../resources/img/breadcrumb/breadcrumb-blog.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>
						<c:choose>
							<c:when test="${pageDTO.searchingVO.largeCategory == 0}">Report</c:when>
							<c:when test="${pageDTO.searchingVO.largeCategory == 1}">Paper</c:when>
							<c:otherwise>Report/Paper</c:otherwise>
						</c:choose>
					</h2>
					<div class="breadcrumb__option">
						<a href="/"><i class="fa fa-home"></i> Home</a>
					</div>
					
					<div class="category smallCategory">
						<a href="list.fr?largeCategory=<c:out value="${pageDTO.searchingVO.largeCategory}"/>
									&smallCategory=0
									&inputKeyword=${pageDTO.searchingVO.inputKeyword}">인문사회</a>
						<a href="list.fr?largeCategory=<c:out value="${pageDTO.searchingVO.largeCategory}"/>
									&smallCategory=1
									&inputKeyword=${pageDTO.searchingVO.inputKeyword}">자연공학</a>
						<a href="list.fr?largeCategory=<c:out value="${pageDTO.searchingVO.largeCategory}"/>
									&smallCategory=2
									&inputKeyword=${pageDTO.searchingVO.inputKeyword}">예술체육</a>
						<a href="list.fr?largeCategory=<c:out value="${pageDTO.searchingVO.largeCategory}"/>
									&smallCategory=3
									&inputKeyword=${pageDTO.searchingVO.inputKeyword}">교양</a>
					</div>
					<div class="category largeCategory">
						<a href="list.fr?largeCategory=0
									&smallCategory=999
									&inputKeyword=${pageDTO.searchingVO.inputKeyword}">Report</a>
						<a href="list.fr?largeCategory=1
									&smallCategory=999
									&inputKeyword=${pageDTO.searchingVO.inputKeyword}">Paper</a>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 카테고리 분류 부분: Breadcrumb End -->

<!-- 상품 목록 -->
<section class="blog-section spad4">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<table class="table text-center">
    			<thead>
    				<tr>
    					<th>번호</th>
    					<th>썸네일</th>
    					<th>제목</th>
    					<th>작성자</th>
    					<th>등록일</th>
    					<th>별점</th>
    					<th>댓글 수</th>
    				</tr>
    			</thead>
    			<tbody>
    				<c:forEach items="${productList}" var="list">
						<tr class="pronumList">
							<td style="vertical-align: middle"><c:out value="${list.pronum}"/></td>
							<td style="vertical-align: middle">
								<img src="/product/showThumbnail.fr?pronum=${list.pronum}&index=0"
									 alt="썸네일 없음"
									 style="height:50px">
							</td>
							<td style="vertical-align: middle">
								<a href="view.fr?pronum=${list.pronum}">
									<c:out value="${list.title}"/>
								</a>
							</td>
							<td style="vertical-align: middle">
								<c:choose>
									<c:when test="${empty list.id}">
										탈퇴회원
									</c:when>
									<c:otherwise>
										<c:out value="${list.id}"/>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="vertical-align: middle"><fmt:formatDate value="${list.uploadDate}" pattern="yyyy-MM-dd"/></td>
							<td style="vertical-align: middle" class="avgRate" value='<c:out value="${list.pronum}"/>'>별점</td>
							<td style="vertical-align: middle" class="reviewTotal" value='<c:out value="${list.pronum}"/>'>댓글수</td>
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
			<div class="col-lg-12" style="margin:auto; text-align:center">
				<div class="blog__pagination">
				
					<c:if test="${pageDTO.prev}">
						<a href="?largeCategory=${pageDTO.searchingVO.largeCategory}
								&smallCategory=${pageDTO.searchingVO.smallCategory}
								&pageNum=${pageDTO.startPage-1}
								&inputKeyword=${pageDTO.searchingVO.inputKeyword}">
							<i class="fa fa-long-arrow-left"></i> Pre
						</a>
					</c:if>
					
					<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
						<c:choose>
							<c:when test="${pageDTO.searchingVO.pageNum==num}">
								<a href="?largeCategory=${pageDTO.searchingVO.largeCategory}
										&smallCategory=${pageDTO.searchingVO.smallCategory}
										&pageNum=${num}
										&inputKeyword=${pageDTO.searchingVO.inputKeyword}">
									<strong style="color:#038f88">${num}</strong>
								</a>
							</c:when>
							<c:otherwise>
								<a href="?largeCategory=${pageDTO.searchingVO.largeCategory}
										&smallCategory=${pageDTO.searchingVO.smallCategory}
										&pageNum=${num}
										&inputKeyword=${pageDTO.searchingVO.inputKeyword}">
									${num}
								</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				
					<c:if test="${pageDTO.next}">
						<a href="?largeCategory=${pageDTO.searchingVO.largeCategory}
								&smallCategory=${pageDTO.searchingVO.smallCategory}
								&pageNum=${pageDTO.endPage+1}
								&inputKeyword=${pageDTO.searchingVO.inputKeyword}">
							Next<i class="fa fa-long-arrow-right"></i></a>
					</c:if>
				
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 페이징 처리:Blog Section End -->


<script type="text/javascript" src="/resources/js/review.js"></script>

<script>
	$(document).ready(function(){
				
		// 별점, 댓글수 표시
		//console.log($(".pronumList .avgRate"));
		//console.log($(".pronumList .reviewTotal"));
		
		$(".pronumList .reviewTotal").each(function(index, item){
			var pronum = $(this).attr("value");
			//console.log("pronum: " + pronum);
			reviewService.getTotalAndAvgRate(pronum, function(reviewTotal, avgRate){
				console.log("reviewTotal: " + reviewTotal);
				$(item).html(reviewTotal);
			})
		});
		$(".pronumList .avgRate").each(function(index, item){
			var pronum = $(this).attr("value");
			reviewService.getTotalAndAvgRate(pronum, function(reviewTotal, avgRate){
				console.log("avgRate: " + avgRate);
				$(item).html(avgRate.toFixed(2));
			})
		});
	
		
		/*
			카테고리 상단부 smallCategory 처리
			- 소분류가 선택된 경우: 소분류 버튼 표시X
			- 소분류가 선택되지 않은 경우: 소분류 버튼 표시O
		*/
		
		var smallCategory = "${pageDTO.searchingVO.smallCategory}";
		var largeCategory = "${pageDTO.searchingVO.largeCategory}";
		
		var largeCategoryKor = ""; // 대분류 한글 표시
		var smallCategoryKor = ""; // 소분류 한글 표시
		
		// 대분류 글자 변환
		if(largeCategory==0) {
			largeCategoryKor = "Report"
		} else if(largeCategory== 1) {
			largeCategoryKor = "Paper"
		}
		
		// 소분류 카테고리 번호 확인 후 글자 변환하여 출력
		// 대분류 하이퍼링크 추가
		
		if(smallCategory!=999) { // 소분류 선택 O
			
			$(".smallCategory").hide();
			$(".largeCategory").hide();
					
			if(smallCategory==0){
				smallCategoryKor = "인문사회";
			} else if(smallCategory==1){
				smallCategoryKor = "자연공학";
			} else if(smallCategory==2){
				smallCategoryKor = "예술체육";
			} else if(smallCategory==3){
				smallCategoryKor = "교양";
			}
					
			$(".breadcrumb__option").append("<a href='list.fr?largeCategory="+largeCategory
													+"&smallCategory=999"
													+"&inputKeyword=${pageDTO.searchingVO.inputKeyword}'>"+largeCategoryKor+"</a>"+"<span>"+smallCategoryKor+"</span>");
		
		} else if(smallCategory==999){ // 소분류 선택 X
			
			if(largeCategory!=999){ // 대분류 O, 소분류 X
				$(".largeCategory").hide();
				$(".breadcrumb__option").append("<span>"+largeCategoryKor+"</span>");			
					
			} else if(largeCategory==999){ // 대분류 X 소분류 X
				
				$(".smallCategory").hide();	
				
			}			
		}
	});
</script>


<%@ include file="../includes/footer.jsp"%>