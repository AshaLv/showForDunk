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
<title>adidasShop</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../shoeForDunk.css">
<link rel="stylesheet" href="cart.css">

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
		
	%>
	<!--district one-->
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
	
	<div class="sectionNikeOne">
		<div align="center" class="adidasShopHeadline"><h2 class="adidasHeadline"><font color="  #380000  " >Adidas商店专区</font></h2></div>
		<h2 class="adidasH2"><font color="  #380000   ">挑选一双Adidas篮球鞋去扣篮吧!!</font></h2>
		<div class="container">
		<!--用form表单使用户可以选择价格-->
		<form action="adidas.jsp">
			<input type="range" name="price" min="0" max="6000" value="6000">
  			<input type="submit" name="priceSubmit" value="上面是价位条，你可移动到你想要的价位区间,确认后记得点击按钮">
		</form>
		<!--用for循环的方式将数据库资料表nike中的信息全部取出-->
			<%	
			//如果价位条没有被移动，那么正常显示所有商品
			if (request.getParameter("priceSubmit")==null) {
						
			rs = stmt.executeQuery("Select * from adidas ");
			rs.last();
			int rowCount = rs.getRow();
			rs.beforeFirst();
			
			while(rs.next()){
			%>
			<div class="row">
				<div class="col-lg-2"></div>
				
				<div class="col-lg-4 adidasShoeSingle">
				
					<div class="row">
						<div class="col-lg-12"><img src='img/<%=rs.getString("adidasShoeImg")%>' alt='<%=rs.getString("adidasShoeId")%>' width="222" height="222"></div>
					</div>
					<div class="row">
						<div class="col-lg-1"></div>
						<div class="col-lg-5"><font color="#800000" size="6px"><%=rs.getString("adidasShoePrice")%> TWD</font></div>
						<!--用tag a 传参数到adidasShoeConcreteInformation,参数包括单价，剩余量，图片信息-->
						<div class="col-lg-1"><a href="adidasShoeConcreteInformation.jsp?adidasShoePrice=<%=rs.getString("adidasShoePrice")%>&adidasShoeImg=<%=rs.getString("adidasShoeImg")%>&adidasShoeQuantity=<%=rs.getString("adidasShoeQuantity")%>"><button type="button" >购买</button></div></a>
						<div class="col-lg-1"><a href="commentAdidas/comment.jsp?adidasShoeId=<%=rs.getString("adidasShoeId")%>"><font color="#800000"><button>评论</button></font></a></div>
						<div class="col-lg-1"></div>
						
					</div>
					

				</div>
				<%
				//必须要用next方法
				rs.next();
				%>
				<div class="col-lg-4 adidasShoeDouble">
				
					<div class="row">
						<div class="col-lg-12"><img src='img/<%=rs.getString("adidasShoeImg")%>' alt='<%=rs.getString("adidasShoeId")%>' width="222" height="222"></div>
					</div>
					<div class="row">
						<div class="col-lg-1"></div>
						<div class="col-lg-5"><font color="#800000" size="6px"><%=rs.getString("adidasShoePrice")%> TWD</font></div>
						<!--用tag a 传参数到adidasShoeConcreteInformation,参数包括单价，剩余量，图片信息-->
						<div class="col-lg-1"><a href="adidasShoeConcreteInformation.jsp?adidasShoePrice=<%=rs.getString("adidasShoePrice")%>&adidasShoeImg=<%=rs.getString("adidasShoeImg")%>&adidasShoeQuantity=<%=rs.getString("adidasShoeQuantity")%>"><button type="button" >购买</button></div></a>
						<div class="col-lg-1"><a href="commentAdidas/comment.jsp?adidasShoeId=<%=rs.getString("adidasShoeId")%>"><font color="#800000"><button>评论</button></font></a></div>
						<div class="col-lg-1"></div>
						
					</div>
					

				</div>
				
				<div class="col-lg-2"></div>
			</div>
			<%
		}
	}
	else{	
			//如果价位条被移动，并且提交，则显示用户想要的价位
			int price = Integer.parseInt(request.getParameter("price"));
			rs = stmt.executeQuery("Select * from adidas where adidasShoePrice between 0 and "+price+" ");
			rs.last();
			int rowCount = rs.getRow();
			rs.beforeFirst();
			
			while(rs.next()){
			%>
			<div class="row">
				<div class="col-lg-2"></div>
				
				<div class="col-lg-4 adidasShoeSingle">
				
					<div class="row">
						<div class="col-lg-12"><img src='img/<%=rs.getString("adidasShoeImg")%>' alt='<%=rs.getString("adidasShoeId")%>' width="222" height="222"></div>
					</div>
					<div class="row">
						<div class="col-lg-1"></div>
						<div class="col-lg-5"><font color="#800000" size="6px"><%=rs.getString("adidasShoePrice")%> TWD</font></div>
						<!--用tag a 传参数到adidasShoeConcreteInformation,参数包括单价，剩余量，图片信息-->
						<div class="col-lg-1"><a href="adidasShoeConcreteInformation.jsp?adidasShoePrice=<%=rs.getString("adidasShoePrice")%>&adidasShoeImg=<%=rs.getString("adidasShoeImg")%>&adidasShoeQuantity=<%=rs.getString("adidasShoeQuantity")%>"><button type="button" >购买</button></div></a>
						<div class="col-lg-1"><a href="commentAdidas/comment.jsp?adidasShoeId=<%=rs.getString("adidasShoeId")%>"><font color="#800000"><button>评论</button></font></a></div>
						<div class="col-lg-1"></div>
						
					</div>
					
				</div>
				<%
				//必须要用next方法
				rs.next();
				%>
				<div class="col-lg-4 adidasShoeDouble">
				
					<div class="row">
						<div class="col-lg-12"><img src='img/<%=rs.getString("adidasShoeImg")%>' alt='<%=rs.getString("adidasShoeId")%>' width="222" height="222"></div>
					</div>
					<div class="row">
						<div class="col-lg-1"></div>
						<div class="col-lg-5"><font color="#800000" size="6px"><%=rs.getString("adidasShoePrice")%> TWD</font></div>
						<!--用tag a 传参数到adidasShoeConcreteInformation,参数包括单价，剩余量，图片信息-->
						<div class="col-lg-1"><a href="adidasShoeConcreteInformation.jsp?adidasShoePrice=<%=rs.getString("adidasShoePrice")%>&adidasShoeImg=<%=rs.getString("adidasShoeImg")%>&adidasShoeQuantity=<%=rs.getString("adidasShoeQuantity")%>"><button type="button" >购买</button></div></a>
						<div class="col-lg-1"><a href="commentAdidas/comment.jsp?adidasShoeId=<%=rs.getString("adidasShoeId")%>"><font color="#800000"><button>评论</button></font></a></div>
						<div class="col-lg-1"></div>
						
					</div>
					
				</div>
				
				<div class="col-lg-2"></div>
			</div>
			<%
		}
	}
			%>
		</div>
	</div>

</body>
</html>