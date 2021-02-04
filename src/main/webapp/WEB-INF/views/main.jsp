<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html>
<html>
<head>
<!-- header.jsp에 있는 내용으로 여기서는 주석처리: <meta charset="UTF-8"> -->
<title>ForReport</title>
<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<!-- erase-credentials="false" 적용 이후 비밀번호를 가져오는지 확인해봤습니다 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
	<sec:authentication property="principal.password" var="user_password" />
</sec:authorize>
</head>



<%@ include file="includes/header.jsp" %>

    <!-- Hero Section Begin -->
    <section class="hero set-bg" data-setbg="/resources/img/hero/hero-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="hero__text">
                        <div class="section-title">
<!--                             <h2>ForReport</h2> -->
							<img alt="" src="/resources/img/logo_for2.png"><br><br>
                            <p>검증형 시스템으로 당신에게 딱 맞는 정보를 찾아보세요.</p>
<%--                             <p>${user_password }</p> --%>
                        </div>
                        <div class="hero__search__form">
                            <form id="mainInputKeywordForm" action="/product/list.fr" method="get">
                                <input type="text" placeholder="Search..." name="inputKeyword">
                                <input type="hidden" name="largeCategory" value=999>                                
                                <input type="hidden" name="smallCategory" value=999>                                
                                <button type="submit">검색</button>
                            </form>
                        </div>
                        <ul class="hero__categories__tags">
<!--                            	<li><a href="product/list.fr?largeCategory=0&smallCategory=999"><img src="/resources/img/hero/cat-2.png" alt=""> 레포트</a></li> -->
                           	<li><a href="product/list.fr?largeCategory=0&smallCategory=999"><i class="fa fa-book" aria-hidden="true" style="color: white"></i>	레포트</a></li>
                            <li><a href="product/list.fr?largeCategory=1&smallCategory=999"><i class="fa fa-file-text" aria-hidden="true" style="color: white"></i>	논문 </a></li>
                        	<c:choose>
                        		<c:when test="${not empty user_id}">
                        			<li><a href="product/agree.fr"><i class="fa fa-upload" aria-hidden="true"></i> 내 레포트/논문 올리기</a></li>
                        		</c:when>
                        	</c:choose>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->
    

<script>
	$(document).ready(function(){
		
		$(".blog__sidebar__search").css("display", "none");
	});
</script>
  
<%@ include file="includes/footer.jsp" %>