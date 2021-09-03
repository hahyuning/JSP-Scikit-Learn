<%@page import="bean.MemberDAO"%>
<%@page import="bean.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="bean.MemberDTO"></jsp:useBean>
<jsp:setProperty property="id" name="dto"/>
<jsp:setProperty property="pw" name="dto"/>
<%
	int membership = Integer.parseInt(request.getParameter("membership"));
	dto.setMembership(membership);
	MemberDAO dao = new MemberDAO();
	dao.insert(dto);
%>