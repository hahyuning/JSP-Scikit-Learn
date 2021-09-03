<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>



<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<script src="./js/jquery-1.11.2.min.js"></script>
<title> </title>
<script>
	var client_id = '아이디';ㅉ
	var client_secret = '패스워드';
	var strText = "테스트입니다.";
	$(document).ready(function(){
		$("button").click(function(){
			$.ajax({
				type: 'POST',
				url: 'https://openapi.naver.com/v1/voice/tts.bin',
				headers: {
					'Content-Type':'application/x-www-form-urlencoded',
					'X-Naver-Client-Id':client_id,
					'X-Naver-Client-Secret': client_secret
				},
				data: {'speaker': 'jinho', 'speed': 0, 'text': strText},
				
				success: function(msg){
					mp3file = new Blob([msg], {
					  type: 'audio/mp3'
					});
					console.log(msg)
					window.navigator.msSaveOrOpenBlob(mp3file,"test.mp3")
				},
				error: function(request, status, error){
					alert("에러 :  " + request.status + "  " + request.reponseText);
				}
			})
		})
	})