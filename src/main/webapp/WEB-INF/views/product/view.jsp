<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
</sec:authorize>

<!DOCTYPE html>
<html>
<head>

<%

Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

%>

<!-- AJAX를 사용하기 위해 review.js 가져오기 -->
<script type="text/javascript" src="/resources/js/review.js"></script>

<title>ForReport</title>

<style>
.bigPictureWrapper {
		display: none;
		justify-content: center;
		align-items: center;
		background-color: gray;
		z-index: 100;
		background: gray;
		padding: 20px;
	}
	
/*가운데 정렬*/
.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>

</head>

<%@ include file="../includes/header.jsp"%>

<!-- 상단표시: Listing Section Begin -->
<section class="listing-hero set-bg" data-setbg="/resources/img/listing/details/listing-hero.jpg">
	<div class="container">
    	<div class="row">
        	<div class="col-lg-8">
            	<div class="listing__hero__option">
                	<div class="listing__hero__icon">
                    	<img src="/resources/img/listing/details/ld-icon.png" alt="">
                    </div>
                    <div class="listing__hero__text">
                    	<h2><c:out value="${productVO.title}"/></h2>
                    	<h3>문서명: <c:out value="${productVO.proname}"/></h3>
                        <div class="listing__hero__widget">
                        	<!-- 평균 별점 -->
                        	<div class="listing__hero__widget__rating">
                        		<span> 별점:  </span>
                        		<span class="icon_star"></span>
                                <span class="icon_star"></span>
                                <span class="icon_star"></span>
                                <span class="icon_star"></span>
                                <span class="icon_star-half_alt"></span>
                                
                            </div>
                            <p></p>
                            <div>
	                            <div> 작성자: <c:out value="${productVO.id}"/> &nbsp;</div>
	                            <div> 작성자 등급: <c:out value="${writerGrade}"/> </div><br>
	                            <div> 가격: <c:out value="${productVO.price}"/> &nbsp;</div>
	                            <div> 게시일 <fmt:formatDate value="${productVO.uploadDate}" pattern="yyyy-MM-dd"/></div>                      
                            </div> 
                        </div>
                        <p class="showCategory">
                        	<span class="showLargeCategory">
                        		<c:choose>
                        			<c:when test="${productVO.largeCa == 0}">
                        				<a href="list.fr?largeCategory=0&smallCategory=999">Report</a></c:when>
                        			<c:when test="${productVO.largeCa == 1}">
                        				<a href="list.fr?largeCategory=1&smallCategory=999">Paper</a></c:when>
                        			<c:otherwise>Report/Paper</c:otherwise>
                        		</c:choose>
                        	</span>
                        	> 
                        	<span class="showSmallCategroy">
                        		<c:choose>
                        			<c:when test="${productVO.largeCa == 0}">
                        				<c:choose>        			
		                        			<c:when test="${productVO.smallCa==0}">
		                        				<a href="list.fr?largeCategory=0&smallCategory=0">인문사회</a></c:when>
		                        			<c:when test="${productVO.smallCa==1}">
		                        				<a href="list.fr?largeCategory=0&smallCategory=1">자연공학</a></c:when>
		                        			<c:when test="${productVO.smallCa==2}">
		                        				<a href="list.fr?largeCategory=0&smallCategory=2">예술체육</a></c:when>
		                        			<c:when test="${productVO.smallCa==3}">
		                        				<a href="list.fr?largeCategory=0&smallCategory=3">교양</a></c:when>
                        				</c:choose>
                        			</c:when>
                        			<c:when test="${productVO.largeCa == 1}">
                        				<c:choose>
		                        			<c:when test="${productVO.smallCa==0}">
		                        				<a href="list.fr?largeCategory=1&smallCategory=0">인문사회</a></c:when>
		                        			<c:when test="${productVO.smallCa==1}">
		                        				<a href="list.fr?largeCategory=1&smallCategory=1">자연공학</a></c:when>
		                        			<c:when test="${productVO.smallCa==2}">
		                        				<a href="list.fr?largeCategory=1&smallCategory=2">예술체육</a></c:when>
		                        			<c:when test="${productVO.smallCa==3}">
		                        				<a href="list.fr?largeCategory=1&smallCategory=3">교양</a></c:when>
	                        			</c:choose>
                        			</c:when>
                        		 </c:choose>
                        	</span>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
            	
            	<div class="listing__hero__btns">
	            	<!-- 승인된 제품만 장바구니 버튼 보여준다. -->
	            	<!-- 로그인 한 사용자에게만 장바구니 버튼 노출  -->
	            	<c:choose>            		
	            		<c:when test="${productVO.approval==1 && productVO.id ne '탈퇴회원'}">
	            			<c:if test="${user_id != null }">
	            				<a href="${productVO.proname}" class="primary-btn cartAdd" style="background-color:#038f88">
	            					<i class="fa fa-bookmark"></i> 장바구니</a>
			              	</c:if>
			              </c:when>
	            	</c:choose>
	            	<!-- Writer인 경우 삭제 요청 버튼을 누를 수 있다.(writer에게만 보임) -->
	            	<c:choose>            		
	            		<c:when test="${user_id==productVO.id and productVO.approval!=3}">
	            			<a href="#" class="primary-btn share-btn deleteRequest"><i class="fa fa-bookmark"></i> 삭제 요청</a>
	            		</c:when>
	            	</c:choose>
            	 </div>
            	
            </div>
            
        </div>
    </div>
