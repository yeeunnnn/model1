<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	/* 디버깅 색깔 지정 */
	final String RESET = "\u001B[0m";
	final String CYAN = "\u001B[46m";
	
	/* 인코딩 */
	response.setCharacterEncoding("utf-8");
	
	/* validation */
	if(request.getParameter("subjectName") == null
		|| request.getParameter("subjectTime") == null
		|| request.getParameter("subjectName").equals("")
		|| request.getParameter("subjectTime").equals("") ){
		//받아온 데이터가 없을 경우 Form으로 redirect
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
		return;
		}
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	System.out.println(subjectName+CYAN+"<--addSubjectAction parameter subjectName"+RESET);
	System.out.println(subjectTime+CYAN+"<--addSubjectAction parameter subjectTime"+RESET);
	
	/* 객체에 데이터 담기 */
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	SubjectDao subjectDao = new SubjectDao();
	int row = subjectDao.insertSubject(subject);
	System.out.println(row+CYAN+"<--addSubjectAcion row"+RESET);
	
	String msg = null;
	if(row == 0){
		msg = URLEncoder.encode("입력 실패", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/addSubject.jsp");
		return;
	} else {
		msg = URLEncoder.encode("입력 성공", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
		return;
	}
%>