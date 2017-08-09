<%@ page contentType="text/html; charset=utf-8" import="java.util.*,java.sql.*"%>
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
	
	<%
	Enumeration sessionAllName = session.getAttributeNames();//这里有所有的session
	while (sessionAllName.hasMoreElements()){
	String theOrderInCart[] = (String[])session.getAttribute(sessionAllName.nextElement().toString());
	String address = request.getParameter("address");
	String payWay = request.getParameter("payWay");
	String shoeSize = theOrderInCart[2];
	String shoeId = theOrderInCart[0];
	String shoeRealId = shoeId.substring(4,5);
	String shoeColor = theOrderInCart[1];
	String shoeInfoQuantity = theOrderInCart[3];
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM--dd HH:mm:ss"); 
	java.util.Date time = new java.util.Date();
	String timeNow = formatter.format(time);
	if(theOrderInCart[0].indexOf("n") != -1){
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

	else if(theOrderInCart[0].indexOf("a") != -1){
	
	java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyy-MM--dd HH:mm:ss"); 
	java.util.Date time1 = new java.util.Date();
	String timeNow1 = formatter1.format(time1);
	rs=stmt.executeQuery("Select * from adidas where adidasShoeImg='"+shoeId+"'");
	rs.next();
	int shoeAmountChange = Integer.parseInt(shoeInfoQuantity);
	int shoeOriginalAmount = Integer.parseInt(rs.getString("adidasShoeQuantity"));
	int shoeAmountLast = shoeOriginalAmount - shoeAmountChange;
	String 	orderSqlWrite="INSERT INTO orderMy(orderTime,registerName,ShoeId,orderAmount,orderAddress,orderPayWay,orderSize,orderColor) values('"+timeNow1+"','"+loginNameCookie+"','"+shoeId+"','"+shoeInfoQuantity+"','"+address+"','"+payWay+"','"+shoeSize+"','"+shoeColor+"')";
	stmt.executeUpdate(orderSqlWrite);
	String decreaseTheShoeAmount = "UPDATE [adidas]" +
 	"SET [adidasShoeQuantity]="+shoeAmountLast+" WHERE [adidasShoeImg] = '"+shoeId+"'";
 	stmt.executeUpdate(decreaseTheShoeAmount);
	out.println("<script language='javascript'>window.alert('adidas订单已经收入数据库，将为你导向HOMEPAGE');window.location.href='http://localhost:8080/shoeForDunk/shoeForDunk.jsp';</script>");

	
	}

	else{

	}
	}
	%>
	
</body>
</html>