</section>
<!-- 상단표시: Listing Section End -->

<!-- 상품 정보: 상품 썸네일, 상품 설명 -->
<!-- 별점 & 댓글 -->
<!-- Listing Details Section Begin -->
<section class="listing-details spad">
	<div class="container">
		<div class="row">
        	<div class="col-lg-12">
            	<div class="listing__details__text">
                	<div class="listing__details__about">
                    	<h4>제품 설명</h4>
                        <p><c:out value="${productVO.prodsc}"></c:out></p>
					</div>
                    <div class="listing__details__gallery">
                    	<h4>콘텐츠 미리보기</h4>
                    	<!-- 만들어둔 썸네일 미리보기: 일정 시간 지나면 사진이 이동한다. -->
                    	<!-- 사진을 클릭하면 크게 보여주는 기능 추가 예정 -->
                    	
                    	<div class="thumbnailShow" style="text-align:center; background-color: gray; padding: 10px">
                    		썸네일을 보여줍니다.
                    	</div>
                    	<div class="bigPictureWrapper">
                    		<div class="bigPicture">
                    		</div>
                    	</div>
					</div>
					
                    <div class="listing__details__rating">
                    	<h4>평균 별점</h4>
                        <div class="listing__details__rating__overall">
                        	<h2>0점</h2>
                        	<!-- 여기에 찐 평균 별점 표시 -->
                            <div class="listing__details__rating__star">
                            	<span class="icon_star"></span>
                                <span class="icon_star"></span>
                                <span class="icon_star"></span>
                                <span class="icon_star"></span>
                                <span class="icon_star"></span>
                           	</div>
                            <span>0명</span>
                       	</div>
                       	
                       	
                        <div class="listing__details__rating__bar">
                        	<div class="listing__details__rating__bar__item">
                            	<span>1점</span>
                                <div id="bar1" class="barfiller">
                                	<span class="fill" data-percentage="0" style="background:rgb(240,50,80); width:0%; transition: width 1s ease-in-out 0s;"></span>
                                </div>
                                <span class="right">00명</span>
                           	</div>
                            <div class="listing__details__rating__bar__item">
                            	<span>2점</span>
                               	<div id="bar2" class="barfiller">
                                	<span class="fill" data-percentage="0" style="background:rgb(240,50,80); width:0%; transition: width 1s ease-in-out 0s;"></span>
                                </div>
                                <span class="right">00명</span>
                            </div>
                            <div class="listing__details__rating__bar__item">
                                <span>3점</span>
                                <div id="bar3" class="barfiller">
                                	<span class="fill" data-percentage="0" style="background:rgb(240,50,80); width:0%; transition: width 1s ease-in-out 0s;"></span>
                                </div>
                                <span class="right">00명</span>
                            </div>
                            <div class="listing__details__rating__bar__item">
                                <span>4점</span>
                                <div id="bar4" class="barfiller">
                                	<span class="fill" data-percentage="0" style="background:rgb(240,50,80); width:0%; transition: width 1s ease-in-out 0s;"></span>
                                </div>
                                <span class="right">00명</span>
                            </div>
                            <div class="listing__details__rating__bar__item">
                                <span>5점</span>
                                <div id="bar5" class="barfiller">
                                	<span class="fill" data-percentage="0" style="background:rgb(240,50,80); width:0%; transition: width 1s ease-in-out 0s;"></span>
                                </div>
                                <span class="right">00명</span>
                            </div>
                        </div>
					 
                    </div>
                    
                   
                    <div class="listing__details__comment">
                        <h4>리뷰</h4>
                        <!-- 리뷰 리스트 처리 -->                   
                      	<div class="reviewListDiv"></div>
                      	 <!-- 리뷰 페이징 처리 --> 
                      	<div class="blog__pagination"></div> 
                      	<!-- /리뷰 페이징 처리 -->   
                      	                          
                    </div>
                    <div class="listing__details__review">
                        <h4>리뷰 및 별점 작성</h4>
                        <form action="/review/new" id="reviewForm" method="post">
                            <div class="listing__details__comment__item__rating">
	                        	별점
	                        	<i class="fa fa-star" name="checked"></i>
	                            <i class="fa fa-star" name="unchecked"></i>
	                            <i class="fa fa-star" name="unchecked"></i>
	                            <i class="fa fa-star" name="unchecked"></i>
	                            <i class="fa fa-star" name="unchecked"></i>
	                        </div>
                            <textarea placeholder="Review" name="review" class="review"></textarea>
                            <button type="submit" class="site-btn" style="background-color:#038f88">리뷰 등록</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Listing Details Section End -->


