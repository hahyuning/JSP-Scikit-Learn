<%@page import="java.io.Console"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Collections"%>
<%@page import="bean.MovieDTO"%>
<%@page import="bean.SelectDTO"%>
<%@page import="bean.SelectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<!-- 헤드 -> 링크 연동 -->
<meta charset="UTF-8">
<title>Insert title here</title>
<!--script, css링크 부분은 title아래가 보통!! -->
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<link rel="stylesheet" type="text/css" href="../css/over.css">
<!-- CSS 효과 -->
<style type="text/css">
body {
	color: #ffffff;
}
</style>
</head>

<%
String account = (String)session.getAttribute("account"); //Session 계정명 -> 변수명지정
SelectDAO dao = new SelectDAO(); //dao 선언
%>

<body bgcolor="black">
	<!-- <div class="wrapLeft"> -->
		<img src="../css/넷플렉스.png" width="150" height="80">
	<!-- </div> -->


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




	<!-- 나중에 세션만 받아오면됨. -->
	<!-- 로그인 계정정보 -->


	<br>


	<br>
	<!-- 사용자 이름 -->
	<div class='font'>
		<br> <br>
		<%=account%> 님 영화 화면입니다.
		<!-- 메인 영역 시작-->
		<br> <br>
		<div id="comingM">
			<hr color="red" size="10">
			<!-- 메인 포스터 영역 -->
			<img src="../css/머니헤이스트.jpg"
				style="margin-left: auto; margin-right: auto; display: block;"
				width="600" height="600">
		</div>
		<!--  -->



		<!-- 최근에본 영화 -->

		<hr>
		최근에 본 영화
		<div id="lastM">
			<table border="0">
				<tr align="center" height="300">

					<!-- 내가 본 영화 Play  -->
					<!-- aDto는 계정의 play 칼럼에 있는 영화 목록임-->
					<!-- String aDto(입력 넣었을때) -> 해당하는 이미지 가져옴-->

					<%
					
					String playList = "";
					String[] accountMovie = dao.myMovie(account); //내가 본 영화  = account 계정의 play 영화칼럼 
					int len = accountMovie.length; // 내가 본 영화 배열 길이
					String[] arrayGenre = new String[len]; //내가 본 영화 배열  
					String[] lgTitle = new String[len]; //aDto 장르 넘기기 위한 배열

					for (int i = 0; i < len-1; i++) {
						playList += accountMovie[i] + ",";
				
					} 

					String[] genR = new String[len]; // 장르 추천 배열
					for (int i = len - 1; i >= 0; i--) { // i = 7 , 7 >=0, 6
						String aDto = accountMovie[i]; // Adto = 7번(마지막)
						String url = dao.returnUrl(aDto); // url = aDto(마지막 URl)
						String rGen = dao.returnGenre(aDto);
						arrayGenre[i] = aDto; //ArrayGenre는 장르별로 추천할 영화명이 들어감.
					%>

					<!-- aDto -->
			
					<td class="mImg" width="400">
					<a href= "MovieChoice.jsp?mnam=<%=aDto%>&mul=<%=url%>&gen=<%=rGen%>"> 
						<img width="150" height="150"src="<%=url%>"/><br>
						<button type="button" name="<%=aDto%>" value="<%=aDto%>"
							id="mainButton"><%=aDto%></button>
					<!-- 버튼클릭시 주소 + 영화 타이틀 값 넘김 --></a></td>
				
					
					<%
						}
					%>
					
				</tr>
			</table>
		</div>


		<!-- -------------최근에 본 영화 종료----------------- -->
		<!-- 장르별 영화 추천 -->
		<div id="genre">

			<%
				for (int k = len - 1; k >= 0; k--) { //내가 본 영화 인덱스만큼, 영화 추천 
				genR[(k)] = arrayGenre[k]; //영화제목을 GenR 인덱스에 입력
				ArrayList<MovieDTO> genreRecommendT = dao.recomGenre(genR[(k)]); //장르별 영화리스트(**)
				String gTitle = genreRecommendT.get(0).getGenre(); //그 영화명에 해당하는 장르명을 가지고 왔음.				
			%>
			<h3 style="color: red" id='hrs'><%=gTitle%></h3>
			<!-- 그 영화명에 해당하는 장르명을 찍음. -->
			<table border="0" align="center">
				<tr align="center" height="300">

					<%
						for (int f = 0; f < genreRecommendT.size(); f++) { // 내가 본 영화 Size(길이) 만큼, 장르 별 영화를 가져옴(limit = 10)
						//ArrayList<MovieDTO> genreRecommend = dao.recomGenre(genR[(k)]);
						
					%>
					<td class="mImg" width="400">
					<a href= "MovieChoice.jsp?mnam=<%=genreRecommendT.get(f).getMovie_name()%>&mul=<%=genreRecommendT.get(f).getUrl()%>&gen=<%=genreRecommendT.get(f).getGenre() %>">
						<img class="ii" width="110"
						height="110" src="<%=genreRecommendT.get(f).getUrl()%>"
						alt="<%=genreRecommendT.get(f).getMovie_name()%>" /><br>
						
						</a>
						<button type="button"
							name="<%=genreRecommendT.get(f).getMovie_name()%>"
							value="<%=genreRecommendT.get(f).getMovie_name()%>" id="btUpdate"><%=genreRecommendT.get(f).getMovie_name()%>
						
						</button> <!-- 버튼클릭시 주소 + 영화 타이틀 값 넘김 --> <!-- 	</a> -->
						
						
					</td>

					<%
						}
					%>

				</tr>
			</table>
		</div>


		<%
			}
		%>
<!--
<script type="text/javascript">
/* button 클릭 -> db에 영화 업데이트 */
$(function() {
	$('img').click(function() {
		playValue = '<%=playList%>' + $(this).attr('alt')
		console.log(playValue)
		$.ajax({
			url : '../model/updateMovie.jsp',
			data : { //괄호는 묶어준다
					play : playValue,
					account_name : '<%=account%>'
					},
			success : function(result) {
					console.log('db에 전송 성공!')
						}
					})
				})
			})
</script>
 -->
<!-- 장르별 영화 추천 종료 -->
	</div>
	<!-- font css -->
	</div>
	<!-- Main 끝나는부분 -->

	
	
</body>
</html>