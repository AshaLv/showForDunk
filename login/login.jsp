<%@ page contentType="text/html; charset=utf-8" import="java.sql.*,java.util.*" %>
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
<title>login</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../shoeForDunk.css">

</head>
<body>	
	<!--district one-->
	
	<!--判断登入者的帐号是否已经注册或密码是否对应帐号-->
	<%
		String loginName=request.getParameter("loginName");
		String loginPsd=request.getParameter("loginPsd");
		rs=stmt.executeQuery("Select registerName,registerPsd from registerShoeForDunk where registerName='"+loginName+"'");
		//查看帐号在数据库中是否有存在，不存在的话，导向登入界面
		if(!rs.next()){
			out.println("<script language='javascript'>window.alert('账号不存在');window.location.href='loginFirst.jsp';</script>");
				
		}
		//查看帐号在数据库中是否有存在，存在的话，看密码正确否
		else{
			if(loginPsd.equals(rs.getString("registerPsd"))){
			
			//登入成功的话，就把账号放进cookie，要在所有的网页上显示出来
			 

			Cookie loginSuccess = new Cookie("loginSuccess",loginName);
			String path = "/shoeForDunk/";
			loginSuccess.setPath(path);
				
			response.addCookie(loginSuccess);
			//loginSuccess.setMaxAge(0);
			
			out.println("<script language='javascript'>window.alert('登入成功');window.location.href='http://localhost:8080/shoeForDunk/shoeForDunk.jsp';</script>");

		}
			else{
			out.println("<script language='javascript'>window.alert('密码错误');window.location.href='loginFirst.jsp';</script>");
			}
			
		}
		//删除SESSION
		Enumeration sessionAllName = session.getAttributeNames();//这里有所有的session
		while (sessionAllName.hasMoreElements()){
		String theOrderInCart[] = (String[])session.getAttribute(sessionAllName.nextElement().toString());
		session.removeAttribute(theOrderInCart[0]);

	}
			
	%>

</body>
</html>