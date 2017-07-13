<%@ page language="java" import="java.util.*,java.sql.*"%>
<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% request.setCharacterEncoding("utf-8");
/*从数据库中读取该用户的数据---------------------------------------------------------------*/
    String msg="";
    String flag="0";
    String connectString = "jdbc:mysql://localhost:3306/maofan?characterEncoding=utf8&useSSL=true";
    String user = "root" ; String pwd = "123456" ;  
    String messageinfo = "" ;
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(connectString,user,pwd);
    Statement stmt=con.createStatement(); 
    String fmt="select * from user_message order by time desc";
    String sql=String.format(fmt) ;
    ResultSet rs=stmt.executeQuery(sql);
    int num = 7 ;
    while(rs.next()&&(num>0))
    {
        num = num -1 ;
        String cutename = "" ;
        String user_photo = "" ;
        String username = rs.getString("username") ;
        Connection con1=DriverManager.getConnection(connectString,user,pwd);
        Statement stmt1=con1.createStatement(); 
        String fmt1="select * from personInfo where username='%s'";
        String sql1=String.format(fmt1,username) ;
        ResultSet rs1=stmt1.executeQuery(sql1);
        String path="" ;
        String time="" ;

        while(rs1.next())
        {
            cutename=rs1.getString("cutename") ;
            user_photo=rs1.getString("img_path") ;
        }
        messageinfo += "<div class='showmymessage'>" +
                            "<div class='user_photo'>" +
                                "<img class='pic' src='%s'>"+
                            "</div>"+
                            "<div id='user_message'>"+
                                "<p class='user_message1'><a href=otherhome.jsp?visitee='%s'>'%s'</a></p>"+
                                "<p class='user_message2'>'%s'</p>"+
                                "<p class='user_message3'>'%s'</p>"+
                            "</div>" ;
       path = rs.getString("picture") ;
       time = rs.getString("time") ;
       if(path.equals("http://localhost:8080/cat/file/"))
       {
            messageinfo+="</div>" ;
            messageinfo=(String.format(messageinfo,user_photo,username,cutename,rs.getString("message"),rs.getString("time"),path));
       }
       else
       {
            messageinfo+="<div class='message_photo'>"+
                                "<img class= 'pic2' id='selfie' src='%s'>"+
                               "</div>"+
                        "</div>" ;
            messageinfo=(String.format(messageinfo,user_photo,username,cutename,rs.getString("message"),rs.getString("time"),rs.getString("picture"),path));
       }
    }      
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>首页_猫饭</title>
    <link rel="stylesheet" type="text/css" href="css/font-awesome.css"/>
    <style>
/*style样式--------------------------------------------------------*/
        body
        {
            font-family: Arial,sans-serif;
            color: #000000;
            font-size: 12px;
            margin: 0px auto;
            background: #FFFFE0;  
            width: 800px ;
        }
/*Heade样式--------------------------------------------------------*/
        #header 
        {
            height: 100px;
            margin: 2px auto;
            position: relative;
        }
        #logo
        {
            margin: 5px 5px 5px 10px ;
            float: left;
        }
        /*content样式--------------------------------------------------------*/
            #content
            {
                border:1px solid #8B4513;
                width: 480px ;
                margin-top: 60px ;
                margin-left: 80px ;
                float: left;
                border-radius: 15px ;
                font-size: 15px ;
            }
            a
            {
                display: inline-block;
                margin: 5px 5px ;
                text-align: center;
                padding: 2px 2px ;
            }
            #content>a:hover 
            {
                background: blue ;
                color: white ;
            }
