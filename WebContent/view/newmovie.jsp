<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/css.css">
<style type="text/css">
body {
	color: #ffffff;
}
</style>
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript">

	var obj = new Object() /* JSON 객체 */
	var arr = [] /* JSON 객체 묶어줄 array */
	var arrayAll = [] /* 페이징용 오른쪽 array */
	var arrayAll2 = [] /* 페이징용 왼쪽 array */


	$(document).ready(function() {
<%-- 	alert("<%=session.getAttribute("account") %>" + "님 환영합니다.") --%>
		$.ajax({
			url : "../data/movie.json",
			dataType : "json",
			success : function(result) {
	
				$.each(result, function(key, value) {
					obj = {"name":key, "img":value.img, "url":value.url, "date":value.date, "genre":value.genre, "country":value.country, "director":value.director, "actor":value.actor, "story":value.story};
					arr.push(obj)
				}) /* ajax로 받아온 json array에 넣음 */

				$("#top").append("<div style='color:white; font-size:30px;' class='date_info'>" + arr[0].date
				                   + "</div><br><table align='center'><tr class='movie_info'></tr></table>")
				$(".movie_info:eq(-1)").append("<td class='hah'><a style='cursor:pointer;font-size:30px;' onclick='detail(" 
						 + arr[0].url + "," + index + ")'><img src='" + arr[0].img + "'/><br>" + arr[0].name + "</a></td><td></td>")
				/* 인덱스 비교를 위해 제일 처음 요소만 먼저 출력 */
				/* .date_info : 날짜 출력 자리 */
				/* .movie_info : 영화 포스터, 제목 출력 자리 */
				/* .hah : 이미지 css 효과를 위한 클래스 */
				/* a 태그 (영화 제목) 클릭시 세부 영화 정보 출력하는 함수 호출 : 파라미터 (해당 영화 url, 영화 세부 정보 출력 자리(movie_detail)의 인덱스) */
				
				var index = 0	/* 함수 호출시 파라미터 지정을 위한 인덱스 */						 
				
				/* array 원소 별로 가장 마지막 .date_info의 날짜와 영화의 개봉일 비교 */
				/* 개봉일 일치시 .movie_info 에 append */
				/* 일치하지 않을시 세부 정보 출력 자리 (.movie_detail) 만들고 다음 .date_info, .movie_info 새로 생성 후 영화 포스터, 제목 append */
				/* .movie_detail이 만들어질 때마다 index++ */
				
				var array = [] /* 날짜별로 영화들을 하나로 묶어줄 array */
				array.push(arr[0]) 
				
				for (var i = 1; i < arr.length; i++) {     
					if (arr[i].date == $(".date_info:eq(-1)").text()) {
						var page = paging(index, array)
						array.push(arr[i])
						if (page == false) {
							$(".movie_info:eq(-1)").append("<td class='hah'><a style='cursor:pointer;font-size:30px;' onclick='detail(" 
									 + arr[i].url + "," + index + ")'><img src='" + arr[i].img + "'/><br>" + arr[i].name + "</a></td><td></td>")
						}						
						
					} else {
						/* .time : 카운트 다운 정보 출력 자리 */
						$("#top").append("<br><div class='time'></div><span class='detail_info'></span><hr>")
						$("#top").append("<div style='color:white;font-size:30px;' class='date_info'>" + arr[i].date
				                   + "</div><br><table align='center'><tr class='movie_info'></tr></table>")
					 	index++;
				        $(".movie_info:eq(-1)").append("<td class='hah'><a style='cursor:pointer;font-size:30px;' onclick='detail(" 
												 + arr[i].url + "," + index + ")'><img src='" + arr[i].img + "'/><br>" + arr[i].name + "</a></td><td></td>")
		
						arrayAll2.push([])
						arrayAll.push(array)
						array = [];
						array.push(arr[i])
					}
				}
			}
		})
		
	})
	function paging(index, array) {
		if (array.length == 6) {
			$(".movie_info:eq(" + index + ")").append("<button class='page' value='" + index + "'>다음</button>")
			return true
		} else if (array.length > 6){
			return true			
		} else {
			return false
		}
	}	
	
	$(document).on("click",".page",function(){
		$(this).remove()
		var index = $(this).val()

 		$(".movie_info:eq(" + index + ")").empty()
		$(".movie_info:eq(" + index + ")").append("<button class='bpage' value='" + index + "'>이전</button>")
		
		
		if (arrayAll[index].length > 6) {
			var arraySemi2 = arrayAll[index].reverse()
			for (var i = 0; i < 6; i++) {
			arrayAll2[index].push(arraySemi2.pop())
			}
			var arraySemi = arraySemi2.reverse()
			arrayAll[index] = arraySemi
		}
		
		if (arraySemi.length > 6) {
			for (var i = 0; i < 6; i++) {
				$(".movie_info:eq(" + index + ")").append("<td class='hah'><img src='" + arraySemi[i].img + "'/><br><a style='cursor:pointer' onclick='detail(" 
						 + arraySemi[i].url + "," + index + ")'>" + arraySemi[i].name + "</a></td><td></td>")
			}
			$(".movie_info:eq(" + index + ")").append("<button class='page' value='" + index + "'>다음</button>")
		}
		else {
			for (var i = 0; i < arraySemi.length; i++) {
				$(".movie_info:eq(" + index + ")").append("<td class='hah'><img src='" + arraySemi[i].img + "'/><br><a style='cursor:pointer' onclick='detail(" 
						 + arraySemi[i].url + "," + index + ")'>" + arraySemi[i].name + "</a></td><td></td>")
			}
		}

	})
	
	$(document).on("click",".bpage",function(){
		$(this).remove()
		var index = $(this).val()
		var arraySemi2 = arrayAll2[index]

		$(".movie_info:eq(" + index + ")").empty()
		if (arraySemi2.length > 6) {
			$(".movie_info:eq(" + index + ")").append("<button class='bpage' value='" + index + "'>이전</button>")			
		}
		
		for (var i = arraySemi2.length - 6; i < arraySemi2.length; i++) {
			$(".movie_info:eq(" + index + ")").append("<td class='hah'><img src='" + arraySemi2[i].img + "'/><br><a style='cursor:pointer' onclick='detail(" 
					 + arraySemi2[i].url + "," + index + ")'>" + arraySemi2[i].name + "</a></td><td></td>")
		}
		
		
		var arraySemi = arrayAll[index].reverse()
		for (var i = 0; i < 6; i++) {
			arraySemi.push(arraySemi2.pop())
		}
		arrayAll[index] = arraySemi.reverse()
		arrayAll2[index] = arraySemi2

		$(".movie_info:eq(" + index + ")").append("<button class='page' value='" + index + "'>다음</button>")
		
	})
