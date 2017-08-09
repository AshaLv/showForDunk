<%@ page contentType="text/html; charset=utf-8" import="java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>quit</title>
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="shoeForDunk.css">
</head>
<body>	
	<!--用js确认用户是否确定要真的退出,用confirm方法，然后用if语句引导，如果确定就导向quit.html-->
	<script>if(confirm("您确定要退出吗?")){
	window.location.href = "http://localhost:8080/shoeForDunk/quitBridge.jsp";
	}
	else{
	window.location.href = "http://localhost:8080/shoeForDunk/shoeForDunk.jsp";
	}
	</script>	
</body>
</html>