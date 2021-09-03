<%@page import="bean.SelectDAO"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="bean.MovieDTO"%>
<%@page import="bean.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

body { color:#ffffff; }

</style>
<style>
body {background-color: "black"

}

h3 {
text-align: center;
}


</style>
<link rel="stylesheet" type="text/css" href="../css/over.css">
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript">

//체크 박스(play) 선택시 account DB에 play가 넘어가게함
/*
 session.getAttribute("id")
 session.getAttribute("account_name")
 세션 아이디, + 계정 받아와야함 -> 코드 .. 변수지정*/


 <%
 request.setCharacterEncoding("utf-8");
 String account = request.getParameter("account");
 String tId = request.getParameter("id");
 %>
 
totalBox = "";
 $(function() {
		// .check 클래스 중 어떤 원소가 체크되었을 때 발생하는 이벤트
			$(".ch").click(function(){  // 여기서 .click은 체크박스의 체크를 뜻한다.
				 var playbox = "";  // 여러개가 눌렸을 때 전부 출력이 될 수 있게 하나의 객체에 담는다.
				$(".ch").each(function(){  // .each()는 forEach를 뜻한다.
					if($(this).is(":checked"))  // ":checked"를 이용하여 체크가 되어있는지 아닌지 확인한다.
						playbox += $(this).val() + ",";  // 체크된 객체를 playbox 에 저장한다.
			
				});
				total = "" ;
				total = playbox ;
				console.log(total)
				console.log(total.length)
				totalBox = total.substring(0, total.length-1); //영화선택에서 추가될 ',' 처리를 위한 substring(마지막 글자삭제)
			});
		
	$('#btcheck').click(function() {
		if(totalBox == "") {
			alert('영화선택좀');
		}else{
		$.ajax({
			url : '../model/insertMovie.jsp',
			data : { //괄호는 묶어준다
					id : '<%=tId%>',
					play : totalBox,
					account : '<%=account %>'
					},
					success : function(result) {	
						window.location.href="../view/main.jsp";
						}
					})
				}
			})
		})

</script>
</head>
		
<div class="wrapLeft">
	<img src= "../css/넷플렉스.png" width = "150" height = "80">
</div>

<body style = "background-color: black;">
<table>
<br>

<div class = 'font'>

<h3><%=account %>님 환영합니다.
<br>
<br>
평소 좋아하시는 영화를 선택해주세요 :)
</h3>
<br>
<div class = 'btcheck'>

<button id="btcheck"> 선택완료</button>

<br>
</table>
</div>



<!-- 영화 선택 테이블 -->		
<%
	SelectDAO dao = new SelectDAO();
	ArrayList<MovieDTO> list = dao.MovieList();
	Collections.shuffle(list);
	
%>
<table border='1' align="center">
	<tr width="300">
	
<%
	for(int i = 0; i < 10; i++) {
		MovieDTO dto = list.get(i);
%>
	<td width="100">
		<img src="<%= dto.getUrl()%>"/><br><input type="checkbox" name = "ch" class ="ch" 
		 value="<%= dto.getMovie_name()%>"><%=dto.getMovie_name()%>
	</td>
<%} %>
	
	</tr>
	<tr width="100">
<%
	for(int i = 10; i < 20; i++) {
		MovieDTO dto = list.get(i);
%>
	<td width="100">
		<img src="<%= dto.getUrl()%>"/><br><input type="checkbox" name = "ch" class ="ch" 
		 value="<%= dto.getMovie_name()%>"><%=dto.getMovie_name()%> 
	</td>
<% } %>

	</tr>
</table>
<!-- 영화 선택 테이블  -->
</div>

</body>
</html>