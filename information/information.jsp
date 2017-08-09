<%@ page contentType="text/html; charset=utf-8" import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%!
//预定义
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
//建立链接数据库的生命周期
public void jspInit()
{
	try{
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		//con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\shoeForDunk\\shoeForDunk.mdb");
		con=DriverManager.getConnection("jdbc:odbc:shoeForDunk");
		stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		
		
	}
	catch(Exception ex){
		System.out.println(ex.toString());
	}


}

public void jspDestroy()
{
try{
	rs.close();
	stmt.close();
	con.close();
}
catch(Exception ex){
		System.out.println(ex.toString());
	}
}
%>
<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>your information</title>
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
					 		if(loginNameCookie != ""){
		 	                   break; //跳出循环
		                   	}
		                   	else{out.println("<script language='javascript'>window.alert('您还未登入哦！');window.location.href='http://localhost:8080/shoeForDunk/login/loginFirst.jsp';</script>");
		                   	}
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

	<!--取得数据库里面的用户人信息-->
	<%
	
	rs=stmt.executeQuery("Select registerEmail from registerShoeForDunk where registerName='"+loginNameCookie+"'");
	rs.next();
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

	<!--放置基本的个人信息-->
	<div class="sectionPersonalInformation personalInformationRegisterName">
		<div class="container">
			<div class="row ">
				<div class="col-lg-4"></div>
				<div class="col-lg-4">您的账户名称：<%=loginNameCookie%></div>
				<div class="col-lg-4"></div>
			</div>
			<br>
			<div class="row ">
				<div class="col-lg-4"></div>
				<div class="col-lg-4">您的邮箱账号:<%=rs.getString("registerEmail")%></div>
				<div class="col-lg-4"></div>
			</div>
			<br>
			<div class="row ">
				<div class="col-lg-4"></div>
				<div class="col-lg-1">
						<!--bootstrap的登录效果模板-->

						<div align="center"><button type="button" class="btn btn-primary btn-lg loginButton" data-toggle="modal" data-target="#myModal">
						  修改密码
						  
						
						</button></div>

						<!-- Modal -->
						<div class="modal fade loginFade informationPsd" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							 <div class="modal-dialog">
								    <div class="modal-content ">
									      <div class="modal-header">
										        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
										        <h4 class="modal-title" id="myModalLabel">shoeForDunk欢迎您</h4>
										  </div>
												      <div class="modal-body">
												        <form action="changeInformation.jsp" method="post" name="informationFormPsd">
												        	<p>您的旧密码：<input type="password" name="oldPsd" required></p>
												        	<p>您的新密码：<input type="password" name="newPsd" required></p>
												        	<p>再次确认新密码：<input type="password" name="reNewPsd" required></p>
												        	<input type="submit" name="informationSubmitPsd" value="确认修改">
												        </form>
												      </div>
												      <div class="modal-footer">
												        
												      </div>
									</div>
							</div>
						</div>					

				</div>
				<div class="col-lg-3">
						<!--bootstrap的登录效果模板-->

						<div align="center"><button type="button" class="btn btn-primary btn-lg loginButton" data-toggle="modal" data-target="#myModal2">
						  修改邮箱
						  
						
						</button></div>

						<!-- Modal -->
						<div class="modal fade loginFade informationEmail" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							 <div class="modal-dialog">
								    <div class="modal-content ">
									      <div class="modal-header">
										        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
										        <h4 class="modal-title" id="myModalLabel">shoeForDunk欢迎您</h4>
										  </div>
												      <div class="modal-body">
												        <form action="changeInformation.jsp" method="post" name="informationFormEmail">
												        	<p>您的新邮箱：<input type="email" name="newEmail" required></p>
												        	<input type="submit" name="informationSubmitEmail" value="确认修改">
												        </form>
												      </div>
												      <div class="modal-footer">
												        
												      </div>
									</div>
							</div>
						</div>					
										
				</div>
				<div class="col-lg-4"></div>
			</div>
		</div>
	</div>
	<!--放置用户已经下的订单信息-->
	<div class="sectionProductInformation"></div>

	<!--引进bootstrap的js-->
	<script src="jquery-1.12.4.js"></script>
	<script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script> 
	
</body>
</html>