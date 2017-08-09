<%@ page contentType="text/html; charset=utf-8" import="java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>cart</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../shoeForDunk.css">
</head>
<body>
<%
String sessionDelete = request.getParameter("shoeId");
session.removeAttribute(sessionDelete);
out.println("<script language='javascript'>window.alert('删除成功！');window.location.href='cart.jsp';</script>");
%>
	
</body>
</html>