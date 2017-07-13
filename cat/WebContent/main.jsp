<%@ page language="java" import="java.util.*,java.sql.*"  
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%
 request.setCharacterEncoding("utf-8");
 String msg="";
 boolean flag=false; 
 String connectString = "jdbc:mysql://localhost:3306/lesson?characterEncoding=utf8&useSSL=true";   
     try {
  	   Class.forName("com.mysql.jdbc.Driver");
  	   Connection con=DriverManager.getConnection(connectString,"root","123456");
       String username = request.getParameter("username");  
  	   String password = request.getParameter("password");            
          String sql="select * from user where username='"+username+"' and password='"+ password + "'";  
          Statement stmt = con.createStatement();  
           ResultSet rs=stmt.executeQuery(sql);  
           if(rs.next()) 
           {  response.getWriter().print("登录成功"); 
              flag=true;
           }
          else  
          {
        	  response.sendRedirect("login.jsp?errNo");//密码不对返回到登陆  
          }
   
          stmt.close();  
          con.close();    
        }
           catch (Exception e){  
               msg = e.getMessage();  } 
%>
<html>
<head>
 <script>
		function addCheck(){
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>测试用的主页</title>
</head>
<body>
  <a href="test3.jsp" class="button button-highlight button-pill button-large">返回</a>
</body>
</html>