<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%
    request.setCharacterEncoding("UTF-8");
 	String msg ="";
 	String connectString = "jdbc:mysql://localhost:3306/maofan"
 					+ "?autoReconnect=true&useUnicode=true"
 					+ "&characterEncoding=UTF-8"; 
 	String username=(String)session.getAttribute("User");  
 	String s2=request.getParameter("s2");
 	if(request.getMethod().equalsIgnoreCase("post"))
 	{
	 	String[] id_values=request.getParameterValues("cat_id");
	 	int catNum=id_values.length;
	 	String[] catNames= request.getParameterValues("catName");
	 	String ages[]=request.getParameterValues("age");
	 	String sexs[]=new String[catNum];

	 	 for(int i=0;i<catNum;i++)
	 	 {
	 		 String catsex="catSex"+Integer.toString(i+1);
	 		 sexs[i]=request.getParameter(catsex);
	 	 }
	 	 
	 	String cate[]=request.getParameterValues("category");
	 	try
	 	{
		 	  Class.forName("com.mysql.jdbc.Driver");
		 	  Connection con=DriverManager.getConnection(connectString, 
		 	                 "root", "123456");
		 	  Statement stmt=con.createStatement();
		 	  String fmt1,fmt2;String sql;
		 	  for(int i=0;i<catNum;i++)
		 	  {
			 	  fmt1="update catInfo set cat_name='%s',age=%f,category='%s',cat_sex='%s' where cat_id='%s' and cat_id in (select cat_id from personCat where username='%s')";
			 	  sql=String.format(fmt1,catNames[i],Double.valueOf(ages[i]),cate[i],sexs[i],id_values[i],username);
			 	  int cnt=stmt.executeUpdate(sql);
			 	  if(cnt>0)
			 	  {
			 		  msg="修改成功";
		 	  	  }
			 	  else
			 	  {
			 		 msg="insert";
			 		 fmt1="insert into catInfo(cat_id,cat_name,age,category,cat_sex) values('%s','%s',%f,'%s','%s') ";
			 	 	 sql=String.format(fmt1,id_values[i],catNames[i],Double.valueOf(ages[i]),cate[i],sexs[i]);
			 	 	 cnt=stmt.executeUpdate(sql);
			 	 	 
			 	 	 fmt2="insert into personCat(username,cat_id) values('%s','%s')";
			 	 	 sql=String.format(fmt2,username,id_values[i]);
			 	 	 cnt=stmt.executeUpdate(sql);
			 	 	 if(cnt>0) 
			 	 	 {
			 	 		 msg="修改成功";
			 	 	 }
			 	 	 else{
			 	 	 }
			 	  }
	 	  	  }
 		}
	 	catch(Exception e)
	 	{
	 	msg=e.getMessage();
	 	}
 	}
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save Cats</title>
<style type="text/css"  href= "bottons.css">
   *{font-size:22px;font-family:方正卡通简体;color:#F4A460;}
   #pic{position:absolute; left:40%;top:30px; }
   body {background-color: #FFFFE0;}
   #text{position:absolute; left:33%; top:130px;}
   #pic2{position:absolute; left:36%;top:200px; }
</style>
</head>
<body>
	<div id="pic"><img src="MF.png" alt="猫饭Logo" title="猫饭Logo"></div>
	<p id="text">猫宠已经成功保存啦,<span id="time">3</span>秒钟后我就来啦</p>
	<div id="pic2"><img src="TZ4.png" alt="TZ4" title="TZ4"></div>
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