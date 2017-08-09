<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<html lang="utf-8">
<head charset=utf-8>
<title>shoeForDunk</title>
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="shoeForDunk.css">

</head>
<body>
	<!--取得登入信息的COOKIE-->
	<%
		Cookie[] loginSuccess = request.getCookies();//取loginSuccess为Cookie数组的名字，取得所有Cookie
		String noUserName="您还未登录";//没有登入的话，就显示这个提醒		
		String loginNameCookie = "";//Cookie中存放的是登入者的信息，先定义一个String来存放
		if(loginSuccess != null ){	//如果Cookie存在的话
		 int loginSuccessLength = loginSuccess.length;//取得Cookie数组的存放数量，用length方法，并且把值给定义为INT型的loginSuccessLength
		 for(int i=0; i<loginSuccessLength;i++){	//循环比对所有Cookie的名称
		 	if(loginSuccess[i].getName().equals("loginSuccess") ){	//用getName（）的方法，取得Cookie的名称，然后用equals（）的方法比对登入成功的Cookie名称
		 	loginNameCookie = loginSuccess[i].getValue();	//将比对成功的Cookie值传给初始定义的loginNameCookie
		 	if(loginNameCookie != ""){
		 	break; //跳出循环
		 	}
		 	}
		 	loginNameCookie = noUserName;		 	
		 } 			
	}
		else{	//如果电脑中没有任何Cookie信息的话
		 loginNameCookie = noUserName;
	}
	%>
	<!--district one导航条-->
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
	<!--district two搜索引擎-->
	<div class="sectionOne">
		<div class="container">
			<div class="row sectionOne1">
				<div class="col-lg-4"></div>
				<div class="col-lg-4">		
					球鞋品牌店：<input type="text" name="searchShop" id="searchShop" >
					<button type="button"   onclick="myFunction()">进入商店</button>	
				</div>
				<div class="col-lg-4"></div>
			</div>
		</div>
	</div>
	<hr>
	<h2><font color="black">选择你喜欢的球鞋品牌:</font></h2>	
	<hr>
	<!--district three商店的图片链接-->
	<div class="sectionTwo">
		<div class="container">
			<div class="row sectionTwo1">
				<div class="col-lg-2"></div>
				<a href="http://localhost:8080/shoeForDunk/nikeShop/nike.jsp"><div class="col-lg-3"><img src="nikeShop/img/nikeBrand.jpg" alt="NIKE" width="300px" height="300px"></div></a>
				<div class="col-lg-2"></div>
				<a href="http://localhost:8080/shoeForDunk/adidasShop/adidas.jsp"><div class="col-lg-3"><img src="adidasShop/img/adidasBrand.jpg" alt="ADIDAS" width="300px" height="300px"></div></a>
			</div> 
				<div class="col-lg-2"></div>
		</div>
	</div>
	<!--js search-->
	<script>
			function myFunction() 
			{
			var shopName = document.getElementById("searchShop").value;//将文本框中的资料传到shopName这个变量
			var matchShopNameNike = /n/i.test(shopName);//用test（）方法去匹配shopName里是否包含NIKE的‘n’
			var matchShopNameAdidas = /a/i.test(shopName);//		用test（）方法去匹配shopName里是否包含ADIDAS的‘a’	
			if (matchShopNameNike) {	//如果匹配到nike的话，那么将传回ture	
			window.location.href="nikeShop/nike.jsp";	//用window.location.href导向nike的商店
			}
			else if (matchShopNameAdidas) {	//如果匹配到adidas的话，那么将传回ture
			window.location.href="adidasShop/adidas.jsp";//用window.location.href导向adidas的商店
			}
			else 
			{
			window.alert("亲，这里只有nike和adidas");//如果文本框里的字母完全没有nike和adidas的信息就弹出提醒框
			}
	}
	</script>
</body>
</html>