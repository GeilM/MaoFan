<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
    <%
    request.setCharacterEncoding("utf-8");
 	String msg ="";
 	String connectString = "jdbc:mysql://localhost:3306/maofan"
 					+ "?autoReconnect=true&useUnicode=true"
 					+ "&characterEncoding=UTF-8"; 

    String catId=request.getParameter("cat_id");

 	try{
 	  Class.forName("com.mysql.jdbc.Driver");
 	  Connection con=DriverManager.getConnection(connectString, 
 	                 "root", "123456");
 	  Statement stmt=con.createStatement();
 	  String fmt="delete from personCat where cat_id=%s";
 	  String sql=String.format(fmt,catId);
 	  int cnt=stmt.executeUpdate(sql);
 	  fmt="delete from catInfo where cat_id=%s";
 	  sql=String.format(fmt,catId);
 	  cnt=stmt.executeUpdate(sql);
 	
 	  if(cnt>0){
 		  msg="修改成功";
 	  }
 	}
 	catch(Exception e)
 	{
 	msg=e.getMessage();
 	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>delete Cat</title>
<style type="text/css"  href= "bottons.css">
   *{font-size:22px;font-family:方正卡通简体;color:#F4A460;}
   #pic{position:absolute; left:40%;top:30px; }
   body {background-color: #FFFFE0;}
   #text{position:absolute; left:31.5%; top:130px;}
   #pic2{position:absolute; left:33%;top:200px; }
</style>
</head>
<body>
<div id="pic"><img src="MF.png" alt="猫饭Logo" title="猫饭Logo"></div>
<p id="text">猫宠已经成功删除啦,<span id="time">3</span>秒钟后真的要说再见了</p>
<div id="pic2"><img src="TZ5.png" alt="TZ5" title="TZ5"></div>
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