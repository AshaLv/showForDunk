<%@ page contentType="text/html; charset=utf-8" import="java.util.*,java.sql.*"%>
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
	<!--取得登入信息的COOKIE-->
	<%
		Cookie[] loginSuccess = request.getCookies();
		String userName="您还未登录";
		//Cookie temp = new Cookie("temp",userName);
		
		String loginNameCookie = "";
		int j;
		if(loginSuccess != null ){
		int loginSuccessLength = loginSuccess.length;
			for(int i=0; i<1;i++){
				for( j = 0; j<loginSuccessLength;j++){
					 	if(loginSuccess[j].getName().equals("loginSuccess")  ){
					 	loginNameCookie = loginSuccess[i].getValue();
					 	break;
					 	}
					 }
		//如果没有登入，就提示还未登入，并且跳转到登入页面
				if(j==loginSuccessLength){ 	
				out.println("<script language='javascript'>window.alert('您还未登入哦！');window.location.href='http://localhost:8080/shoeForDunk/login/loginFirst.jsp';</script>");
		//必须运用response物件的flushBuffer()方法强制输出，不然会报错
				response.flushBuffer();	
				}
				 	
			}
					
		}
		else{
		 out.println("<script language='javascript'>window.alert('您还未登入哦！');window.location.href='http://localhost:8080/shoeForDunk/login/loginFirst.jsp';</script>");
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
					<div class="col-lg-1 "><font color="green"  ><%=loginNameCookie%></font></div></a>
					<a href="http://localhost:8080/shoeForDunk/login/loginFirst.jsp"><div class="col-lg-1">登入</div></a>
					<a href="http://localhost:8080/shoeForDunk/information/information.jsp"><div class="col-lg-1">个人信息</div></a>
					<a href="http://localhost:8080/shoeForDunk/cart/cart.jsp"><div class="col-lg-1">购物车</div></a>
					<a href="http://localhost:8080/shoeForDunk/register/registerFirst.jsp"><div class="col-lg-1">注册</div></a>
					<a href="http://localhost:8080/shoeForDunk/quit.jsp"><div class="col-lg-1">登出</div></a>
				</div>
			</div>
		</nav>
	</div>
	<div align="center"><h2>这里是你的购物车！</h2></div>
	<%
	Enumeration sessionAllName = session.getAttributeNames();//这里有所有的session
	while (sessionAllName.hasMoreElements()){
	String theOrderInCart[] = (String[])session.getAttribute(sessionAllName.nextElement().toString());
	if(theOrderInCart[0].indexOf("n") != -1){
	String shoeOrderInfo = "<div class=container><div class=row cartCss><div class=col-lg-3><img src=../nikeShop/img/"+theOrderInCart[0]+" alt=></div><div class=col-lg-2></div><div class=col-lg-2><font size=5px color=#800000 style=position:relative;top:110px; >颜色："+theOrderInCart[1]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px; >鞋子大小："+theOrderInCart[2]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px; >购买数量："+theOrderInCart[3]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px;>总金额："+theOrderInCart[4]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px;><a href=cartDelete.jsp?shoeId="+theOrderInCart[0]+">删除</a></font></div></div></div>";
	out.print(shoeOrderInfo);
	}
	else if(theOrderInCart[0].indexOf("a") != -1){
	String shoeOrderInfo = "<div class=container><div class=row cartCss><div class=col-lg-3><img src=../adidasShop/img/"+theOrderInCart[0]+" alt=></div><div class=col-lg-2></div><div class=col-lg-2><font size=5px color=#800000 style=position:relative;top:110px; >颜色："+theOrderInCart[1]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px; >鞋子大小："+theOrderInCart[2]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px; >购买数量："+theOrderInCart[3]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px;>总金额："+theOrderInCart[4]+"</font></div><div class=col-lg-1><font size=5px color=#800000 style=position:relative;top:110px;><a href=cartDelete.jsp?shoeId="+theOrderInCart[0]+">删除</a></font></div></div></div>";;
	out.print(shoeOrderInfo);
	}
	else{
	out.print("<div align=center><font size=10px color=#800000 >购物车里空空的!</font></div>");
	}
	}
	%>
	<div align="center"><form action="cartCheck.jsp"  method="get">
				<p>您的地址: <input type="text" name="address" size="50" required ><font color="#800000">&nbsp&nbsp我们会尽快送到哦！</font></p><br><br>
				<p class="payWay">
				您的支付方式: &nbsp&nbsp<input type="radio" name="payWay" value="payWhenGet" required >货到付款&nbsp&nbsp
							  <input type="radio" name="payWay" value="7-eleven" required>7-eleven付款
				</p><br><br>
				
				<font color="#800000"><p class="finalPay"><input type="submit" name="finalPay" value="确认"></p></font>
	</form></div>
</body>
</html>