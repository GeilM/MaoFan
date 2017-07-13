<%@ page language="java" import="java.util.*,java.sql.*" 
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登录</title>
<link rel="stylesheet" type="text/css" href="bottons.css"/>
 <script>
		function addCheck(){
			var username=document.getElementById("username").value;
			var password=document.getElementById("password").value;
			if(username==""){
				alert("用户名不能为空!");
				document.getElementById("username").focus();  
				return false;
                }
			if(password==""){
				alert("密码不能为空!");
				 document.getElementById("password").focus();
				 return false;
				 }
			if(flag==false){
				 alert("用户名或密码错误!");
				 document.getElementById("password").focus();
				 return false;
				 }
		}
		function validate(){
		    var flag2 = addCheck();
		    if(flag2 == false)
		        return false;
		    return true;
	    }
	</script>
<style type="text/css">
   *{font-size:20px;font-family:方正卡通简体;max-width:960px;color:#F4A460;}
   input[type="text"],textarea {color:grey}
   input[type="text"]{width:15em}
   input[type="password"]{width:15em}
   [for="content"]{vertical-align:top;}
   fieldset {position:absolute;
    left:31%; top:200px; 
    width:500px;margin:20px auto;padding:20px;
    background-color:#FFFFF0;
     border-radius: 20px;}
   #content {width:700px;height:300px}
   input:focus,textarea:focus {background-color:;}
   button:disabled,input,disabled{color:grey;}
   input:checked+span{color:red;}
   textarea::selection{color:white;background-color:blue;}
   #pic{position:absolute; left:43%; top:35px; }
   #yugan{position:absolute; left:33%; top:130px;
        font-weight: bold;
        font-family:方正卡通简体; color:#F4A460; font-size:1.5em;}
   body {background-color: #FFFFE0;}

</style>
</head>
<body>
<div id="pic"><img src="MF.png" alt="猫饭Logo" title="猫饭Logo"></div>
<fieldset>

<legend>用户登录</legend>
<form name = "login" action="dologin.jsp" method="post" onsubmit = "return validate()">
 <p>
 	<label for="username">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户名：</label>
   	<input name="username" type="text" maxlength=60 placeholder="输入用户名">
 </p>
 <p>
 	<label for="keywords">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密码：</label>
   	<input name="password" type="password" maxlength=60 placeholder="输入密码">
 </p>
 <div style="text-align:center">
	<input type="submit" class="button button-highlight button-pill button-large"  value="登录" />
    <input type="button" class="button button-highlight button-pill button-large" value="注册"
    onclick="javascrtpt:window.location.href='register.jsp'"/>
 </div>
</form>
</fieldset>
<div>
<p id="yugan">登录就能跟世界分享主子的小鱼干啦</p>
</div>
</body>
</html>