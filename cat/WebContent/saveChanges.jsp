<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%
    request.setCharacterEncoding("UTF-8");
 	String msg ="";
 	String connectString = "jdbc:mysql://localhost:3306/maofan"
 					+ "?autoReconnect=true&useUnicode=true"
 					+ "&characterEncoding=UTF-8"; 
 	String username=(String)session.getAttribute("User");
 	String cutename=request.getParameter("cutename");
 	String sex=request.getParameter("sex");
 	String location=request.getParameter("location");
 	String s1=request.getParameter("s1");

 	  Class.forName("com.mysql.jdbc.Driver");
 	  Connection con=DriverManager.getConnection(connectString,"root", "123456");
 	  Statement stmt=con.createStatement();
 	  String fmt="update personInfo set cutename='%s',location='%s',sex='%s' where username='%s'";
 	  String sql=String.format(fmt,cutename,location,sex,username);
 	  int cnt=stmt.executeUpdate(sql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save Changes</title>
<style type="text/css"  href= "bottons.css">
   *{font-size:22px;font-family:方正卡通简体;color:#F4A460;}
   #pic{position:absolute; left:40%;top:30px; }
   body {background-color: #FFFFE0;}
   #text{position:absolute; left:33%; top:130px;}
   #pic2{position:absolute; left:37%;top:200px; }
</style>
</head>
<body>
	<div id="pic"><img src="MF.png" alt="猫饭Logo" title="猫饭Logo"></div>
	<div id="text">更改已经成功保存啦,<span id="time">3</span>秒钟后就要回家啦~</div>
	<div id="pic2"><img src="TZ2.png" alt="TZ2" title="TZ2"></div>
</body>
<script type="text/javascript">
	var span = document.getElementById("time") ;
	var t = 3 ;
	var id ;
	timerun() ;
	function timerun()
	{
		t-- ;
		var str = t.toString() ;
		if(t<=0)
			window.location.href = "changeInfo.jsp";
		else
		{
			span.innerHTML = str ;
			id=setTimeout(timerun,1000) ;
		}
	}
</script>
</html>

