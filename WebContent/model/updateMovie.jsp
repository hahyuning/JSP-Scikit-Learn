<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bean.SelectDAO"%>
<jsp:useBean id="dto" class="bean.SelectDTO"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>
<%
	SelectDAO dao = new SelectDAO();
	dao.update(dto);
%>
<!-- 영화 이미지 클릭시 -> 업데이트 -->