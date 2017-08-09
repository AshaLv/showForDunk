<%@ page contentType="text/html; charset=utf-8"  %>
<% request.setCharacterEncoding("utf-8"); %>
<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>login</title>
<!--<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">-->
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../shoeForDunk.css">
<link rel="stylesheet" href="login.css">

</head>
<body>	
	<!--取得登入信息的COOKIE-->
	<%
		Cookie[] loginSuccess = request.getCookies();
		String userName="您还未登录";
		//Cookie temp = new Cookie("temp",userName);
		
		String loginNameCookie = "";
		if(loginSuccess != null ){
		 int loginSuccessLength = loginSuccess.length;
		 for(int i=0; i<loginSuccessLength;i++){
		 	if(loginSuccess[i].getName().equals("loginSuccess")){
		 	loginNameCookie = loginSuccess[i].getValue();
		 	break;
		 	}
		 	loginNameCookie = userName;
		 	
		 }
		 


			
	}
		else{
		 loginNameCookie = userName;
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
	<!--bootstrap的登录效果模板-->
	<div align="center"><h2>这里是登录界面哦，登入进去你才可以完全使用shoeForDunk!</h2></div>
	<div align="center"><button type="button" class="btn btn-primary btn-lg loginButton" data-toggle="modal" data-target="#myModal"  >
	  登入shoeForDunk
	</button></div>


	<!-- Modal -->
	<div class="modal fade loginFade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		 <div class="modal-dialog">
			    <div class="modal-content">
				      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					        <h4 class="modal-title" id="myModalLabel">shoeForDunk欢迎您</h4>
					  </div>
							      <div class="modal-body">
							        <form action="login.jsp" method="post" name="loginForm">
							        	<p>您的帐号：<input type="text" name="loginName" required></p>
							        	<p>您的密码：<input type="password" name="loginPsd" required></p>
							        	<input type="submit" name="loginSubmitLogin" value="登入">			    	
							        </form>
										<a href="http://localhost:8080/shoeForDunk/register/registerFirst.jsp" ><font color="black"><button class="registerButtonLink">注册</button></font></a>
							      </div>
							      <div class="modal-footer">
							        
							      </div>
				</div>
		</div>
	</div>

	<!--引进bootstrap的js-->
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="../information/jquery-1.12.4.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/js/bootstrap.min.js">
    </script>

	
	

	
</body>
</html>	