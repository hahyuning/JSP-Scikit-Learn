<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript">
$(function() {
	$('#b1').click(function() { //DB 넣기
		$("#d1").empty();
		$.ajax({ 
			url : 'https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Fwww.chosun.com%2Fsite%2Fdata%2Frss%2Frss.xml&api_key=g4a9wu6xqu8pjy4zmlwq6d4h814krgc3valwrslr', //외부서버
			data : { //데이터를 보낸다.
				url: '', //원래 URL
				api_key: 'g4a9wu6xqu8pjy4zmlwq6d4h814krgc3valwrslr',// 파라미터라 꼭 api_key로 써줘야함, 발급받은 키 
				count: 20 
			}, // **꼭 쉼표!//		
			success : function(doc) {
				console.log('연결 성공' + doc)
				items = doc.items
				console.log(items.length)
				if (items.length > 0 ) {
					$(items).each(function(i, news) {
						console.log(news.title)
						console.log(news.pubDate)
						console.log(news.author)
						title = news.title
						date = news.pubDate
						author = news.author
						total = "제목 : " + title + " 날짜 : " + date + " 작가 : "+ author + "<br>"
						$("#d1").append(total);
						
						$.ajax({
							url : 'db3.jsp',
							data : { //괄호는 묶어준다
								title: title,
								date : date,
								author : author,
							},
							success : function(result) {
								console.log('db에 전송 성공!')
							}
						})
					})
					
				}
		 	} //success
		}) //ajax
	}) //click 
	
	$('#b2').click(function() { //조선일보 
		$("#d1").empty();
		$.ajax({ 
			url : 'https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Fwww.chosun.com%2Fsite%2Fdata%2Frss%2Fculture.xml&api_key=g4a9wu6xqu8pjy4zmlwq6d4h814krgc3valwrslr', //외부서버
			data : { //데이터를 보낸다.
				url: '', //원래 URL
				api_key: 'g4a9wu6xqu8pjy4zmlwq6d4h814krgc3valwrslr',// 파라미터라 꼭 api_key로 써줘야함, 발급받은 키 
				count: 20 
			}, // **꼭 쉼표!//		
			success : function(doc) {
				console.log('연결 성공' + doc)
				items = doc.items
				console.log(items.length)
				if (items.length > 0 ) {
					$(items).each(function(i, news) {
						console.log(news.title)
						title = news.title
						link = news.link
						thumbnail = news.thumbnail
						
						total = "<img src=" + thumbnail + ">" + "제목 : " + "<a href="+ link +"> " + title + "</a>"  +  "이미지 : "  + "<br>" ;
						$("#d1").append(total);
					})
					
				}
		 	} //success
		}) //ajax
	}) //click 
	
	$('#b3').click(function() { //조선일보 
		$("#d1").empty();
		$.ajax({ 
			url : 'https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Fwww.chosun.com%2Fsite%2Fdata%2Frss%2Fent.xml&api_key=g4a9wu6xqu8pjy4zmlwq6d4h814krgc3valwrslr', //외부서버
			data : { //데이터를 보낸다.
				url: '', //원래 URL
				api_key: 'g4a9wu6xqu8pjy4zmlwq6d4h814krgc3valwrslr',// 파라미터라 꼭 api_key로 써줘야함, 발급받은 키 
				count: 20 
			}, // **꼭 쉼표!//		
			success : function(doc) {
				console.log('연결 성공' + doc)
				items = doc.items
				console.log(items.length)
				if (items.length > 0 ) {
					$(items).each(function(i, news) {
						console.log(news.title)
						title = news.title
						link = news.link
						thumbnail = news.thumbnail
						
						total = "<img src=" + thumbnail + ">" + "제목 : " + "<a href="+ link +"> " + title + "</a>"  +  "이미지 : "  + "<br>" ;
						$("#d1").append(total);
					})
					
				}
		 	} //success
		}) //ajax
	}) //click 
}) //main

</script>
</head>
<body>

	<button id="b1">DB로 옮기기</button>
	<hr>
<div id = 'd1'></div>

</body>
</html>