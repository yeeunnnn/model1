<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	TeacherDao teacherDao = new TeacherDao();
	Teacher teacherOne = teacherDao.selectTeacherOne(teacherNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		table, td {text-align:center; table-layout: fixed;}
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
	<div class=container>
	<table class="table table-bordered">
		<tr>
			<td colspan="2"><h3><%=teacherOne.getTeacherNo()%>. <%=teacherOne.getTeacherName()%> 강사님</h3></td>
		</tr>
		<tr>
			<td>ID</td>
			<td><%=teacherOne.getTeacherId()%></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=teacherOne.getTeacherName()%></td>
		</tr>
		<tr>
			<td>경력</td>
			<td><%=teacherOne.getTeacherHistory()%></td>
		</tr>
		<tr>
			<td>생성일</td>
			<td><%=teacherOne.getCreatedate()%></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td><%=teacherOne.getUpdatedate()%></td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="button" class="btn btn-outline-secondary"><a class="none" href="<%=request.getContextPath()%>/teacher/addTeacher.jsp?teacherNo=<%=teacherNo%>">수정</a></button>
				<button type="button" class="btn btn-outline-secondary"><a class="none" href="<%=request.getContextPath()%>/teacher/removeTeacher.jsp?teacherNo=<%=teacherNo%>">삭제</a></button>
			</td>
		</tr>
	</table>
	</div>
</body>
</html>