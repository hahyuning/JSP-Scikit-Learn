<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="bean.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>
<%
	MemberDAO dao = new MemberDAO();
	int result = dao.idOver(dto);
%><%=result %>