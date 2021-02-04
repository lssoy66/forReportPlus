<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes_admin/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Notice Register</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">공지사항 등록</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

        <form role="form" action="/admin/register1.fr" method="post">
          <div class="form-group">
            <label>제목</label> <input class="form-control" name='noticetitle'>
           
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" rows="3" name='notice'></textarea>
          </div>
          <input type="submit" class="btn btn-default" value="Submit Button"></input>
          <button type="reset" class="btn btn-default">Reset Button</button>
           <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
        </form>

      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>


<%@ include file="../includes_admin/footer.jsp" %>