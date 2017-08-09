<%@ page contentType="text/html; charset=utf-8" import="java.sql.*,java.io.*"%>
<!--导入数据库包，和输进输出流包-->
<% request.setCharacterEncoding("utf-8"); %>
<!--用request对象的setCharacterEncoding方法选择utf-8-->
<%!
//预定义
Connection con = null;//用Connection对象去new一个新的对象，命名为con，建立与数据源的连接，初始值为null
Statement stmt = null;//用Statememnt对象去new一个新的对象，命名为stmt，建立语句的连接，初始值为null
ResultSet rs = null;//用resultset对象去new一个新的对象，命名为rs，建立数据字段的连接，初始值为null
//建立链接数据库的生命周期
public void jspInit()
{
	try{
	      // Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		   //String url="jdbc:sqlserver://localhost;DatabaseName=bookshop;";  
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
<title>last STEP FOR THE SHOE</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../shoeForDunk.css">
<link rel="stylesheet" href="cart.css">
</head>
<body>	
	<!--取得登入信息的COOKIE-->
	<%
		Cookie[] loginSuccess = request.getCookies();
		//取loginSuccess为Cookie数组的名字，取得所有Cookie	
		String userName="您还未登录";
		String loginNameCookie = "";
		int j;
		if(loginSuccess != null ){
		int loginSuccessLength = loginSuccess.length;
		//将loginSuccess的cookie数组长度取下给予loginSuccessLength
			for(int i=0; i<1;i++){
				for( j = 0; j<loginSuccessLength;j++){
					 	if(loginSuccess[j].getName().equals("loginSuccess")  ){
					 	loginNameCookie = loginSuccess[j].getValue();
					 	break;
					 	}
					 }
		//如果没有登入，就提示还未登入，并且跳转到nike页面
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
	<!--将尽可能多的有用信息收集起来-->
	<%
	String address = request.getParameter("address");
	String payWay = request.getParameter("payWay");
	String shoeSize = request.getParameter("shoeSize");
	String shoeId = request.getParameter("shoeId");
	String shoeRealId = shoeId.substring(4,5);
	String shoeColor = request.getParameter("shoeColor");
	String shoeInfoQuantity = request.getParameter("shoeInfoQuantity");
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM--dd HH:mm:ss"); 
	java.util.Date time = new java.util.Date();
	String timeNow = formatter.format(time);
	//将得到的资料写入DB
	if(shoeId.indexOf("n") != -1){
	rs=stmt.executeQuery("Select * from nike where nikeShoeImg='"+shoeId+"'");
	rs.next();
	int shoeAmountChange = Integer.parseInt(shoeInfoQuantity);
	int shoeOriginalAmount = Integer.parseInt(rs.getString("nikeShoeQuantity"));
	int shoeAmountLast = shoeOriginalAmount - shoeAmountChange;
	String 	orderSqlWrite="INSERT INTO orderMy(orderTime,registerName,ShoeId,orderAmount,orderAddress,orderPayWay,orderSize,orderColor) values('"+timeNow+"','"+loginNameCookie+"','"+shoeId+"','"+shoeInfoQuantity+"','"+address+"','"+payWay+"','"+shoeSize+"','"+shoeColor+"')";
	stmt.executeUpdate(orderSqlWrite);
	String decreaseTheShoeAmount = "UPDATE [nike]" +
 	"SET [nikeShoeQuantity]="+shoeAmountLast+" WHERE [nikeShoeId] = '"+shoeRealId+"'";
 	stmt.executeUpdate(decreaseTheShoeAmount);
	out.println("<script language='javascript'>window.alert('nike订单已经收入数据库，将为你导向HOMEPAGE');window.location.href='http://localhost:8080/shoeForDunk/shoeForDunk.jsp';</script>");

}
	else{
	rs=stmt.executeQuery("Select * from adidas where adidasShoeImg='"+shoeId+"'");
	rs.next();
	int shoeAmountChange = Integer.parseInt(shoeInfoQuantity);
	int shoeOriginalAmount = Integer.parseInt(rs.getString("adidasShoeQuantity"));
	int shoeAmountLast = shoeOriginalAmount - shoeAmountChange;
	String 	orderSqlWrite="INSERT INTO orderMy(orderTime,registerName,ShoeId,orderAmount,orderAddress,orderPayWay,orderSize,orderColor) values('"+timeNow+"','"+loginNameCookie+"','"+shoeId+"','"+shoeInfoQuantity+"','"+address+"','"+payWay+"','"+shoeSize+"','"+shoeColor+"')";
	stmt.executeUpdate(orderSqlWrite);
	String decreaseTheShoeAmount = "UPDATE [adidas]" +
 	"SET [adidasShoeQuantity]="+shoeAmountLast+" WHERE [adidasShoeImg] = '"+shoeId+"'";
 	stmt.executeUpdate(decreaseTheShoeAmount);
	out.println("<script language='javascript'>window.alert('adidas订单已经收入数据库，将为你导向HOMEPAGE');window.location.href='http://localhost:8080/shoeForDunk/shoeForDunk.jsp';</script>");

	
}
	%>


</body>
</html>