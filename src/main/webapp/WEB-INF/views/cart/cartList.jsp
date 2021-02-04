<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../includes/cartHeader.jsp"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
</sec:authorize>

<style>
.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img{
	width: 600px;
}

</style>

<!-- Blog Hero Begin -->
<div class="blog-details-hero set-bg"
	data-setbg="/resources/img/blog/details/blog-hero.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-7">
				<div class="blog__hero__text">
					<h2>장바구니</h2>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Blog Hero End -->

<!-- Blog Details Section Begin -->
<section class="blog-details spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-8">
				<div class="blog__details__text">
				
					<input type="checkbox" id="allSelect"> 전체선택
					
					<div class="footer__copyright__links">
						<!-- 아이디는 세션에서 가져온다 -->
						<a href="${user_id }" id="allDelete">전체삭제</a>
					</div>
					
					<div class="listing__details__comment cartList">
						<div class="bigPictureWrapper">
							<div class="bigPicture">
							</div>
						</div>
						<form action="/order/order.fr" id="checkForm" method="post">
							<!-- 아이디는 세션에서 가져온다 -->
							<input type="hidden" name="id" id="id" value="${user_id }">
							<input type="hidden" name="price" id="price" value="">
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					
							<c:forEach items="${cartProductList }" var="cartProduct">
								
		                            <div class="listing__details__comment__item cartProduct_item">
			                            	<!-- 체크박스 -->
			                            	<div class="listing__details__comment__item__pic checkboxPronum">
			                                    <input type="checkbox" name="checkPronum"
			                                    	value="<c:out value="${cartProduct.pronum}" />"
			                                    	data-price="<c:out value="${cartProduct.price}" />">
			                                </div>
			                            	<!-- 썸네일 -->
			                                <div class="listing__details__comment__item__pic thumbnail" data-pronum="${cartProduct.pronum}">
			                                    <img src='/product/showThumbnail.fr?pronum=${cartProduct.pronum}&index=0' alt='' style='width:100px; height: 100px; margin: 0px'>
			                                </div>
			                                <div class="listing__details__comment__item__text">
			                                 	<!-- 삭제버튼 -->
			                                    <div class="listing__details__comment__item__exit exitButton">
			                                       	<a href="${cartProduct.pronum}"><i class="fa fa-times"></i></a>
			                                    </div>
			                                    <!-- 상품정보 -->
			                                   	<b><a href="/product/view.fr?pronum=${cartProduct.pronum}"><c:out value="${cartProduct.title}" /></a></b>
			                                   	<p>판매자 : <c:out value="${cartProduct.id}" /></p>
			                                    <p>상품설명 : <c:out value="${cartProduct.prodsc}" /></p>
			                                 	가격 : <c:out value="${cartProduct.price}" />원
			                               	</div>
		                           	</div>
		                        
							</c:forEach>
						
						</form>
					</div>
					
				</div>

			</div>
			<div class="col-lg-4">
				<div class="blog__sidebar">
					<div class="blog__sidebar__recent orderPrice">
						<h5>선택상품</h5>
						결제예정금액 : <b>0</b>원 <br><br>
						<button class="site-btn buttonTest" id="btnColorCustom"
							style="padding: 20px 110px; font-size:20px">결제하기</button>
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

		var cartProductList = '<c:out value="${cartProductList.isEmpty() }" />';
		
		// 스프링 시큐리티 토큰 전달
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
 		// 즉시 실행 함수
		(function(){
			$("input[type='checkbox']").each(function(){
				$(this).prop("checked", false);
			});
			
			checkCartList(cartProductList);
			
		})();	// end function 
		
		function checkCartList(cartProductList){
			console.log("checkCartList");
			if(cartProductList == "true"){
				$(".cartList").html("<h5>장바구니에 담긴 상품이 없습니다.</h5>");
			}
		} 
		
		// 주문하기 버튼을 누르면 주문 페이지에 상품번호와 아이디, 총 금액을 전달
		$(".buttonTest").click(function(){
			//console.log(typeof(Number($(".orderPrice b").html())));
			if($(".orderPrice b").html() == "0"){
				alert("상품을 한 개 이상 선택해 주세요.");
				return;
			}
			
			$("input[id='price']").attr("value", price);
			$("#checkForm").submit();
		});

		// 총 금액
		var price = 0;
		$(".checkboxPronum input[type='checkbox']").change(function(){
			if($(this).prop("checked")){
				price += $(this).data("price");
			}else{
				price -= $(this).data("price");
			}
			$(".orderPrice b").html(price);
		});
		
		// 전체선택
		$("#allSelect").click(function(){
			
			if($("#allSelect").prop("checked")){
				price = 0;
				$(".checkboxPronum input[type='checkbox']").each(function(){
					$(this).prop("checked", true);
					price += $(this).data("price");
				});
			}else{
				$(".checkboxPronum input[type='checkbox']").each(function(){
					$(this).prop("checked", false);
					price = 0;
				});
			}
			$(".orderPrice b").html(price);
			
		});
		
		// 로그인한 사용자 아이디
		var id = "${user_id }";
		
		// 상품 삭제
		$(".exitButton a").click(function(e){
			e.preventDefault();
			//console.log(typeof($(this).attr("href")));
			
			var pronum = Number($(this).attr("href"));
			console.log(pronum);
			$(this).parent().parent().parent().remove();
			
			$.ajax({
				url : '/cart/deleteProcess.fr',
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : JSON.stringify({id:id, pronum:pronum}),
				dataType : 'text',
				contentType : "application/json; charset=utf-8",
				type : 'POST',
				success : function(result){
					//alert(result);
					if($(".cartProduct_item").length == 0){
						$(".cartList").html("<h5>장바구니에 담긴 상품이 없습니다.</h5>");
					}
				}
			});	 // end ajax
		
		});
		
		// 모든 상품 삭제
		$("#allDelete").click(function(e){
			
			e.preventDefault();
			if(confirm("장바구니를 비우시겠습니까?") == true){
				$(".cartList").html("<h5>장바구니에 담긴 상품이 없습니다.</h5>");
				
				$.ajax({
					url : '/cart/deleteAllProcess.fr/' + id,
					beforeSend : function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					dataType : 'text',
					type : 'DELETE',
					success : function(result){
						//alert(result);
					}
				});	 // end ajax
			} else {
				return;
			}
		});	
		
		// 썸네일 클릭
		$(".thumbnail").click(function(){
			console.log($(this).data("pronum"));
			var pronum = $(this).data("pronum");
			var fileCallPath = '/product/showThumbnail.fr?pronum='+pronum+'&index=0';
			$(".bigPictureWrapper").css("display","flex").show();
			$(".bigPicture").html('<img src="'+fileCallPath+'">').animate({width: '100%', height:'100%'},500);
		});
		
		// 보여준 원본 파일 닫기
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width : '0%', height : '0%'}, 500);
			setTimeout(function(){
				$('.bigPictureWrapper').hide();
			}, 500);
		});
		
	});
	
</script>

<%@ include file="../includes/footer.jsp"%>