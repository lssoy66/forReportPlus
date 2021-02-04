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

<style type="text/css">

#uploadFormTable th {
	vertical-align: middle /*table head 수직 정렬*/
}

#uploadFormTable td {
	text-align: left /*table body 왼쪽 정렬*/
}

</style>

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
							자료 등록
						</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 추가 헤더: Breadcrumb End -->
	
	
<!-- 상품 목록 -->
<section class="blog-section spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<form id="uploadForm" action="upload.fr" method="post" enctype="multipart/form-data">
					<table id="uploadFormTable" class="table text-center">
	    				<tr>
	    					<th>파일 선택</th>
	    					<td>
	    						<!-- 파일은 1 페이지에 1개만 올릴 수 있어야 하기 때문에 multiple 속성 제거 -->
	    						<!-- accept: 입력 가능한 확장자 지정 가능(단, 파일 선택할 때 모든 파일로 변경할 수 있기 때문에 자바스크립트에서 확장자 잡아줘야한다.) -->
	    						<input type="file"
	    							   name="uploadFile"
	    							   accept=".pdf,.pptx,.docx"
	    							   required>
							</td>
	    				</tr>
	    				<tr>
	    					<th>제목</th>
	    					<td>
	    						<p>자료의 내용을 대표할 수 있도록 구체적으로 기재하시기 바랍니다.</p>
	    						<input type="text" name="title" required>
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>가격</th>
	    					<td>
	    						<p>기호없이 숫자만 입력해주세요</p>
	    						<input type="number" name="price" required>
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>대분류</th>
	    					<td>
	    						<select id="largeCa" name="largeCa">
		    						<option value="0">레포트</option>
		    						<option value="1">논문</option>
		    					</select>    				
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>소분류</th>
	    					<td>
	    						<select id="smallCa" name="smallCa">
		    						<option value="0">인문사회</option>
		    						<option value="1">자연공학</option>
		    						<option value="2">예술체육</option>
		    						<option value="3">교양</option>
		    					</select>    				
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>상세정보</th>
	    					<td>
	    						<textarea onKeyUp="javascript:fnChkByte(this,'2500')" name="prodsc" rows="10" cols="130" placeholder="자료에 대한 소개, 목차, 본문 내용 등을 상세하게 적어주세요." required></textarea>
	    						<br>
	    						<span id="byteInfo">0</span> / 2500Byte
	    					</td>
	    				</tr>
	    			</table>	    			
	    			<input type="hidden" name="id" value="${user_id}"> 
	    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
	    			<input type="submit" value="자료 등록" class="primary-btn" style="float:right; background-color:#038f88">
	    		</form>
			</div>
		</div>
	</div>
</section>

<script type="text/javascript">

/////////////////////////////////////////////////////////////////////

/** 상세정보 바이트 제한*/
//http://blog.naver.com/PostView.nhn?blogId=weekamp&logNo=221521396796&parentCategoryNo=&categoryNo=33&viewDate=&isShowPopularPosts=false&from=postView

/////////////////////////////////////////////////////////////////////


function fnChkByte(obj, maxByte){
    var str = obj.value;
    var str_len = str.length;

    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";

    for(var i=0; i<str_len; i++){
        one_char = str.charAt(i);
        if(escape(one_char).length > 4){
            rbyte += 3;    //한글3Byte
        }else{
            rbyte++;    //영문 등 나머지 1Byte
        }

        if(rbyte <= maxByte){
            rlen = i+1;    //return할 문자열 갯수
        }
    }

    if(rbyte > maxByte){
        alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        str2 = str.substr(0,rlen);    //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
    }else{
        $("#byteInfo").html(rbyte);
    }
}

$(document).ready(function(){
	
	

	
	/////////////////////////////////////////////////////////////////////
	
	/** 제출 버튼 눌렀을 때: 잠시 멈춤 > 파일 확인 > 업로드*/
	
	/////////////////////////////////////////////////////////////////////
	
	// 제출 버튼 눌렀을 때
	$("#uploadForm").on("submit", function(e){
		
		console.log("click submit");			
	
		
	}); // 제출 버튼 눌렀을 때
	
	
	/////////////////////////////////////////////////////////////////////
	
	/** file의 요소가 달라진 경우 */
	
	/////////////////////////////////////////////////////////////////////
	
	// 파일 확장자 및 최대 크기 설정
						    
//	var regex = new RegExp("(.*?)\.(docx|hwp|pdf|pptx)$");
	var regex = new RegExp("(.*?)\.(docx|pdf|pptx)$");
	var maxSize = 5 * 1024 * 1024; // 임시로 설정한 최대값 5MB
	
	// 파일 확장자 및 크기 확인 함수(파일 사이즈, 확장자 종류 모두 일치하는 경우 treu 리턴)
	function checkFile(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈가 초과되었습니다. 5MB 이하로 파일을 변경해주세요.");
			return false;
		}
		
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다. 업로드 가능한 파일의 확장자는 hwp, pdf, pptx, docx입니다.");
			return false;
		}
		
		return true;			
	}
	
	// 제이쿼리 change(): 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백 함수를 동작시킨다.
	$("input[type='file']").change(function(e){
		
		console.log($(this).val());
		
		/*
			FormData
			- jQuery에서 파일 업로드를 할 때 사용하는 객체
			- 가상의 <Form>태그와 같다고 생각할 수 있다.
			- Ajax를 이용하는 파일 업로드는 FormData를 이용해서 필요한 파라미터를 담아서 전송하는 방식
			- 위치: window.FormData
		*/
		//var formData = new FormData();
		var inputFile = $("input[name=uploadFile]");
		var file = inputFile[0].files; 
		// 동일 name으로된 input type=file이 여러개 있으면 inputFile배열도 1,2,3... 더 나올 수 있다. 여기서는 1개밖에 없어서 [0]으로 해서 값을 가져온다.
		// 입력받은 파일을 찐 File 형태로 저장
		
		if(file.length > 1) {
			alert("자료는 1개만 등록해주세요.");
			return false;
		}
		
		if(!checkFile(file[0].name, file[0].size)){
			$(this).val("");
			return false;
		}
					 	
	}); // change
	
	
}); // ready 끝

</script>




<%@ include file="../includes/footer.jsp"%>