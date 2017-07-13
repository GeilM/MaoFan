<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
   request.setCharacterEncoding("utf-8");
   String msg="";
   String table=""; 
   String connectString = "jdbc:mysql://localhost:3306/maofan"
	+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8"; 
   String user = "root" ; String pwd = "123456" ;
   String name = request.getParameter("name");  
   String pass = request.getParameter("pass"); 
   String pass2 = request.getParameter("pass2"); 
   String email = request.getParameter("emailaddr"); 
   if(request.getMethod().equalsIgnoreCase("post"))
   	{ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,user, pwd);
		Statement stmt = con.createStatement();
		try
		{
			String fmt="insert into user(username,password,email) values('%s','%s','%s')";  
			String sql = String.format(fmt,name,pass,email);
			int cnt = stmt.executeUpdate(sql);
			
			fmt = "insert into personInfo(username) values('%s')" ;
			sql = String.format(fmt,name) ;
			cnt = stmt.executeUpdate(sql) ;

			if(cnt>0)msg = "注册成功!";
			stmt.close();
			con.close();
		}
		catch (Exception e)
		{
			msg = e.getMessage();
		}
    } 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户注册</title>
<link rel="stylesheet" type="text/css" href="bottons.css"/>
 <script>
		function addCheck(){
			var username=document.getElementById("name").value;
			var password=document.getElementById("pass").value;
			var newword=document.getElementById("pass2").value;
			if(username==""){
				alert("用户名不能为空!");
				document.getElementById("name").focus();  
				return false;
                }
			if(password==""){
				alert("密码不能为空!");
				 document.getElementById("pass").focus();
				 return false;
				 }
			if(password != newword){
				alert("两次输入密码不相同!");
				 document.getElementById("pass2").focus();
				 return false;
				 }
		}
		function validate(){
		    var flag = addCheck();
		    if(flag == false)
		        return false;
		    return true;
	    }
	</script>
<style type="text/css">
   *{font-size:20px;font-family:方正卡通简体;max-width:960px; color:#F4A460;}
   input[type="text"],textarea {color:grey}
   input[type="text"]{width:15em}
   input[type="password"]{width:15em}
   [for="content"]{vertical-align:top;}
   fieldset {position:absolute;
    left:20%; top:100px; 
    width:500px;margin:20px auto;padding:20px;
    background-color:#FFFFF0;
     border-radius: 20px; }
   #content {width:700px;height:300px}
   input:focus,textarea:focus {background-color:;}
   button:disabled,input,disabled{color:grey;}
   input:checked+span{color:red;}
   textarea::selection{color:white;background-color:blue;}
   #pic{position:absolute; left:20%; top:30px; }
   body {background-color: #FFFFE0;}
	
	#slideMain {  
            margin: 0 auto;  
            padding: 0;  
            width:302px;  
            overflow:hidden;  
            position:absolute; left:60%; top:129px;
        }  
  
        .slides {  
            margin: 0;  
            padding: 0;  
            animation-name:first; 
            animation-duration:10s;  
            animation-timing-function:linear;   
            animation-iteration-count:infinite;  
			animation-direction:alternate;  
        }   
   @keyframes  first{  
            0%{ transform: translate(0px,0px);}  
            100%{ transform: translate(-925px,0px);}   
            }
</style>
</head>
<body>
<div id="pic"><img src="MF.png" alt="猫饭Logo" title="猫饭Logo"></div>
<fieldset>
	<legend>用户注册</legend>
	<form name = "register" action="register.jsp" method="post" onsubmit = "return validate()">
		 <p><label for="username">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户名：</label>
		   <input name="name" type="text" maxlength=60 placeholder="输入用户名"></p>
		 <p><label for="keywords">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密码：</label>
		   <input name="pass" type="password" maxlength=60 placeholder="输入密码"></p>
		 <p><label for="keywords">再次确定密码：</label>
		   <input name="pass2" type="password" maxlength=60 placeholder="输入密码"></p>
		 <p><label for="email">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮箱：</label>
		   <input name="emailaddr" type="text" maxlength=60 placeholder="输入邮箱"></p>
<div id="a" style="text-align:center"><input type="submit" class="button button-highlight button-pill button-large"  value="注册" /></div>
	</form>
	  <%=msg%>
	  <br/><br/>
	<a href='login.jsp'>返回</a>
</fieldset>
	<div id="slideMain">  
        <div class="slides">  
            <img class="slide">  
            <nobr>  
            <img src="nm3.png">  
            <img src="nm4.png">  
            <img src="nm7.png">  
            <img src="nm8.png">  
            </nobr>  
        </div>
  </div>
</body>
</html>