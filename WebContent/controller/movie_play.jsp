<%@page import="bean.AccountDTO"%>
<%@page import="bean.MovieDAO"%><%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%><jsp:useBean id="dto" class="bean.AccountDTO"></jsp:useBean><jsp:setProperty property="*" name ="dto"></jsp:setProperty><%MovieDAO dao = new MovieDAO();
 dao.updatePlay(dto);%>