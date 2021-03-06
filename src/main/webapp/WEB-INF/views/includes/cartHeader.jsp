<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
	<sec:authentication property="principal.password" var="user_pw" />
</sec:authorize>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Directing Template">
    <meta name="keywords" content="Directing, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/flaticon.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/barfiller.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3 col-md-3">
                    <div class="header__logo">
                        <a href="/"><img src="/resources/img/logo_for3.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-9 col-md-9">
                    <div class="header__nav">
                        <nav class="header__menu mobile-menu">
                            <ul>
                                <li><a href="/">Home</a></li>
                                <li><a href="#">공지사항</a>
                                	<ul class="dropdown">
                                        <li><a href="/notice/list.fr">공지사항</a></li>
                                        <li><a href="/question/list.fr">자주 묻는 질문(FAQ)</a></li>
                                    </ul>
                                </li>
                                <li>마이페이지
                                	<ul class="dropdown">
                                        <li><a href="/cart/cartList.fr">장바구니</a></li>
                                        <li><a href="/order/myOrderList.fr">주문내역</a></li>
                                        <li><a href="/user/mypage.fr">내 정보 수정</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                        <div class="header__menu__right" id="buttonMainColor">
                            <form class="logoutForm" action="/login/customLogout.fr" method="post">
	                    		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	                   		</form>
                            <c:if test="${user_id != null}">
                            	<p>${user_id }님</p>
                            	<a href="/" class="primary-btn logout" id="whiteB" style="background-color: white"> 로그아웃</a>
                            	<sec:authorize access="hasRole('ROLE_ADMIN')">
                            		&nbsp;<a href="/admin/userList.fr" class="primary-btn">관리자</a>
                            	</sec:authorize>
                        	</c:if>
                        	<c:if test="${user_id == null}">
                        		<a href="/login/customLogin.fr" class="primary-btn"> 로그인</a>
                        		<a href="/user/provision.fr" class="primary-btn"><i class="fa fa-plus"></i> 회원가입</a>

                        	</c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div id="mobile-menu-wrap"></div>
        </div>
    </header>
    <!-- Header Section End -->
    
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    