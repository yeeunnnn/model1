<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	TeacherSubjectDao tsSubjectDao = new TeacherSubjectDao();
	// 현재 페이지 번호
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	/* 1. 글에 필요한 값: beginRow, rowPerPage (oracleDB 사용시 endRow) */
	int rowPerPage = 3;
	int beginRow = (currentPage - 1) * rowPerPage; // ex. rowPerPage가 10일때 1, 11, 21... 출력
	//mariadb는 limit가 있어서 시작 번호와 끝번호를 따로 정해주지 않아도 됨.
	//beginRow부터 rowPerPage까지의 데이터를 가져오는 메소드를 호출, 결과 저장
	ArrayList<HashMap<String, Object>> tsList = tsSubjectDao.selectTeacherSubjectListByPage(beginRow, rowPerPage);//0부터 10까지
	
	//totalRow를 사용하기 위해 selectTeacherSubjectListCnt 메소드 호출 및 변수 저장
	int totalRow = tsSubjectDao.selectTeacherSubjectListCnt();

	/* 2. 하단 바에 필요한 값: minpage(이전) pageperpage maxPage(다음) */
	int pagePerPage = 3;
	
	int lastPage = totalRow / pagePerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	int minPage = (((currentPage - 1) / pagePerPage) * pagePerPage) + 1; //하단 페이징에서 제일 작은 값
	int maxPage = minPage + (pagePerPage - 1); // 하단 페이징에서 제일 큰 값
	//마지막 번호가, 실제 페이지 번호보다 많지 않도록 처리
	if(maxPage > lastPage){
		maxPage = lastPage;
	}
	
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
		.center {text-align:center;}
	</style>
</head>
<body>
	<div><!-- Navigation-->
	  	<ul class="nav nav-tabs">
             <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/teacherSubjectList.jsp">강사별 담당과목</a></li>
         	 <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/subject/subjectList.jsp">과목 리스트</a></li>
         	 <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp">강사 리스트</a></li>
         </ul>
    </div>
    
     <div class="container mt-3" class="center">
		<table class="table table-bordered table-sm">
			<tr>
				<td colspan="5" class="table-danger"><h4>강사별 담당과목</h4></td>
			</tr>
			<tr>
				<th>번호</th>
				<th>ID</th>
				<th>이름</th>
				<th>과목번호</th>
				<th>담당과목</th>
			</tr>
				<%
					for(HashMap<String, Object> tsMap : tsList){
				%>
				<tr>
					<td><%=tsMap.get("teacherNo")%></td>
					<td><%=tsMap.get("teacherId")%></td>
					<td><a href="<%=request.getContextPath()%>/teacher/teacherOne.jsp?teacherNo=<%=tsMap.get("teacherNo")%>"><%=tsMap.get("teacherName")%></a></td>
					<td><%=tsMap.get("subjectNo")%></td>
					<td><%=tsMap.get("allSubject")%></td>
				</tr>
			<%
				}
			%>
		</table>
	 </div>
	 <div class="container">
		 <nav aria-label="Page navigation example">
			 <ul class="pagination justify-content-center">
				 <li class="page-item">
						<%
						// '이전'
						if(minPage > 1){
						%>
							<a class="page-link" aria-label="Previous" href="<%=request.getContextPath()%>/teacherSubjectList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>
						<%		
							}
							// 하단 페이징 번호
							for(int i = minPage; i <= maxPage; i = i+1){
								if(i == currentPage){
						%>
									<li class="page-item disabled"><a class="page-link"><span><%=i%>&nbsp;</span></a></li>
						<%			
								} else {
						%>
									<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/teacherSubjectList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;</li>
						<%			
								}
							}
							// '다음'
							if(maxPage != lastPage){
						%>
							<li class="page-item"><a class="page-link" href ="<%=request.getContextPath()%>/teacherSubjectList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a></li>
						<%		
							}
						%>
					</li>
				</ul>
			</nav>
		</div>
</body>
</html>