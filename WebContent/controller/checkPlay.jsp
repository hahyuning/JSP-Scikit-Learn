<%@page import="bean.SelectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	request.setCharacterEncoding("utf-8");
	String account = request.getParameter("account");
	String id = (String)session.getAttribute("id");
	session.setAttribute("account", account);
	SelectDAO dao = new SelectDAO();
	String result = dao.checkAccount(account);
	out.print(result);




/* Account db의 값이 null 이면 Selectmovie로 , 아니면 main 페이지로 이동 */
if(result == null || result.equals("") ){
	response.sendRedirect("../view/selectMovie.jsp?id="+ id + "&account=" +account); //세션이면 입력값 ->
}else{
	response.sendRedirect("../view/main.jsp");
}
%>
