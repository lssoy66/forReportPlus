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
<!-- header.jsp에 있는 내용으로 여기서는 주석처리: <meta charset="UTF-8"> -->
<title>ForReport</title>

</head>

<%@ include file="../includes/header.jsp"%>

	<!-- 추가 헤더: Breadcrumb Begin -->
	<div class="breadcrumb-area set-bg"
		data-setbg="../resources/img/breadcrumb/breadcrumb-normal.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>
							자료등록 주의사항 및 약관동의
						</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 추가 헤더: Breadcrumb End -->

	<!-- 자료등록 주의사항 -->
	<!-- About Section Begin -->
    <section class="about spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-7">
					<div class="containerPopup" style="font-family:맑은 고딕,Malgun Gothic; font-size:13px; letter-spacing:-0.5px; color: #111; line-height:20px; padding:20px 18px 0 15px; color: #444">
						<h2 style="text-align:center;">자료등록 주의사항</h2>
						<br>	
						<p style="font-size:14px; text-align:center; font-weight:bold; line-height:24px; color:#111">자료등록시 아래 주의사항을 참고하여 등록해주시면 <br>보류없이 빠르게 자료 등록이 가능합니다. </p>
						<p style="font-size:14px; text-align:center; padding:5px 0 17px 0; margin-bottom:8px; color:#e92e24; font-weight:bold">자료는 본인에게 저작권이 있고 저작권에 문제가 없는 자료만 판매가 가능합니다</p>
						<div class="col-lg-7 col-md-7" style="margin:auto">
							<div style="border: 1px solid #ccc; padding: 15px 0 3px 13px">
								<div style="padding-bottom:12px">
									<span style="display:block; font-size:14px; font-weight:bold; padding-bottom:3px; color:#111; margin:auto">1. 개인정보 (참고문헌 제외)</span>
									&nbsp;- 등록한 파일 문서, 제목, 소개글 등에 <span style="color:#e92e24; font-weight:bold">개인정보는 반드시 삭제 또는 블라인드 처리한 후에 등록</span>해주세요.<br>
									<span style="display: block; margin-top:8px; color: #555; font-size: 12px; margin-left:13px; margin-right:13px; border:1px solid #d5d5d5; padding:7px 15px 7px 15px; line-height:21px; background-color: #fffdec">
										* 개인정보란? 이름, 연락처, 이메일, 주민등록번호 등<br>
										* 블라인드 처리시 이름 : 이** / 연락처 010-****-**** 와 같은 형태로 수정해 주세요.
									</span>
								</div>
								<div style="padding-bottom:12px">
									<span style="display:block; font-size:14px; font-weight:bold; padding-bottom:3px; color:#111">2. 인쇄설정</span>
									&nbsp;- 미리보기 생성을 위해 <span style="color:#456fd6; font-weight: bold">인쇄는 반드시 "허용"</span>으로 등록해주시고, <br>인쇄방식은 <span style="color:#456fd6; font-weight: bold">"기본 인쇄 (전체슬라이드)"</span><br>&nbsp;&nbsp;&nbsp;로 선택해 주세요.
								</div>
								<div style="padding-bottom:12px">
									<span style="display:block; font-size:14px; font-weight:bold; padding-bottom:3px; color:#111">3. 편집상태</span>
									&nbsp;- 자료가 <span style="color:#456fd6; font-weight: bold">목차순서에 맞게 작성</span>되어 있는지, 목차에만 있고 <span style="color:#456fd6; font-weight: bold">누락된 내용이 없는지 한번 더 체크</span>해주세요.<br>
									&nbsp;- 특수폰트는 <span style="color:#456fd6; font-weight: bold">기본글꼴로 변환 후에 등록</span>해 주세요.
								</div>
								<div style="padding-bottom:12px">
									<span style="display:block; font-size:14px; font-weight:bold; padding-bottom:3px; color:#111">4. 저작시기</span>
									&nbsp;- 자료의 문서 내 저작시기와 맞게 선택하여 등록해 주세요.
								</div>
								<div style="padding-bottom:12px">
									<span style="display:block; font-size:14px; font-weight:bold; padding-bottom:3px; color:#111">5. 중복체크</span>
									&nbsp;- 이미 판매하고 있는 여러 개의 자료를 묶음판매 하거나 묶음판매 자료를 개별판매 하는 것은 등록 <br>&nbsp;&nbsp;&nbsp;불가합니다.<br>
									&nbsp;- PPT와 발표자료는 압축하여 1개의 자료로 등록해 주세요.<br>
									&nbsp;- 이미 판매중인 자료를 삭제 후 신규 등록하는 것은 등록 불가합니다.
								</div>
							</div>
							<input id="precautions" type="checkbox">내용을 확인했습니다.
						</div>
					</div>
					<div class="containerPopup" style="font-family:맑은 고딕,Malgun Gothic; font-size:13px; letter-spacing:-0.5px; color: #111; line-height:20px; padding:20px 18px 0 15px; color: #444">
						<h2 style="text-align:center;">규정동의</h2>
						<br>	
						<div class="col-lg-7 col-md-7" style="margin:auto">
							<div style="border: 1px solid #ccc; padding: 15px 0 3px 13px">
								<div style="padding-bottom:12px">
									본인의 저작물을 등록 신청함에 있어 서약서와 저작권 규정을 모두 확인하였으며 이에 동의합니다.
								</div>
								
							</div>
							<!-- ..END:: border div -->
							<input id="regulation" type="checkbox">동의합니다.
						</div>
					</div>
					<!-- ..END: containerPopup -->
					<br>
					<div class="col-lg-7 col-md-7" style="margin:auto">
						<form id="uploadForm" action="write.fr" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
							<input type="submit" id="uploadBtn" class="primary-btn" style="float:right; background-color:#038f88" value="자료 등록">
						</form>
						
					</div>						
                </div>
            </div>
        </div>
    </section>
    <!-- About Section End -->
    
<script type="text/javascript">
$(document).ready(function(){
	
	var userid = '<c:out value="${user_id}"/>'
	console.log(userid);
	console.log(typeof(userid));
	
	$("#uploadForm").on("submit", function(e){
		
		console.log("uploadBtn 내부");
		
		e.preventDefault();
		
		if(userid==""){
			alert("로그인한 사용자만 자료를 등록할 수 있습니다.");
			return false;
		}
		
		
		if(($("#precautions").is(":checked")==false)&&($("#regulation").is(":checked")==false)){
			alert("주의사항과 규정을 확인 후 표시해주시기 바랍니다.");
			$("#precautions").focus();
			return false;
		} else if($("#precautions").is(":checked")==false) {
			alert("주의사항을 확인해주시기 바랍니다.");
			$("#precautions").focus();
			return false;
		} else if($("#regulation").is(":checked")==false) {
			alert("규정을 확인해주시기 바랍니다.");
			$("#regulation").focus();
			return false;
		}
		
		this.submit();	
		
		
	});
	
});
</script>

    

<%@ include file="../includes/footer.jsp"%>