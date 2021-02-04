<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes_admin/header.jsp"%>

<!-- 260 -->
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">공지사항 수정</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">공지사항 수정</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

      <form role="form" action="/admin/modify1.fr" method="post">
<!--  319      -->
        <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
        <input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
        
	    <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
 
<div class="form-group">
  <label>번호</label> 
  <input class="form-control" name='noticenum' 
     value='<c:out value="${notice.noticenum }"/>' readonly="readonly">
</div>

<div class="form-group">
  <label>제목</label> 
  <input class="form-control" name='noticetitle' 
    value='<c:out value="${notice.noticetitle }"/>' >
</div>

<div class="form-group">
  <label>내용</label>
  <textarea class="form-control" rows="3" name='notice' ><c:out value="${notice.notice}"/></textarea>
</div>

<div class="form-group">
  <label>작성일</label> 
  <input class="form-control" name='WriteDate'
    value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${notice.writedate}" />'  readonly="readonly">            
</div>

  <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
  <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
  <button type="submit" data-oper='list' class="btn btn-info">리스트</button>
</form>


      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<!-- 261 -->
<script type="text/javascript">
$(document).ready(function() {

	  var formObj = $("form");

	  $('button').on("click", function(e){
	    
	    e.preventDefault(); 
	    
	    var operation = $(this).data("oper");
	    
	    console.log(operation);
	    
	    if(operation === 'remove'){
	      formObj.attr("action", "/admin/remove1.fr");
	      
	    }else if(operation === 'list'){
	    	
	      //move to list
	      
// 	      self.location="/board/list";
// 	      return;
	      
 	      formObj.attr("action", "/admin/list1.fr").attr("method","get");
//321,347	      
	      var pageNumTag = $("input[name='pageNum']").clone();
 	      var amountTag = $("input[name='amount']").clone();
	      var keywordTag = $("input[name='keyword']").clone();
	      var typeTag = $("input[name='type']").clone();      
	      
 	      formObj.empty();
	      
 	      formObj.append(pageNumTag);
 	      formObj.append(amountTag); 	      
	      formObj.append(keywordTag);
	      formObj.append(typeTag);	       
	    }
	    
	    formObj.submit();
	  });

});
</script>
  




<%@include file="../includes_admin/footer.jsp"%>
