<%@ page language="java" import="java.util.*,java.sql.*" 
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("utf-8");
    String msg="";
    String flag="0";
    String connectString = "jdbc:mysql://localhost:3306/maofan?characterEncoding=utf8&useSSL=true";
    String user = "root" ; String pwd = "123456" ; 
    String username = request.getParameter("username");  
    String password = request.getParameter("password");  
    if(request.getMethod().equalsIgnoreCase("post"))
    {
		Class.forName("com.mysql.jdbc.Driver");
    	Connection con=DriverManager.getConnection(connectString,user,pwd);
    	Statement stmt=con.createStatement(); 
    	try
    	{
			String sql="select * from user where username='"+username+"' and password='"+ password + "'"; 
			ResultSet rs=stmt.executeQuery(sql);
        	if(rs.next()) flag="1";
        	stmt.close();  
          	con.close();
    	} 
        catch (Exception e)
        {  
            msg = e.getMessage();  
        }
    }  
    if(flag=="1")
    {  
        session.setAttribute("User",username);  
    }    
%>
<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
<meta content="text/html"; charset="utf-8"/>
<title>登陆成功</title>
<style type="text/css"  href= "bottons.css">
   *{font-size:22px;font-family:方正卡通简体;color:#F4A460;}
   #pic{position:absolute; left:40%;top:30px; }
   body {background-color: #FFFFE0;}
   #text{position:absolute; left:35%; top:130px;}
   #pic2{position:absolute; left:35%;top:200px; }

</style>
</head>
<body>
<div id="pic"><img src="MF.png" alt="猫饭Logo" title="猫饭Logo"></div>
<p id="text">登陆成功！现在去看看撸点什么猫吧</p>
<div id="pic2"><img src="TZ1.png" alt="TZ1" title="TZ1"></div>
</body>
<script type="text/javascript">
  var t = 3 ;
  var id ;
  timerun() ;
  function timerun()
  {
    t-- ;
    if(t<=0)
      window.location.href = "home.jsp";
    else
    {
      id=setTimeout(timerun,1000) ;
    }
  }
</script>
</html> 