<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>

<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>the shoe 's infomation</title>
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
	<div align="center"><h2>欢迎购买您的专属篮球鞋</h2></div>
	<!--district three-->
	<div class="sectionShoeShow" >
		<div class="container">
			<div class="row" >
				<!--放图片-->
				<div class="col-lg-6 concreteShoeInfo">
					<div class="row "><img src="" alt="显示鞋子出现错误" id="shoeInfoImg"></div>
					<div class="row">
						<div class="col-lg-1"></div>
						<div class="col-lg-11"><font color="#800000"><h3 id="shoeInfoPrice"></h3><br><h3 id="shoeInfoQuantityShow"></h3></font></div>
					</div>
				</div>
				<div class="col-lg-1"></div>
				<!--放图片有关信息-->
				<div class="col-lg-5">
					<br><br>	
					<div class="row">
						<font color="#008000">
						<form action="payNike.jsp" method="get" name="shoePay">
						<p>尺码：<input type="number" name="shoeSize" min="20" max="55" required></p><br>
						<p>颜色：<input type="radio" name="shoeColor" value="blue" checked>blue
								 <input type="radio" name="shoeColor" value="red" >red
								 <input type="radio" name="shoeColor" value="yellow" >yellow
</p><br>
						<p>数量：<input type="number" name="shoeInfoQuantity" min="1" max="<%=request.getParameter("nikeShoeQuantity")%>" id="shoeInfoQuantity" required></p><br><br><br>
						<font color="#800000"><p><button type="button"  id="cal">计算总金额</button><input type="hidden" name="shoeInfoPriceHidden" id="shoeInfoPriceHidden" ></p></font><br>
						<p><input type="hidden" name="shoeId" id="shoeInfoImgTo" ></p><br>
						<font color="#800000"><p><input type="submit" name="shoePayConfirm" value="确认付款"></p></font><br>
						<font color="#800000"><p><input type="submit" name="shoeCart" value="加入购物车"></p></font><br>
						</font>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--用JS取得鞋子的具体参数，并且改变HTML属性-->
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
					
					var nikeShoePrice=request('nikeShoePrice'); 
					var nikeShoeImg=request('nikeShoeImg'); 
					var nikeShoeQuantity=request('nikeShoeQuantity');
					
					
					document.getElementById("shoeInfoImg").src = "img/"+nikeShoeImg;
					document.getElementById("shoeInfoImgTo").value = nikeShoeImg;
					document.getElementById("shoeInfoPrice").innerHTML = "鞋子单价:    "+nikeShoePrice;
					document.getElementById("shoeInfoQuantityShow").innerHTML = "库存剩余："+nikeShoeQuantity;
					document.getElementById("shoeInfoPriceHidden").value = nikeShoePrice;				
	</script>


	<!--引进bootstrap的js-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
	<!--引进jquery的js--> 
	<script src="jquery-1.11.3.js"></script>
	<!--使用jquery去捕捉实时变化的鞋子数量，然后乘以单价，供顾客计算他要支付的总金额-->
	<script>
		$(document).ready(function(){
	    $("#cal").click(function(){
	        alert("您总共要支付: " + $("#shoeInfoQuantity").val()+$("#shoeInfoPriceHidden").val()+" NTD");
	    });
	});
	</script>


	
</body>
</html>