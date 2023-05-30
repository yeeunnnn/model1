<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	SubjectDao subjectDao = new SubjectDao();
	ArrayList<Subject> subjectList = subjectDao.selectSubjectListByPage(0, 10);//0부터 10까지
	
	/* 인코딩 */
	response.setCharacterEncoding("utf-8");
	String msg = null;
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
     <div class="container mt-3" class="center">
	<table class="table table-bordered table-sm">
		<tr>
			<td colspan="5">
					<%
						if(request.getParameter("msg") != null){
					%>
							<%=request.getParameter("msg")%>
					<%
						}
					%>
				</td>
			</tr>
		<tr>
			<td colspan="5" class="table-danger"><h4>과목목록 조회</h4></td>
		</tr>
		<tr>
			<th>과목번호</th>
			<th>과목이름</th>
			<th>과목시간</th>
			<th>생성일</th>
			<th>수정일</th>
		</tr>
			<%
				for(Subject subject : subjectList){
			%>
			<tr>
				<td><a href="<%=request.getContextPath()%>/subject/subjectOne.jsp?subjectNo=<%=subject.getSubjectNo()%>"><%=subject.getSubjectNo()%></a></td>
				<td><%=subject.getSubjectName()%></td>
				<td><%=subject.getSubjectTime()%></td>
				<td><%=subject.getCreatedate()%></td>
				<td><%=subject.getCreatedate()%></td>
			</tr>
			<%
				}
			%>
			<tr class="center">
			<td colspan="5">
			<button type="button" class="btn btn-outline-secondary"><a href="<%=request.getContextPath()%>/subject/addSubject.jsp">추가</a></button>
			</td>
		</tr>
	</table>
	</div>
</body>
</html>