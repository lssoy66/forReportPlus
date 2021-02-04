<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!-- 로그인한 사용자 아이디 가져오기 :: ${user_id }로 사용 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />
</sec:authorize>
    
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>For Report - Admin Page</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/resources_admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/resources_admin/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/resources_admin/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/resources_admin/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/resources_admin/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/resources_admin/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">For Report Admin Page</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
            	<li>현재 사용자 : ${user_id }</li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <form class="logoutForm" action="/login/customLogout.fr" method="post">
                    	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                    </form>
                    
	                    <ul class="dropdown-menu dropdown-user">
	                    	<li><a href="/"><i class="fa fa-th-list fa-fw"></i> Main</a>
	                        </li>
	                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
	                        </li>
	                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
	                        </li>
	                        <li class="divider"></li>
		                    <li><a href="/" id="logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
		                    </li>
	                    </ul>
                    
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        
                        <li>
                            <a href="/admin/userList.fr"><i class="fa fa-group fa-fw"></i> 회원관리</a>
                        </li>
                        <li>
                            <a href="/admin/productList.fr?approval=999"><i class="fa fa-file-text-o fa-fw"></i> 상품관리<span class="fa arrow"></span></a>
<!--                             <ul class="nav nav-second-level"> -->
<!--                                 <li> -->
<!--                                     <a href="flot.html">Flot Charts</a> -->
<!--                                 </li> -->
<!--                                 <li> -->
<!--                                     <a href="morris.html">Morris.js Charts</a> -->
<!--                                 </li> -->
<!--                             </ul> -->
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="/admin/orderList.fr"><i class="fa fa-credit-card fa-fw"></i> 주문관리</a>
                        </li>
                        <li>
                            <a href="/admin/list1.fr"><i class="fa fa-bookmark fa-fw"></i> 공지사항</a>
                        </li>
                        
                        <li>
                            <a href="/admin/list2.fr"><i class="fa fa-question-circle fa-fw"></i> 자주묻는질문</span></a>
                            
                        </li>
                        
                        
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper">
        
        
        
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        
        