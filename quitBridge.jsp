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
	<!--删除COOKIE-->
	<%
	Cookie[] loginSuccess = request.getCookies();//取loginSuccess为Cookie数组的名字，取得所有Cookie		
	if(loginSuccess != null ){	//如果Cookie存在的话
	/*int loginSuccessLength = loginSuccess.length;//取得Cookie数组的存放数量，用length方法，并且把值给定义为INT型的loginSuccessLength
	for(int i=0; i<loginSuccessLength;i++){		//循环比对所有Cookie的名称
	//用getName（）的方法，取得Cookie的名称，然后用equals（）的方法比对登入成功的Cookie名称
	loginSuccess[i].setMaxAge(0);
	String path = "/";
	loginSuccess[i].setPath(path);
	loginSuccess[i].setValue(null);
	//将名称为loginSuccess的Cookie的生命周期生为0
	response.addCookie(loginSuccess[i]);//将已经定义好的生命周期给loginSuccess，用response物件的addCookie（）方法

	}*/
	Cookie loginSuccess1 = new Cookie("loginSuccess",null);
	String path =  "/shoeForDunk/";
			loginSuccess1.setPath(path);
		    
			response.addCookie(loginSuccess1);
}
	//如果没有登入，就提示还未登入，并且跳转到登入页面
	else{
	out.println("<script language='javascript'>window.alert('您还未登入哦！');window.location.href='http://localhost:8080/shoeForDunk/login/loginFirst.jsp';</script>");
	}


	//删除SESSION
	Enumeration sessionAllName = session.getAttributeNames();//这里有所有的session，通过Enumeration物件去NEW一个物件名称为sessionAllName，并且值传递是通过session物件的getAttributeNames（）方法
	while (sessionAllName.hasMoreElements()){	//新增的名字为sessionAllName继承Enumeration物件的物件用hasMoreElements（）方法去判断里面是否有值
	String theOrderInCart[] = (String[])session.getAttribute(sessionAllName.nextElement().toString());//用Enumeration物件的nextElement（）方法去得到每一个循环所匹配到的session名称，然后用session物件的getAttribute（）方法去得到值
	session.removeAttribute(theOrderInCart[0]);//删除所有得到的session，用session物件的removeAttribute（）方法
	}
	%>
	<!--district one-->
	<div class="header">	
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<h1>shoeForDunk</h1>
				<div class="row navOne">
					<a href="http://localhost:8080/shoeForDunk/shoeForDunk.jsp"><div class="col-lg-1">首页</div></a>
					<div class="col-lg-5"></div>
					<div class="col-lg-1 "></div>
					<a href="http://localhost:8080/shoeForDunk/login/loginFirst.jsp"><div class="col-lg-1">登入</div></a>
					<a href="http://localhost:8080/shoeForDunk/information/information.jsp"><div class="col-lg-1">个人信息</div></a>
					<a href="http://localhost:8080/shoeForDunk/cart/cart.jsp"><div class="col-lg-1">购物车</div></a>
					<a href="http://localhost:8080/shoeForDunk/register/registerFirst.jsp"><div class="col-lg-1">注册</div></a>
					<a href="http://localhost:8080/shoeForDunk/quit.jsp"><div class="col-lg-1">登出</div></a>					
				</div>
			</div>
		</nav>
	</div>
	<div align="center"><h2 class="quit">您已经成功登出！<br>欢迎下次再来！</h2></div>
</body>
</html>


	
