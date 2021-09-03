<%@page import="bean.SelectDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bean.SelectDAO"%>
<jsp:useBean id="dto" class="bean.SelectDTO"></jsp:useBean>
<jsp:setProperty property="id" name="dto"/>
<jsp:setProperty property="play" name="dto"/>
<jsp:setProperty property="account" name="dto"/>

<%
	SelectDAO dao = new SelectDAO();
	dao.firstInsertMovie(dto);
	response.sendRedirect("../view/main.jsp");
%>