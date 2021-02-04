<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<%@ include file="../includes/cartHeader.jsp"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
	<sec:authentication property="principal.user.email" var="user_email" />
	<sec:authentication property="principal.user.phone" var="user_phone" />
	<sec:authentication property="principal.user.name" var="user_name" />
</sec:authorize>

<!-- Breadcrumb Begin -->
<div class="breadcrumb-area set-bg"
	data-setbg="/resources/img/breadcrumb/breadcrumb-normal.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="breadcrumb__text">
					<h2>결제하기</h2>
					<div class="breadcrumb__option">
						<a href="/cart/cartList.fr"><i class="fa fa-shopping-cart"></i>
							Cart</a> <span>Order</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Breadcrumb End -->


<!-- About Section Begin -->
<section class="about spad">
	<div class="container">
	
		<div class="row">
			<div class="col-lg-12">
				<div class="about__text">
					<h4>상품목록</h4>
					<br>
					<table class="table text-center">
						<thead>
							<tr>
								<th>상품명</th>
								<th>판매자</th>
								<th>가격</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${orderProductList }" var="orderProduct">
								<tr data-pronum="${orderProduct.pronum } " data-protitle="${orderProduct.title }">
									<td><c:out value="${orderProduct.title }" /></td>
									<td><c:out value="${orderProduct.id }" /></td>
									<td><c:out value="${orderProduct.price }" />원</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<br><br>
					<h4>구매자 정보</h4>
					<hr>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-2 col-md-2">
				<div class="about__title">
					<b>구매자</b><br><br>
					<b>휴대폰</b><br><br>
					<b>이메일</b>
				</div>
			</div>
			<div class="col-lg-10 col-md-10">
				<div class="about__text">
					${user_name }<br><br>
					${user_phone }<br><br>
					${user_email }
				</div>
			</div>
		</div>
		
		<br><br><br>
					<h4>결제수단</h4>
					<hr>
		
		<div class="row">
			<div class="col-lg-2 col-md-2">
				<div class="about__title">
					<b>일반결제</b><br><br>
					<b>무통장</b><br><br>
				</div>
			</div>
			<div class="col-lg-10 col-md-10">
				<div class="about__text">
					<form action="/order/orderProcess.fr" method="post" >
						<input type="radio" name="paymethod" value="card" checked="checked"> 신용카드<br><br>
						<input type="radio" name="paymethod" value="vBank"> 무통장입금<br><br>
					</form>
				</div>
			</div>
		</div>
			
		
		<div class="row">
			<div class="col-lg-12">
				<hr>
				<div class="about__title">
				<br>
					<p>총 결제 금액 : </p>
					<h4><c:out value="${price }" /><h4>
					<p>원</p>
					<button class="site-btn orderButton">결제하기</button>
				<br>
				</div>
			</div>
		</div>
		
	</div>
</section>
<!-- About Section End -->

