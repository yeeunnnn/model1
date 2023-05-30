<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* 인코딩 */
	response.setCharacterEncoding("utf-8");
	String msg = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addSubject</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
	 	table, td {table-layout: fixed}
	 	.center {text-align:center}
	</style>
</head>
<body>
	<div><!-- Navigation-->
	  	<ul class="nav nav-tabs">
             <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/teacherSubjectList.jsp">tsList</a></li>
             <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/subject/subjectList.jsp">subjectList</a></li>
         	 <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/">3</a></li>
         </ul>
    </div>
	<form action="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
	<div class="container" class="center">	
	<table class="table table-bordered">
		<tr class="center">
			<td colspan="2" class="table-danger"><h4>과목 추가</h4></td>
		</tr>
		<tr>
			<td class="center">과목 이름</td>
			<td class="center">
				<input type="text" name="subjectName">
			</td>
		</tr>
		<tr>
			<td class="center">과목 시간</td>
			<td class="center">
				<input type="number" name="subjectTime">
			</td>
		</tr>
		<tr class="center">
			<td colspan="2">
			<button type="submit" class="btn btn-outline-secondary">입력</button>
			</td>
		</tr>
	</table>
	</div>
</form>
</body>
</html>