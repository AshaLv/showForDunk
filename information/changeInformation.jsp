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
<title>register</title>
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

<!--执行数据储存至数据库中的 register 表-->
<%
	//修改密码
if(request.getParameter("oldPsd") != null){
	String oldPsd=request.getParameter("oldPsd");
	String newPsd=request.getParameter("newPsd");
	String reNewPsd=request.getParameter("reNewPsd");
	//String registerSql="Select registerName from registerShoeForDunk where registerName='"+registerName+"' ";
	rs=stmt.executeQuery("Select registerPsd from registerShoeForDunk where registerName='"+loginNameCookie+"'");
	rs.next();
	String registerPsd = rs.getString("registerPsd");

	//查看旧密码是否正确
	if(registerPsd.equals(oldPsd) == false ){

	out.println("<script language='javascript'>window.alert('旧密码错误');window.location.href='information.jsp';</script>");

	}
		//查看确认密码时是否对应
		else if(newPsd.equals(reNewPsd) == false){

		out.println("<script language='javascript'>window.alert('确认密码与新密码不一致');window.location.href='information.jsp';</script>");
			
		}
			//都没有错误的话，将密码数据更新
			else{
			String changeInformationPsd="UPDATE registerShoeForDunk SET registerPsd ='"+newPsd+"' " + 
"WHERE registerName = '"+loginNameCookie+"'";
			stmt.executeUpdate(changeInformationPsd);
			out.println("<script language='javascript'>window.alert('密码修改成功');window.location.href='information.jsp';</script>");	
			}

}
	//修改邮箱
else{
	String newEmail = request.getParameter("newEmail");
	rs=stmt.executeQuery("Select registerEmail from registerShoeForDunk where registerName='"+loginNameCookie+"'");
	rs.next();
String changeInformationEmail="UPDATE registerShoeForDunk SET registerEmail ='"+newEmail+"' " + 
"WHERE registerName = '"+loginNameCookie+"'";
	stmt.executeUpdate(changeInformationEmail);	
	out.println("<script language='javascript'>window.alert('邮箱修改成功');window.location.href='information.jsp';</script>");
}
%>

	
</body>
</html>