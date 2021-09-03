<%@page import="bean.MemberDAO"%>
<%@page import="bean.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dto" class="bean.MemberDTO"></jsp:useBean>
<jsp:setProperty property="id" name="dto"/>
<jsp:setProperty property="pw" name="dto"/>
<%
	String action = request.getParameter("action");
	if (action.equals("login")) {
		MemberDAO dao = new MemberDAO();
		int result = dao.login(dto);
		if(result == 1) { 
			session.setAttribute("id", dto.getId());
			response.sendRedirect("../view/account.jsp?id=" + dto.getId() + "&pw=" + dto.getPw());
		}
		else{
			response.sendRedirect("../view/logIn.html");
		}
	}
%>