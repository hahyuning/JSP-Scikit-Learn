<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MemberDAO"%>
<%@page import="bean.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="../css/css.css" />
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	alert("<%=session.getAttribute("id") %>" + "님으로 로그인 되었습니다.")
}) 
$(function() {
	$(".bt").click(function() {
	accountId = prompt("계정 이름을 입력하세요") 
		if (accountId != null) {
			$.ajax({
				url: "../controller/accountController.jsp",
				data : {
					account: accountId + $(this).val()
				},
				success: function(result) {
					if (result == 1) {
						alert("등록 완료")
						location.reload()
					} else if (result == 2) {
						alert("이용할 수 있는 계정 개수를 초과했습니다")
					} else if (result == 3) {
						alert("삭제 완료")
						location.reload()
					} else if (result == 0) {
						alert("잘못된 입력입니다")
					}
				}
			})
		}
		
	})

})
</script>
</head>
<body align="center">

		<img src="../css/넷플렉스.png" width="150" height="80">

	<form action="../controller/checkPlay.jsp" method="post">
		<h1>계정</h1>
		<br>
		<div id="div">
		<%
		String id = (String)session.getAttribute("id");
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		MemberDAO dao = new MemberDAO();
		ArrayList<Object> list = dao.acccount(dto);

		String[] accountNameList = String.valueOf(list.get(0)).split(",");
		ArrayList<String> list2 = new ArrayList<>(Arrays.asList(accountNameList));
		while (list2.indexOf("") != -1) {
			list2.remove("");
		}
		int i = 0;
		for (String name : list2)	{
		%> 
		<input type='submit' name='account' value="<%= name %>"/>
		<% 
		} %>
		</div><br>
	</form>
		<button class='bt' value="1">계정 추가</button>
		<button class='bt' value="2">계정 삭제</button>		
</body>
</html>