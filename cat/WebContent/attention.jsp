<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%
    request.setCharacterEncoding("utf-8");

    String visitee = request.getParameter("visitee") ;
//    int len = visitee.length() ;
//    visitee = visitee.substring(1,len-1) ;
    String username = (String)session.getAttribute("User") ;
    String visiter = username ;
    String btn_value = "关注" ;

    out.print(visiter) ;
    out.print(visitee) ;

 	  String msg ="";
 	  String connectString = "jdbc:mysql://localhost:3306/maofan"
 					+ "?autoReconnect=true&useUnicode=true"
 					+ "&characterEncoding=UTF-8"; 


	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con=DriverManager.getConnection(connectString, 
	                 "root", "123456");
	  Statement stmt=con.createStatement();

	  String fmt="select * from attention where visiter='%s' and visitee='%s' ";
	  String sql=String.format(fmt,visiter,visitee) ;
	  ResultSet rs=stmt.executeQuery(sql);
	  while(rs.next())
	  {
	      btn_value="已关注" ;
	  }

	  if(btn_value.equals("关注"))
	  {
			String fmt1="insert into attention(visiter,visitee) values('%s','%s')";
			String sql1=String.format(fmt1,visiter,visitee);
			int cnt=stmt.executeUpdate(sql1);
	  }
	  else
	  {	
			String fmt1="delete from attention where visiter='%s' and visitee='%s' ";
	  		String sql1=String.format(fmt1,visiter,visitee);
	  		int cnt=stmt.executeUpdate(sql1);
	  }
	  visitee = "'" + visitee + "'" ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Attention others</title>
</head>
<body>
<a href=otherhome.jsp?visitee=<%=visitee%> >返回</a>
</body>
</html>