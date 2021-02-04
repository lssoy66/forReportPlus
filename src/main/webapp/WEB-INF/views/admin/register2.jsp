<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes_admin/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Question Register</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">자주묻는질문 수정</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

        <form role="form" action="/admin/register2.fr" method="post">
          <div class="form-group">
            <label>Title</label> <input class="form-control" name='questiontitle'>
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" rows="3" name='question'></textarea>
          </div>
          <input type="submit" class="btn btn-default" value="Submit Button"></input>
          <button type="reset" class="btn btn-default">Reset Button</button>
        </form>

      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>


<%@ include file="../includes_admin/footer.jsp" %>