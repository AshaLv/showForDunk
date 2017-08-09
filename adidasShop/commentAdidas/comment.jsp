<%@ page contentType="text/html; charset=utf-8" import="java.io.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>the shoe 's comment</title>
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../../shoeForDunk.css">

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
		//如果没有登入，就提示还未登入，并且跳转到adidas页面
				if(j==loginSuccessLength){ 	
				out.println("<script language='javascript'>window.alert('您还未登入哦！');window.location.href='../adidas.jsp';</script>");
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
	<%
	//把鞋子的id参数取到
	String shoeId = request.getParameter("adidasShoeId");
	String shoe = "adidas" + shoeId +".jpg";
	%>
	<!--放置鞋子图片和表单-->
	<div align="center"><h1>鞋子的评价</h1></div>
	<div class="sectionForComment">
		<div class="container">
			<div class="row">
				<div class="col-lg-5"><img src="../img/<%=shoe%>" alt="the shoe " class="commentImg"></div>
				<div class="col-lg-2"></div>
				<br><br>
				<div class="col-lg-5"><form action="comment.jsp" method="post" name="commentForm"><textarea name="message" rows="10" cols="60" placeholder="您可以对这双篮球鞋进行留言，与球友交流感受！" required></textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-5"></div>
				<div class="col-lg-2"></div>
				<br><br><br><br><br><br>
				<div class="col-lg-5"><input type="hidden" value="<%=shoeId%>" name="adidasShoeId"><input type="submit" class="commentButton" name="commentSubmit" value="评论"></form>
				</div>
			</div>
			<div class="row">
				 
			</div>
		</div>
	</div>
	<hr style="height:1px;border:0;border-bottom:9px solid #800000;margin:0" />
	<!--将留言信息写入-->
	<%
	if(request.getParameter("commentSubmit") != null){

	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM--dd HH:mm:ss"); 
	java.util.Date time = new java.util.Date();
	String timeNow = formatter.format(time);
	String root = request.getRealPath("/") + "shoeForDunk" + "\\adidasShop" + "\\commentAdidas";//取得目前目录在的位置
	String wholeRoot = "\\commentFile\\"+shoeId+".txt";
	FileWriter commentAdidasWriteFw = new FileWriter(root + "\\commentFile\\"+shoeId+".txt",true);//建立FileWrite物件，以Append()方式写入资料
	BufferedWriter commentAdidasWriteBw = new BufferedWriter(commentAdidasWriteFw);//建立bufferedWriter物件
	String commentAdidasFinal = "姓名:<font size=4 color= brown>" + loginNameCookie + "</font><br>留言时间：" + 
		timeNow + "</font><br>留言：" +
		"<font size = 4 color=red>" +
		request.getParameter("message") + "</font><hr >";//要记录到txt的资料
	commentAdidasWriteBw.write(commentAdidasFinal);//完成记录

	commentAdidasWriteBw.close();//关闭bw物件
	commentAdidasWriteFw.close();//关闭fw物件
	
	}
	String wholeRoot = "\\commentFile\\"+shoeId+".txt";

	%>
	<!--将文档调出来-->
	<div align="center"><h4 style="font-size:44px;">评论区</h4></div>
    <jsp:include page="<%=wholeRoot%>"></jsp:include>
	</body>
	</html>