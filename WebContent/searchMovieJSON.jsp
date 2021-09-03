<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
<script type="text/javascript">
   $(document).ready(function() {
      $("#search").click(function() {
         $.ajax({
            url : "<c:url value="/MovieServiceJSON"/>",
            type : "post",
            dataType : "json",
            data : {
               query : $("#query").val()
            },
            success : function(json) {
               
               $.each(json.items,function(i,item){
                  console.log(item.title);
                  $("#movieResult").append(
                           "<tr>"+"<td width='100'><img src='"+item.image+"'></td>"+
                              "<td width='300'><a href='"+item.link+"'>"+item.title+"</a></td>"+
                              +"</tr>"
                        );
               });
            },
            error : function(err) {
               alert("에러");
            }
         });
      });
   });
</script>
</head>
<body>
   <input type="text" id="query" name="query">
   <input type="button" id="search" value="moviesearch"><br><br>
   <table id="movieResult" align="left" border="1" ></table>
</body>
</html>
