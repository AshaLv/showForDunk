/<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>

<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>the shoe 's payment</title>
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
		//如果没有登入，就提示还未登入，并且跳转到nike页面
				if(j==loginSuccessLength){ 	
				out.println("<script language='javascript'>window.alert('您还未登入哦！');window.location.href='nike.jsp';</script>");
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
	<!--district two-->
	<div align="center"><h2>这是得到鞋子要做的最后一步了哦！</h2></div><br><br><br>
	<!--district three-->
	
	<%
		String shoeSize = request.getParameter("shoeSize");
		String shoeInfoPriceHidden = request.getParameter("shoeInfoPriceHidden");
		String shoeId = request.getParameter("shoeId");
		String shoePayConfirm = request.getParameter("shoePayConfirm");
		String shoeCart = request.getParameter("shoeCart");
		String shoeColor = request.getParameter("shoeColor");
		String shoeInfoQuantity = request.getParameter("shoeInfoQuantity");
		int shoeInfoQuantityTo = Integer.parseInt(shoeInfoQuantity);
		int shoeInfoPriceHiddenTo = Integer.parseInt(shoeInfoPriceHidden);
		int resultTo = shoeInfoQuantityTo * shoeInfoPriceHiddenTo;
		String resultToStr = String.valueOf(resultTo);
		String[] shoeInfo = new String[]{shoeId,shoeColor,shoeSize,shoeInfoQuantity,resultToStr};
	//如果是收到收到购买的submit值，那么确认是购买，直接要求用户输入他的送货地址，以及支付方式
		if(shoePayConfirm != null){
	%>
			<div align="center"><form action="../orderInformation/orderInformation.jsp"  method="get">
				<p>您的地址: <input type="text" name="address" size="50" required ><font color="#800000">&nbsp&nbsp我们会尽快送到哦！</font></p><br><br>
				<p class="payWay">
				您的支付方式: &nbsp&nbsp<input type="radio" name="payWay" value="payWhenGet" required >货到付款&nbsp&nbsp
							  <input type="radio" name="payWay" value="7-eleven" required>7-eleven付款
				</p><br><br>
				<input type="hidden" name="shoeSize" value="<%=shoeSize%>">
				<input type="hidden" name="shoeId" value="<%=shoeId%>">
				<input type="hidden" name="shoeColor" value="<%=shoeColor%>">
				<input type="hidden" name="shoeInfoQuantity" value="<%=shoeInfoQuantity%>">
				<font color="#800000"><p class="finalPay"><input type="submit" name="finalPay" value="确认"></p></font>
			</form></div>
	<%
	}
		//如果是购物车SUBMIT导向到这个网页的话，那么就要记录下鞋子的有关信息到SESSION，这个时候要用到数组
		else if(shoeCart != null){
			session.setAttribute(shoeId,shoeInfo);
			out.println("<script language='javascript'>window.alert('成功加入购物车，继续你的购物之旅');window.location.href='nike.jsp';</script>");
	}	//如果有人直接登入支付网址，则使用户回到购买页
		else{
			out.println("<script language='javascript'>window.alert('您好像并没有挑选商品哦');window.location.href='nike.jsp';</script>");
	}
	%>