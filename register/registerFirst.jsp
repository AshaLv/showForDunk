<%@ page contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>register</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../shoeForDunk.css">
<link rel="stylesheet" href="register.css">
</head>
<body>	
	<!--取得登入信息的COOKIE-->
	<%
		Cookie[] loginSuccess = request.getCookies();//取得客户端电脑保存的COOKIE信息，存于COOKIE数组loginSuccess
		String userName="您还未登录";
		String loginNameCookie = "";
		if(loginSuccess != null ){	//查看对于对象类型的COOKIE数组loginSuccess是否为空
		 int loginSuccessLength = loginSuccess.length;//用对象类型的.length方法取得数组对象中包含的cookie数量
		 for(int i=0; i<loginSuccessLength;i++){	//循环得到所有数组里面每个单元信息
		 	if(loginSuccess[i].getName().equals("loginSuccess")){ //用Cookie对象的.getName的方法以及数组equals方法去比对cookie的名字是否有叫做loginSuccess
		 	loginNameCookie = loginSuccess[i].getValue();	//让符合的COOKIE值赋予String型别的loginNameCookie
		 	break;	//一旦查找到登入者信息cookie就跳出循环
		 	}
		 	loginNameCookie = userName;		//若找不到登入信息
		 }
	}
		else{
		 loginNameCookie = userName;	//若客户端电脑里完全没有cookie
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
					<a href="http://localhost:8080/shoeForDunk/register/register.jsp"><div class="col-lg-1">注册</div></a>
					<a href="http://localhost:8080/shoeForDunk/quit.jsp"><div class="col-lg-1">登出</div></a>
				</div>
			</div>
		</nav>
	</div>
	<!--district two-->
	<h2><div align="center">欢迎注册shoeForDunk帐号</div></h2>
	<hr class="hrOne">
	<div class="registerSectionOne">
		<div class="container">
			<div class="row">
				<form action="register.jsp" name="registerFormOne" method="post">
				<div class="col-lg-12 registerRowOne" align="center">您的帐号：<input type="text" name="registerName" id="registerName" required></div><br>
				<div class="col-lg-12 registerRowOne" align="center">您的密码：<input type="password" name="registerPsd" required></div><br>
				<div class="col-lg-12 registerRowOne registerRepsd" align="center">确认您的密码：<input type="password" name="registerRepsd" required></div>
				<div class="col-lg-12 registerRowOne" align="center">您的邮箱：<input type="email" name="registerEmail" id="registerEmail" required></div><br>
				<div class="col-lg-12 registerRowOne" align="center"><input type="submit" name="registerSubmit" value="注册"></div><br>
				</form>
			</div>
		</div>
	</div>
	<!--js获取参数 但是好像在这个区块没有意义mark it-->
				<script language = javascript> 
					function request(paras){ 
							var url = location.href;  
							var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");  
							var paraObj = {}  
							for (i=0; j=paraString[i]; i++){  
								paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);  
						}  
							var returnValue = paraObj[paras.toLowerCase()];  
							if(typeof(returnValue)=="undefined"){  
								return "";  
						}	else{  
								return returnValue;  
						}  
					} 
					var registerName=request('registerName');	 
					var registerEmail=request('registerEmail'); 
					document.getElementById("registerName").value=registerName;
					document.getElementById("registerEmail").value=registerEmail;
					
				</script>
</body>
</html>