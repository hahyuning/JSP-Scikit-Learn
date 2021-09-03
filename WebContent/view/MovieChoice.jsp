<%@page import="bean.AccountDTO"%>
<%@page import="java.util.Random"%>
<%@page import="java.io.Console"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MovieDAO"%>
<%@page import="bean.MovieDTO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/movie.css">
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<% 
	String mul = request.getParameter("mul"); // 영화 이미지
	String mnam = request.getParameter("mnam");// 영화 이름
	String gen = request.getParameter("gen"); //영화 장르
    String[] m_list = mnam.split(",");		//가져온 제목의 ,값을 제거
    mnam = "";								//빈 리스트 선언
    for (String s: m_list){					//넘어온 mnam값을 (,)를 빼고 다시 띄어쓰기 
  		  	mnam = mnam + " " + s;
    }
    String account = (String)session.getAttribute("account");
    String id = (String)session.getAttribute("id");
    out.print(account);
    out.print(id);
%>
<script type="text/javascript">
$(function() {
	$("#button1").click(function() { //영화 추천버튼
		$.ajax({
			url: "../controller/movie_like.jsp",
			data: {
			    id: '<%= session.getAttribute("id")%>', 			//session 으로 가져올 예정
			    account: '<%= session.getAttribute("account")%>',	//session 으로 가져올 예정
				mlike :<%-- '<%=gen%>' --%>
					 $("#h1").text().trim()		//h1 에 쓰인 텍스트값 가져와서 앞뒤 공백 자르기
			},
			success: function(result) {
				alert($("#h1").text().trim()+" 영화 추천 성공")
			}
		})
	})
	$("#button2").click(function() { //영화 비추천 버튼
		$.ajax({
			url: "../controller/movie_unlike.jsp",
			data: {
				id:'<%= session.getAttribute("id")%>',
				account: '<%= session.getAttribute("account")%>',
				unlike :$("#h1").text().trim()
			},
			success: function(result) {
				alert($("#h1").text().trim()+"영화 비추천 성공")
			}
		})
	})
	$("#button").click(function() { //영화 플레이 기록 
		$.ajax({
			url: "../controller/movie_play.jsp",
			data: {
				id: '<%= session.getAttribute("id")%>',
				account: '<%= session.getAttribute("account")%>',
				play :$("#h1").text().trim()
			},
			success: function(result) {
				
			}
		})
	})
	
	//버튼클릭시 ->
	
	//
	
})//main
</script>
</head>
<body bgcolor="black">

<br>

<br>


<h1 align="center" id='h1'><font color="red"><%=mnam%><!-- 넘어온 영화 제목 표시  --></font>
</h1><span  style="color:yellow;font-size: 20px;text-align: right;"><%=session.getAttribute("account") %>님</span><!-- Account -->
<hr color="red">
<%	String mname = mnam.trim();
	MovieDAO dao = new MovieDAO();	//DAO호출
	ArrayList<MovieDTO2> list = dao.list(); // movie Table 전체 불러오기
%>		
<table>
	<tr>
		<td class = 'c1'><img class ='c1' alt="" src="<%= mul%>"></td>
		<%for(int i = 0; i <list.size(); i++){
				 if(mname.equals(list.get(i).getMovie_name())){ //영화 이름과 일치한 감독, 장르 , 줄거리 가져오기 
					%>
											<!-- 조건문 true시 표시  -->
		<td class = 'c1'><textarea class ='c1' id='textarea' rows="" cols=""  disabled>
																				감독 <%=list.get(i).getPd()%>
																				장르 <%=list.get(i).getGenre() %>
																				<%=list.get(i).getMovie_content() %></textarea></td>
			 	<%  
				 }
			}%>
	</tr>
</table>
<!--1. PLAY버튼을 누르면 youtube에서 해당 영화를 검색해서 띄워줌 -->
<!--2. account table 에 시청기록에 추가  -->
<a href="https://www.youtube.com/results?search_query=<%=mnam.trim()%>"><button id='button' type="button">PLAY</button></a>

<button id='button1' type="button">추천</button>
<!-- 추천버튼 클릭 시 like에 추가 -->
<button id='button2' type="button">비추천</button>
<!-- 비추천 클릭 시 unlike에 추가 -->
<hr color="red">
<h2 align="center"><font color="red">영화추천</font></h2>
<table align="center" >
	
	<tr>
		<!-- <td id='t2'><button id='b1' type="button">◀</button></td> -->
		<% 
		Random r = new Random();
		int a = r.nextInt(list.size());
		for(int i = 0; i < list.size(); i++){
			if (list.get(i).getGenre().toString().equals(gen)) {	//영화 랜덤 추천 
				%>
				<td id='t1'><a href="MovieChoice.jsp?mnam=<%=list.get(a).getMovie_name()%>&mul=<%=list.get(a).getUrl()%>&gen=<%=list.get(a).getGenre()%>"><img id='t1' src="<%=list.get(a).getUrl()%>"></a></td>
				<td id='t1'><a href="MovieChoice.jsp?mnam=<%=list.get(a+1).getMovie_name()%>&mul=<%=list.get(a+1).getUrl()%>&gen=<%=list.get(a+1).getGenre()%>"><img id='t1' src="<%=list.get(a+1).getUrl()%>"></a></td>
				<td id='t1'><a href="MovieChoice.jsp?mnam=<%=list.get(a+2).getMovie_name()%>&mul=<%=list.get(a+2).getUrl()%>&gen=<%=list.get(a+2).getGenre()%>"><img id='t1' src="<%=list.get(a+2).getUrl()%>"></a></td>
				<td id='t1'><a href="MovieChoice.jsp?mnam=<%=list.get(a+3).getMovie_name()%>&mul=<%=list.get(a+3).getUrl()%>&gen=<%=list.get(a+3).getGenre()%>"><img id='t1' src="<%=list.get(a+3).getUrl()%>"></a></td>
				<td id='t1'><a href="MovieChoice.jsp?mnam=<%=list.get(a+4).getMovie_name()%>&mul=<%=list.get(a+4).getUrl()%>&gen=<%=list.get(a+4).getGenre()%>"><img id='t1' src="<%=list.get(a+4).getUrl()%>"></a></td>
					<%break;
			}
		}
		%>		
		<!-- <td id='t2'><button id='b2' type="button">▶</button></td> -->
	</tr>
	
</table>

	<div class="wrapLeft">
		<img src="../css/넷플렉스.png" width="150" height="80">
	</div>


	<div class="wrap">
		<table style="background-color: black">
			<!-- <h3> -->
			<button id="btn" onclick="location.href='main.jsp'">메인</button>
			<button id="btn" onclick="location.href='recommend.html'">검색</button>
			<button id="btn" onclick="location.href='movieRank.jsp'">전체영화순위</button>
			<button id="btn" onclick="location.href='newmovie.jsp'">개봉예정</button>
			<button id="btn" onclick="location.href='logout.jsp'">로그아웃</button>
			
			<!-- </h3> -->
		</table>
	</div>
</body>
</html>