<script>

	$(document).ready(function(){
		
		// cartHeader.jsp의 로그아웃 처리
		$(".logout").click(function(e){
        			
        	e.preventDefault();
        	$(".logoutForm").submit();
        			
        });
		
		var price = "<c:out value='${price }' />";
		var userID = "<c:out value='${user_id }' />";
		var userName = "<c:out value='${user_name }' />";
		var userEmail = "<c:out value='${user_email }' />";
		var userPhone = "<c:out value='${user_phone }' />"

		var protitle = "";
		var procount = $(".table tbody tr").length - 1;
		
		$(".table tbody tr").each(function(i, obj){
			console.log($(obj).data("protitle"));
			protitle = $(obj).data("protitle");
		});
		
		
		var IMP = window.IMP;
		IMP.init("imp17511892");
		
		$(".orderButton").click(function(e){
			
			e.preventDefault();
			var str = "";
			str += "<input type='hidden' name='${_csrf.parameterName }' value='${_csrf.token }'>";
			
			console.log($("input[type='radio']:checked").attr("value"));
			// 현재 amount만 넘어가도록, GET 방식으로 작성하였음
			// >>> 주문성공페이지를 따로 생성하기(무통장의 경우 가상계좌명을 보여줘야 하기 때문)
			if($("input[type='radio']:checked").attr("value") == "card"){
				//alert("Test1");
							
				IMP.request_pay({ // param
			          pg: "html5_inicis",
			          pay_method: "card",
			          name: protitle + "외 " + procount + "건",
			          amount: price,
			          buyer_email: userEmail,
			          buyer_name: userID,
			          buyer_tel: userPhone
			      }, function (rsp) { // callback
			          if (rsp.success) {
			        	  
			        	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
// 			          	$.ajax({
// 			          		url: "/order/complete", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
// 			          		type: 'GET',
// 			          		dataType: 'text',
// 			          		data: { "amount" : 100 },
// 			          		contentType : "application/json; charset=utf-8",
// 			          		success : function(result){
//  			          			var msg = '결제가 완료되었습니다.';
//  			          			msg += '\n고유ID : ' + rsp.imp_uid;
//  			          			msg += '\n결제수단 : ' + rsp.pay_method;
//  			          			msg += '\n주문명 : ' + rsp.name;
//  			          			msg += '\n주문자명 : ' + rsp.buyer_name;
//  			          			msg += '\n주문자Email : ' + rsp.buyer_email;
//  			          			msg += '\n주문자연락처 : ' + rsp.buyer_tel;
//  			          			msg += '\n결제 금액 : ' + rsp.paid_amount;
//  			          			msg += '\n가상계좌 입금계좌명(무통장 결제 시) : ' + rsp.vbank_num;
//  			          			msg += '\n가상계좌 은행명(무통장 결제 시) : ' + rsp.vbank_name;
//  			          			msg += '\n가상계좌 예금주(무통장 결제 시) : ' + rsp.vbank_holder;
//  			          			msg += '\n가상계좌 입금기한(무통장 결제 시) : ' + rsp.vbank_date;
//  			          			msg += '\n카드 승인번호(신용카드 결제 시) : ' + rsp.apply_num;
			          			
// 			          			alert(result + " :: " + msg);
// 							}
// 			          	});	// end ajax
						
						str += "<input type='hidden' name='id' value='" + rsp.buyer_name + "'>";
						str += "<input type='hidden' name='payprice' value='" + rsp.paid_amount + "'>";
						
						str += "<input type='hidden' name='applynum' value='" + rsp.apply_num + "'>";
						
						
						// 상품번호는 리스트로 전달
						$(".table tbody tr").each(function(i, obj){
							console.log($(obj).data("pronum"));
							str += "<input type='hidden' name='pronumList[" + i + "]' value='" + $(obj).data("pronum") + "'>";
						});
						
						var formObj = $("form").append(str);
						
						formObj.submit();
						
			          } else {
			        	  var msg = '결제에 실패하였습니다.';
			              msg += '\n에러내용 : ' + rsp.error_msg;
			              alert(msg);
			          }
			      });	// end request_pay
			      
				
				
 			} else if($("input[type='radio']:checked").attr("value") == "vBank") {
 				
 				IMP.request_pay({ // param
 					pg: "html5_inicis",
			          pay_method: "vbank",
			          name: protitle + "외 " + procount + "건",
			          amount: price,
			          buyer_email: userEmail,
			          buyer_name: userID,
			          buyer_tel: userPhone
			    }, function (rsp) { // callback
			          if (rsp.success) {

// 						alert(rsp.status);
// 						alert(rsp.vbank_num);
// 						alert(rsp.vbank_name);
// 						alert(rsp.vbank_holder);
// 						alert(vbdate);
						
						str += "<input type='hidden' name='id' value='" + rsp.buyer_name + "'>";
						str += "<input type='hidden' name='payprice' value='" + rsp.paid_amount + "'>";
						
			        	str += "<input type='hidden' name='vbnum' value='" + rsp.vbank_num + "'>";
						str += "<input type='hidden' name='vbname' value='" + rsp.vbank_name + "'>";
						str += "<input type='hidden' name='vbholder' value='" + rsp.vbank_holder + "'>";
						
						str += "<input type='hidden' name='vbdate' value='" + rsp.vbank_date + "'>";
						
						$(".table tbody tr").each(function(i, obj){
							console.log($(obj).data("pronum"));
							str += "<input type='hidden' name='pronumList[" + i + "]' value='" + $(obj).data("pronum") + "'>";
						});
						
						//alert(str);
						
						var formObj = $("form").append(str);
						
						formObj.submit();

			          } else {
			        	  var msg = '결제에 실패하였습니다.';
			              msg += '\n에러내용 : ' + rsp.error_msg;
			              alert(msg);
			          }
			      });	// end request_pay
 				
 			}
		
			
		});
		
		
	});


</script>

<%@ include file="../includes/footer.jsp"%>