/*main样式---------------------------------------------------------*/
        #main 
        {   
            height: 820px ;
            margin: 2px auto ;
            background-color: #FFFFE0;
            overflow: hidden;
        }
        /*mainpage样式--------------------------------------------------------*/
        #mainpage
        {
            border:1px solid #8B4513;
            float: left;
            width: 550px ;
            height: 800px ;
            margin: 2px 10px ;
            margin-right: 0px ;
            border-radius: 15px 0px 0px 15px ;
        }
            /*helptip样式--------------------------------------------------------*/
            #helptip
            {
                border:1px solid #8B4513;
                margin: 20px 20px 0px 20px  ;
            }
            #helptip>h3
            {
                padding: 0px 0px 12px 0px;
                margin: 10px 15px 5px 10px;
                font-weight: bold;
                background: url(line.gif) repeat-x bottom;
            }
            .showmymessage
            {
                border: dashed 1px #8B4513;
                border-left: none;
                border-right: none;
                margin: 20px 20px 0px 20px  ;
                height: 80px ;
            }
            .showmymessage>.user_photo
            {
                margin: 10px 5px ;
                float: left;
                width: 50px ;
                height: 40px ;
                overflow: hidden;
                border: solid 1px #8B4513 ;
            }
            .pic 
            {
                display:block;
                width:50px;
                height:40px;
            }
            .user_message1
            {
                display: inline-block;
                float: left;
                font-size: 18px ;
                color: blue ;
                margin: -10px 2px ;
            }
            .showmymessage>.message_photo
            {
                margin: -55px 5px ;
                margin-right: 50px ;
                float: right;
                width: 70px ;
                height: 60px ;
                overflow: hidden;
            }
            .pic2 
            {
                display:block;
                width:70px;
                height:60px;
            }
        #sidepage
        {
            border:1px solid #8B4513;
            float: left;
            width: 225px ;
            margin: 2px 10px ;
            margin-left: 0px ;
            height: 800px ;
            border-radius: 0px 15px 15px 0px ;
        }
            #sidepage>h1
            {
                font-size: 20px ;
                margin-left: 5px ;
            }
            #sidepage>li
            {
                margin: 5px 20px ;

            }
/*footer样式-------------------------------------------------------*/
        #footer 
        {
            border:1px solid #8B4513;
            height: 100px;
            margin: 5px 10px;
            border-radius: 15px ;
        }
        .bottomlogo 
        {
            padding: 5px 10px;
            float: left;
        }
        .bottomcontact_cn 
        {
            position: relative;
            left: 80px ;
            width: 400px;
            height: 40px;
            padding: 2px 20px 5px 20px;
            line-height: 24px;
            float: left;
        }
        .bottomcontact_en 
        {
            position: relative;
            left: 80px ;
            width: 400px;
            height: 40px;
            padding: 2px 20px 5px 20px;
            line-height: 24px;
            float: left;
        }
    </style>
</head>

<body>
    <div id="header">
        <div id="logo">
           <img src="20170510141241.png">
        </div>
        <div id="content">
            <a></a>
            <a href="home.jsp">首页</a>
            <a href="personhome.jsp">我的空间</a>
            <a href="">私信</a>
            <a href="">找人</a>
            <a href="kankan.jsp">随便看看</a>
            <a href="">搜索</a>
            <a href="changeInfo.jsp">设置</a>
            <a href="login.jsp">退出</a>          
        </div>
    </div>
    <a href=""></a>
    <div id="main">
        <div id="mainpage">
            <div id="helptip">
                <h3>随便看看其他人在做什么...</h3>
            </div> 
            <%=messageinfo%>
        </div>
        <div id="sidepage">
            <h1>公告</h1>
            <li>短信特服号：1000 0000 0000</li>
            <li>彩信请发到：m@maofan.com</li>
            <li>猫饭手机版：m.maofan.com</li>
            <li>猫饭iphone：m.maofan.com</li>
            <li><a href="">更多历史公告</a></li>
        </div>
    </div>
    
    <div id="footer">
        <div class="bottomlogo">
            <img src="20170510141241.png">
        </div>
        <div class="bottomcontact_cn">
            通讯地址:广州市新港西路135号     邮编:510275<br>
            电话: 020-84112828
        </div>
        <div class="bottomcontact_en">
            Address: No. 135, Xingang Xi Road, Guangzhou, 510275, P. R. China<br>
            TEL: +86-20-84112828
        </div>
        <div class="clear"></div>
    </div>
</body>
</html>