<!-- 자바스크립트 효과 -->
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
	
	/** 별점 효과 */
	
	/////////////////////////////////////////////////////////////////////
		
	/* 별점효과 1. 회색 별로 변경*/
	var grayStar = $("#reviewForm .listing__details__comment__item__rating i");
	
	grayStar.each(function(index, item){
		if($(item).attr("name").toString()==="unchecked"){
			$(this).css("color", "gray");
		} else {
			$(this).css("color", "orange");
		}
	});
	
	
	/* 별점효과 2.선택하면 주황색 별로 변경, 만약 이미 선택된 주황색 별을 선택한 경우 회색으로 변경*/
	grayStar.click(function(){
	
		if($(this).attr("name").toString()==="unchecked"){
		
			console.log("gray -> orange");
		
			$(this).prevAll("i").css("color", "orange");
			$(this).css("color", "orange");
		
			$(this).attr("name", 'checked');
			$(this).prevAll("i").attr("name", 'checked');
		
		} else if($(this).attr("name").toString()==="checked"){
		
			console.log("orange->gray");
		
			$(this).nextAll("i").css("color", "gray");
			$(this).nextAll("i").attr("name", 'unchecked');
		}
	});
	
	/////////////////////////////////////////////////////////////////////
	
	/** 별점효과 끝*/
	
	/////////////////////////////////////////////////////////////////////
	
	
	/////////////////////////////////////////////////////////////////////
	
	/** AJAX로 리뷰 가져오기, 등록, 삭제, 페이징처리 */
	/** 리뷰 가져오기 + 페이징 처리: showReviewList */
	/** 리뷰 등록: submit + showReviewList(-1) */
	/** 리뷰 삭제:  */
	
	/////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////
	
	/** 리뷰 처리를 위한 변수들 사전 선언 및 작성한 함수 호출 */
	
	/////////////////////////////////////////////////////////////////////
	
	// 현재 페이지에 접속한 유저의 아이디
	var reviewerId = "${user_id }";
	// 게시글 번호 가져오기(-> 해당 게시글에 맞는 리뷰를 처리할 때 사용)
	var pronum = '<c:out value="${productVO.pronum}"/>';
	// 페이징 처리 입력할 하단부
	var reviewPageFooter = $(".blog__pagination");
	
	
	// session에 저장된 값을 확인해서 리뷰등록으로 인한 새로고침을 한 경우 마지막 페이지 출력, 그 외는 1페이지 출력
	if(sessionStorage.getItem("reviewAddReload")){
		sessionStorage.clear();
		showReviewList(-1);
	} else {
		showReviewList(1);
	}
	
	
			/////////////////////////////////////////////////////////////////////
			
			/** 리뷰 처리를 위한 함수 선언 */
			
			/////////////////////////////////////////////////////////////////////
			
			//리뷰 페이지에 맞는 리뷰 보여주기
			function showReviewList(pageNum){
				
				
				console.log("리뷰 페이지에 맞는 리뷰 보여주기 - showReviewList");
				
				// 리뷰 리스트가 들어갈 곳
				var reviewListDiv = $(".reviewListDiv");
				// 실제로 넣을 리뷰 내용
				var reviewStr = "";
				
				console.log("getReviewList 외부 pageNum: " + pageNum);
				
				
				
				reviewService.getReviewList({pronum:pronum, pageNum: pageNum||1},
						function(reviewTotal, reviewList, avgRate, reviewCriteria, rateOne, rateTwo, rateThree, rateFour, rateFive){
					
					console.log("getReviewList 내부 pageNum: " + pageNum);
					
					if(pageNum == -1) {
						
						if(reviewTotal == 0){
							
							console.log("pageNum == -1 reviewTotal == 0");
							
							pageNum = 1;
							showReviewList(1);
							return false;
							
						} else {
							
							console.log("pageNum == -1 reviewTotal != 0");
							
							pageNum = Math.ceil(reviewTotal/10.0); // 마지막 페이지 번호
							showReviewList(pageNum); // 마지막 페이지 번호를 보여달라고 재귀함수로 처리
							return false;
							
						}
					}
				
			///////////////////////////////////////////////////////////////
			
			/* 리뷰 상단부 - 별점 준 사람, 별점 별 사람 수, 평균 별점 표시*/
			
			///////////////////////////////////////////////////////////////
			
			// 얻어온ReviewPageDTO값을 이용해서 전체 리뷰 개수 표시하기
			console.log(".listing__details__comment h4에 넣을 reviewTotal" + reviewTotal);
			$(".listing__details__comment h4").html('리뷰('+reviewTotal+')');
			
			// 얻어온ReviewPageDTO값을 이용해서 평균 별점 표시하기(소수점 둘째자리)
			console.log("평균 별점: " + avgRate);
			avgRate = avgRate.toFixed(2);
			console.log("평균 별점 반올림: " + avgRate);
			
			// 평균 별점 표시를 위한 변수
			var avgRateShowStr = ''; 
			var star_text = '<span> 별점  &nbsp;</span>';
			// 평균만큼 반복해서 별점 표시
			for(var i = 1; i<=avgRate; i++){
				avgRateShowStr += "<span class='icon_star'>&nbsp;</span>";
			}
			
			console.log(".listing__details__rating__star 위의 reviewTotal: " + reviewTotal);
			
			// 평균 별점 표시
			$(".listing__hero__widget__rating").html(star_text + avgRateShowStr);	
			$(".listing__details__rating__overall h2").html(avgRate||0);
			$(".listing__details__rating__star").html(avgRateShowStr||0);
			$(".listing__details__rating__star").siblings("span").html("총 " +reviewTotal +"명"||0+"명");
			
			/*점수 별 사람들 표시*/			
			var ratePerPerson = "";
			

			ratePerPerson += '<div class="listing__details__rating__bar__item">' +
							 '<span>5점</span>' +
							 '<div id="bar1" class="barfiller">' +
							 	'<span class="fill" data-percentage="'+Math.ceil(rateFive/reviewTotal*100)+'"'+
							 		'style="background:rgb(240,50,80); width:'+Math.ceil(rateFive/reviewTotal*100)+'%; transition: width 1s ease-in-out 0s;"></span>' +
							 '</div>' + 
							 ' <span class="right">'+rateFive+'명</span>';
							 
			ratePerPerson += '<div class="listing__details__rating__bar__item">' +
							 '<span>4점</span>' +
							 '<div id="bar4" class="barfiller">' +
							 	'<span class="fill" data-percentage="'+Math.ceil(rateFour/reviewTotal*100)+'"'+
							 		'style="background:rgb(240,50,80); width:'+Math.ceil(rateFour/reviewTotal*100)+'%; transition: width 1s ease-in-out 0s;"></span>' +
							 '</div>' + 
							 ' <span class="right">'+rateFour+'명</span>';
							 
			ratePerPerson += '<div class="listing__details__rating__bar__item">' +
							 '<span>3점</span>' +
							 '<div id="bar3" class="barfiller">' +
							 	'<span class="fill" data-percentage="'+Math.ceil(rateThree/reviewTotal*100)+'"'+
							 		'style="background:rgb(240,50,80); width:'+Math.ceil(rateThree/reviewTotal*100)+'%; transition: width 1s ease-in-out 0s;"></span>' +
							 '</div>' + 
							 ' <span class="right">'+rateThree+'명</span>';
							 
			ratePerPerson += '<div class="listing__details__rating__bar__item">' +
							 '<span>2점</span>' +
							 '<div id="bar2" class="barfiller">' +
							 	'<span class="fill" data-percentage="'+Math.ceil(rateTwo/reviewTotal*100)+'"'+
							 		'style="background:rgb(240,50,80); width:'+Math.ceil(rateTwo/reviewTotal*100)+'%; transition: width 1s ease-in-out 0s;"></span>' +
							 '</div>' + 
							 ' <span class="right">'+rateTwo+'명</span>';
							 
			ratePerPerson += '<div class="listing__details__rating__bar__item">' +
							 '<span>1점</span>' +
							 '<div id="bar1" class="barfiller">' +
							 	'<span class="fill" data-percentage="'+Math.ceil(rateOne/reviewTotal*100)+'"'+
							 		'style="background:rgb(240,50,80); width:'+Math.ceil(rateOne/reviewTotal*100)+'%; transition: width 1s ease-in-out 0s;"></span>' +
							 '</div>' + 
							 ' <span class="right">'+rateOne+'명</span>';
			
			
			// 각 점수 별 준 사람들 수 표시
			$(".listing__details__rating__bar").html(ratePerPerson);			

			
			///////////////////////////////////////////////////////////////
			
			/* 리뷰 중간부 - 리뷰 리스트 상세보기*/
			
			///////////////////////////////////////////////////////////////
						
			//해당 게시글에 댓글이 없는 경우 -> 그냥 돌아간다(만약 앞에 남은 페이지가 있을 경우 남은 페이지의 가장 마지막 페이지로 돌아간다.)
			if((reviewList==null || reviewList.length == 0)&&pageNum > 1) {
				
				showReviewList(pageNum-1);				
				return;
			}
			
						
			// 댓글이 있는 경우 게시글 출력하기
			for(var i = 0, len=reviewList.length||0; i<len; i++){
				
				var rate_star = "";
				var rateCnt = reviewList[i].rate;
								
				for(var j = 0; j < rateCnt; j++){
		
					rate_star += '<i class="fa fa-star" style="color: orange"></i>';
					
				}
			
				reviewStr += '<div class="listing__details__comment__item">';
				reviewStr +=	'<div class="listing__details__comment__item__rating">';
				reviewStr +=		'<div class="rate_star">';
				reviewStr +=			rate_star;
				reviewStr +=	'</div>';
				reviewStr +=	'</div>';
				reviewStr +=	'<span>'+reviewService.displayTime(reviewList[i].reviewDate)+'</span>';
				reviewStr +=	'<div class="listing__details__comment__item__text">';
				reviewStr +=		'<h5>'+reviewList[i].id+'</h5>';
				reviewStr +=		'<p>'+reviewList[i].review+'</p>';
				reviewStr +=		'<a href="#"><span data-reviewNum="'+reviewList[i].reviewNum+'" class="btn_removeReview" style="border: 2px ridge pink"><i class="fa fa-hand-o-right"></i> 삭제</span></a>';
				reviewStr +=	'</div>';
				reviewStr +=  '</div>';
			} // ..END:: 바깥 for문
						
			// 리뷰 삽입하기
			reviewListDiv.html(reviewStr);
					
			console.log("remove위 reviewTotal: " + reviewTotal);
			//remove(pageNum, reviewTotal); // append가 되어 값이 처리되는 곳에서 이벤트를 넣어주어야 한다.(remove 함수를 외부에서 만든 후 끌어다 씀)
			
			reviewPageFooter.on("click", "a", function(e){
					
					e.preventDefault();
					
					var targetPageNum = $(this).attr("href");
					
					pageNum = targetPageNum;
					
					showReviewList(pageNum);
					
			}); // --END: reviewPageFooter
			
			///////////////////////////////////////////////////////////////
			
			/* 리뷰 하단부 - 페이징 처리*/
			
			///////////////////////////////////////////////////////////////
			
			
			showReviewPage(reviewTotal); // 페이징 처리
			
			/** 삭제 구현*/
			$(".listing__details__comment__item__text a").on("click", function(e){
				
				console.log("remove");
				
				console.log(reviewTotal);
				
				e.preventDefault();
				
				// 작성자 여부 확인
				
				console.log("id:" + reviewerId);
				console.log("pronum: " + pronum);
				
				var reviewNum = $(this).children().attr("data-reviewNum");
				var reviewPageNum = pageNum;
				
				$.ajax({
					url : '/review/deleteData.fr',
					beforeSend : function(xhr){
						xhr.setRequestHeader(header, token);
					},
					data : {"id":reviewerId, "pronum":pronum, "reviewnum":reviewNum},
					type : 'POST',
					dataType: 'text',
					success : function(result){
						
						console.log("ajax내부 result: " + result);
						
						if(result==="fail"){ // 댓글 작성자와 불일치하는 경우
							
							alert("댓글 작성자만 댓글을 삭제할 수 있습니다.");
							return false;
													
						} else { // 댓글 작성자와 일치하는 경우
														
							//var reviewNum = $(this).children().attr("data-reviewNum");
							//var reviewPageNum = pageNum;
										
							console.log(typeof(reviewNum));
							console.log("reviewNum: " + reviewNum);
							
							reviewNum = Number(reviewNum);
							console.log(typeof(reviewNum));
							console.log("reviewNum: " + reviewNum);
							
							reviewService.remove(reviewNum*1, header, token, function(result){
								alert(result);
								
								console.log("remove 호출 후 reviewTotal"+reviewTotal);
								
								console.log("showReviewList(pageNum): "+ showReviewList(pageNum));
								showReviewList(pageNum);
								
							}, function(){
								alert("ajax delete 실패");
							});
							
						} // else 끝
					} // ajax내부 function 끝
				}); // ajax
				
				
							
			});  
			
			
			
		}); /* -- END: showReviewList 자리*/
		

	// 댓글 하단부 페이징 처리
	function showReviewPage(reviewTotal){
		
		console.log("댓글 페이징 처리 - showReviewPage")
		console.log("showReviewPage_reviewTotal" + reviewTotal);
		
		// 현재 리뷰 페이지가 속한 페이지 리스트의 마지막 번호
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		// 현재 리뷰 페이지가 속한 페이지 리스트의 첫번째 번호
		var startNum = endNum - 9;
		
		// 시작페이지 번호가 1보다 큰 경우 prev버튼 넣을 것
		var prev = startNum > 1; 
		var next = false;
		
		// 마지막 페이지가 전체 페이지 개수보다 많은 경우 조정
		if(endNum * 10 > reviewTotal){
			endNum = Math.ceil(reviewTotal/10.0); 
		}
		
		// 더 뒤로 갈 페이지가 남은 경우 next 버튼 넣기
		if(endNum * 10 < reviewTotal){
			next = true; 
		}
		
		// 페이징 처리를 위해 넣을 변수
		var str = "";
		
		// prev가 true인 경우 prev버튼 넣기
		if(prev){
			str += '<a href="'+(startNum-1)+'"><i class="fa fa-long-arrow-left"></i> Pre</a>';
		}
		
		// 일반 페이지 번호 입력(현재 페이지는 활성화 표시)
		for(var i = startNum; i<= endNum; i++){
			
			//var actvie = pageNum == i ? "<strong>"+i+"</strong":i; // 현재 페이지의 경우 활성화 표시
			
			if(pageNum == i) {
				str += '<a href="'+i+'"><strong style="color:red">'+i+'</strong></a>';
			} else {
				str += '<a href="'+i+'">'+i+'</a>';
			}
		}
		
		// next가 true인 경우 prev버튼 넣기
		if(next){
			str += '<a href="'+(endNum+1)+'">Next<i class="fa fa-long-arrow-right"></i></a>';
		}
		
		// 하단부 페이지 버튼 자리에 페이지 html 넣기
		reviewPageFooter.html(str);
		
		}	 // ..END: getReviewList
		
	} // ..END: showReviewPage
	

	/** AJAX를 이용해서 리뷰 등록하기 */	
	/*구매 여부 확인 필요:: #reviewForm button 클릭 이벤트*/
	
	$("#reviewForm button").on("click", function(e){
		
		e.preventDefault();
		
		// 리뷰를 작성하지 않은 경우 별점 등록 불가
		if(!$(".review").val()){
			alert("onClick:: 리뷰를 입력해주세요.");
			return false;
		}
		
		//var reviewerId = "${user_id }";
		console.log("reviewerId: " + reviewerId);
		console.log("pronum: " + pronum);
		
		// 비회원은 댓글 작성 불가
		if(reviewerId == ""){
			alert("구매한 회원만 댓글을 작성할 수 있습니다.");
			return false;
		}
		
		// ajax는 비동기식으로 2개를 병렬로 사용할 경우 원하는 값을 못얻는 경우 발생 >> ajax안에 ajax를 넣어서 해결
		// 로그인 정보 확인 -> 구매 여부 확인
		$.ajax({
			url : '/review/orderData.fr',
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			data : {"id":reviewerId, "pronum":pronum},
			type : 'POST',
			dataType: 'text',
			success : function(result){
				
				if(result==="fail"){ // 구매하지 않은 회원인 경우
					
					alert("구매자만 댓글을 작성할 수 있습니다.");
					console.log("failResult: " + result);
					booleanChk = false;
					console.log("failResult__booleanChk: " + booleanChk);
					
				} else { // 구매한 회원인 경우
					
					console.log("successResult: " + result);
				
					// 체크된 별의 개수
					var ratingCnt = 0; 
					$("i[name=checked]").each(function(i){
						ratingCnt += 1;
					});
					
					console.log("ratingCnt: " + ratingCnt);
					
					//var id = reviewerId; 
					var review = $(".review");
					
					var addReview = {
							pronum: ${productVO.pronum},
							id: reviewerId,
							review: review.val(),
							rate: ratingCnt
					};
					
					// 댓글 등록 시큐리티 토큰 헤더 추가
					reviewService.add(addReview, header, token, function(result){
						alert(result);
					});
										
					// 댓글 등록 후 리뷰, 별점 리셋
					review.val("");
					$("i[name=checked]").css("color", "gray");
					$("i[name=checked]:nth-child(1)").css("color", "orange");
					$("i[name=checked]").nextAll("i").attr("name", 'unchecked');
					$("i[name=checked]:nth-child(1)").nextAll("i").attr("name", 'unchecked');
										
					// 세션에 값을 넣어 해당 세션 값이 있는 경우는 마지막 페이지를 볼 수 있도록 처리
					sessionStorage.setItem("reviewAddReload",true);					
					
					// 새로고침하여 결과 확인
					window.location.reload();
				}
			}
		});
		
	}); // /* -- END:: 구매 여부 확인 필요:: #reviewForm button 클릭 이벤트*/


	///////////////////////////////////////////////////////////////
	
	/* 썸네일 보여주기 + 클릭하면 원본 보여주기*/
	
	///////////////////////////////////////////////////////////////	
	
	var largeCa = '<c:out value="${productVO.largeCa}"/>'
	var pronum = '<c:out value="${productVO.pronum}"/>'
	var imgStr = "";
	
	console.log("largeCa: " + largeCa);
	console.log("pronum: " + pronum);
	var fileCallPath = "";
	
	if(largeCa==0) { // 레포트(Report) -> 3장 출력
		for(var i = 0; i<3; i++) {
			
			fileCallPath = '/product/showThumbnail.fr?pronum='+pronum+'&index='+i;
			
			imgStr += "<a href=\"javascript:showImage(\'"+fileCallPath+"\')\">"+
							'<img src="'+fileCallPath+'"'+
							'alt="해당 게시글은 여기까지만 이미지 미리보기 파일이 존재합니다." style="width:200px; margin: 10px"></a>';
		}	
	} else if(largeCa==1) { // 논문(Paper) -> 5장 출력
		for(var i = 0; i<5; i++) {
			
			fileCallPath = '/product/showThumbnail.fr?pronum='+pronum+'&index='+i;
			
			imgStr += "<a href=\"javascript:showImage(\'"+fileCallPath+"\')\">"+
							'<img src="'+fileCallPath+'"'+
							'alt="해당 게시글은 여기까지만 이미지 미리보기 파일이 존재합니다." style="width:200px; margin: 10px"></a>';
		}
	}
	
	$(".thumbnailShow").html(imgStr);
	
	// 보여준 원본 파일 닫기 -> 원본 파일 보여주는 함수는 ready 외부에 있다.
	$(".bigPictureWrapper").on("click", function(e){
	
		$(".bigPicture").animate({width: '0%', height:'0%'},1000);

		setTimeout(()=>{
			
			$(this).hide();
			
		},1000)
		
	});
			
	// 상품 삭제 요청 시 삭제 요청으로 approval 변경/*
	$(".deleteRequest").click(function(e){
		e.preventDefault();
		console.log("deleteRequest pronum: " + pronum);
		
		$.ajax({
			url : '/product/deleteRequest.fr',
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			data : {"pronum":pronum, "id":reviewerId},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				
				if(result=="success"){
					alert(result + " :: 삭제 요청되어 정상 처리되어 게시글을 숨김처리합니다.");
					window.location.reload();
				} else {
					alert(result + " :: 삭제 요청이 등록되지 않았습니다.");
				}
			}
		}); // ajax 끝
		
	});
	
	
	
	
	// 추가 :: 스프링 시큐리티 토큰 전달
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	// 추가 :: 로그인한 사용자의 아이디 가져오기
	var testId = "${user_id }";
		
	// 추가 :: 장바구니 버튼 클릭 시 장바구니에 추가
	$(".cartAdd").click(function(e){
		e.preventDefault();
		
		$.ajax({
			url : '/cart/writeProcess.fr',
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : JSON.stringify({id:testId, pronum:pronum}),
			dataType : 'text',
			contentType : 'application/json; charset=utf-8',
			type : 'POST',
			success : function(result){
				if(result == 'notAddCart'){
					alert("이미 장바구니에 등록된 상품입니다.");
				}else if(result == 'notAddOrder'){
					alert("이미 구매한 상품입니다.");
				}else if(result == 'success'){
					alert("장바구니에 상품이 담겼습니다.");
				}
			}
		}); // ajax 끝
		
	});
	
}); // ready 끝

// 원본 파일 보여주는 함수
function showImage(fileCallPath){	
	
	$(".bigPictureWrapper").css("display","flex").show();
	$(".bigPicture").html('<img src="'+fileCallPath+'">').animate({width: '100%', height:'100%'},1000);
}



</script>
<!-- footer에서 가져옴 -->

<%@ include file="../includes/footer.jsp"%>