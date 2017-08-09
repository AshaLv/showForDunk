<%@ page contentType="text/html; charset=utf-8" import="java.sql.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%!
//预定义
Connection con = null;//定义名字为con的connnection物件，为的是建立与数据库之间的联系
Statement stmt = null;//定义名字为stmt的statement物件，为的是存放SQL语句
ResultSet rs = null;//定义名为rs的resultSet物件，为的是存放从数据库而来的资料
//建立链接数据库的生命周期
public void jspInit()	//初始建立数据库连接
{
	try{
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");//加载驱动
		//con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\shoeForDunk\\shoeForDunk.mdb");
		con=DriverManager.getConnection("jdbc:odbc:shoeForDunk");//用drivermanager的.getconnection方法，取得数据源的连接，得到操纵数据库的权利
		stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);//用connection物件的.createStatement方法，定义出一个可滚动，可操纵的，没有限制的语句物件	
    }
	catch(Exception ex){	//ex为exception物件定义出来的
		System.out.println(ex.toString());	//ex物件将取得的错误，用tostring方法吐出来
	}
}
public void jspDestroy()	//将数据库连线解除
{
	try{
		rs.close();	//关闭数据库
		stmt.close();	//关闭SQL语句
		con.close();	//关闭与数据驱动的联系
	}
	catch(Exception ex){	//ex为exception物件定义出来的
		System.out.println(ex.toString());//ex物件将取得的错误，用tostring方法吐出来
	}
}
%>
<html lang="utf-8">
<head >
<meta charset="utf-8">
<title>register</title>
</head>
<body>
<!--执行数据储存至数据库中的 register 表-->
<%
String registerName=request.getParameter("registerName");	//取得url中参数registerName的值，就是注册者的帐号名称
String registerPsd=request.getParameter("registerPsd");//取得url中参数registerPsd的值，就是注册者自己设置的密码
String registerRepsd=request.getParameter("registerRepsd");//取得URL参数registerRepsd的值，查看与之前设置的密码是否统一
String registerEmail=request.getParameter("registerEmail");//取得url参数registerEmail的值，就是注册者使用的邮箱
rs=stmt.executeQuery("Select registerName from registerShoeForDunk where registerName='"+registerName+"'");//用操纵SQL语句的stmt的executeQuery方法，取得数据库中的资料，并且将数据存放到rs中
//查看确认密码时是否对应
if(registerPsd.equals(registerRepsd)==false){
	out.println("<script language='javascript'>window.alert('密码输入不一致');window.location.href='registerFirst.jsp?registerName="+registerName+"&registerEmail="+registerEmail+"';</script>");
}
else{
//查看申请的帐号在数据库中是否有存在
	if(!rs.next()){	//用rs中next方法，如果有对应资料的话，rs不会到底，回传值为TURE；如果找不到信息的话，那么回传值为false，则目的达到
		String registerSqlWrite="INSERT INTO registerShoeForDunk(registerName,registerPsd,registerEmail) values('"+registerName+"','"+registerPsd+"','"+registerEmail+"')";//将SQL语句写入string变量，新增资料
		stmt.executeUpdate(registerSqlWrite);//用操纵数据库的stmt物件，使用SQL语法，使数据写入数据库
		response.sendRedirect("registerOk.html");//用服务器端response物件的sendRedirect方法转向注册成功区块
}
else{//如果已经有相同帐号存放在数据库
	out.println("<script language='javascript'>window.alert('账号已经被使用');window.location.href='registerFirst.jsp?registerEmail="+registerEmail+"';</script>");
}
}
%>	
</body>
</html>