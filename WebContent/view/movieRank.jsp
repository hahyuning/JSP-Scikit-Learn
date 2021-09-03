
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/over.css"> <!--수정함  -->
<style type="text/css">
body {
	color: #ffffff;

}
</style> 

<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript">


var obj = new Object()
var arr = []
$(document).ready(function() {
	$.ajax({
		url : "../data/movie_recommendation2.json",
		dataType : "json",
		success : function(result) {
			$.each(result, function(key, value) {
				var array = []
				$.each(value, function(key, value) {
					obj = {"name":key, "url":value}
					array.push(obj)
				})
				arr.push(array)
			})
			for (var i = 0; i < arr.length; i++) {
				$("#div").append("<div id='movie_info' align='center'>" + (i + 1) + "위 : " + arr[i][0].name 
						+ "<br><a style='cursor:pointer;font-size:30px;' onclick='detail(" 
						+ i + ")'><img width='150' src='" + arr[i][0].url + "'/></a></div><div class='movie' align='center'></div><hr>")
			}

		}
	})
})

	function detail(i) {
		console.log(arr.length)
		$(".movie").empty()
		$(".movie:eq(" + i + ")").append("<br>위 영화와 유사한 영화<br><br>")
		for (var j = 1; j < 6; j++) {
			$(".movie:eq(" + i + ")").append("<div style='float: left; width: 20%'>"+ arr[i][j].name + "<br><img width = '150' src='" + arr[i][j].url + "'/></div>")
		}
		$(".movie:eq(" + i + ")").append("<br><br><br><br><br><br><br>")
	}
</script>

</head>

<body bgcolor="black" align="center">
	<div class="wrapLeft">
		<img src="../css/넷플렉스.png" width="150" height="80">
	</div>
	
<body bgcolor="black">
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
<br>
<br>
<h1 align='center'>전체 영화 순위</h1>
<div id="div"></div>
</body>
</html>