</script>
<script>

var ddaytimer = null
function detail(url, index) {
	$(".detail_info").empty() /* 함수 호출 시 그전에 있던 모든 detail 정보 비움 */
	
	for (var i = 0; i < arr.length; i++) { /* 파라미터로 받은 url과 같은 영화 찾기 위해 array 전체 탐색 */
		if (arr[i].url == url) { 
			
			/* 1초마다 countdown 함수 실행 후 반환 받은 개봉까지 남은 시간 .time 에 출력 */
			if (ddaytimer != null) {	/* 그 전에 실행중이던 카운트 다운 종료 시키고 .time 자리 비움 */
				clearInterval(ddaytimer)
				$(".time").empty()
			}
			
			var arrTemp = arr[i]
			ddaytimer = setInterval(function() {
			$(".time:eq(" + index + ")").text(countDown(arrTemp.date))
			}, 1000)
				
			/* .detail.info 중 파라미터로 받은 index 번째에 해당 영화의 세부 정보 출력 */
			$(".detail_info:eq(" + index + ")").append("<br><br><table align='center' style='color: white;'><tr><td>이미지</td><td>영화 정보</td></tr><tr><td><img src='"
											+ arr[i].img + "' width='250' height='300'/></td><td>제목 : " + arr[i].name + "<br>개봉일 : " + arr[i].date + "<br>장르 : "
											+ arr[i].genre + "<br>국가 : " + arr[i].country + "<br>감독 : " + arr[i].director + "<br>배우 : " + arr[i].actor
											+ "</td></tr></table><br><br><table align='center'><tr><td width='500'>"
											+ arr[i].story + "</td></tr></table><br>")
		}
	}
}

	function countDown(input) { /* 카운트 다운 용 함수 : 시간 계산 가능 시 개봉까지 남은 시간 반환 */
	    var dday = new Date(input).getTime()
	    var nowday = new Date().getTime()
	    var distance = dday - nowday

	    var d = Math.floor(distance / (1000 * 60 * 60 * 24))
	    var h = Math.floor((distance / (1000*60*60)) % 24)
	    var m = Math.floor((distance / (1000*60)) % 60)
	    var s = Math.floor((distance / 1000) % 60)
	    
	    if (isNaN(d)) {
	    	return
	    } else {
			return "개봉까지 : " + d + "일  " + h + "시간  " + m + "분  " + s + "초"
	    }
	}
</script>	
</head>

<body bgcolor="black" align="center">
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
	<br>
	<br>
	<h1 id="hah">개봉 예정</h1>
	<hr>
	<div id="top"></div>
</body>
</html>