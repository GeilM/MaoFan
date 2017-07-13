<%@ page language="java" import="java.util.*,java.sql.*"%>
<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% request.setCharacterEncoding("utf-8");
    String connectString = "jdbc:mysql://localhost:3306/maofan?characterEncoding=utf8&useSSL=true";
    String user = "root" ; String pwd = "123456" ;  
    String username = (String)session.getAttribute("User") ;
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
        li
        {
            list-style: none;
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
/*main样式--------------------------------------------------------*/
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
            /*头像框显示样式--------------------------------------------------------*/
            #user_top
            {
                height: 150px ;
                width: 500px ;
            }
            #user_top>h3
            {
                display: block;
                font-weight: bold;
                z-index: -5 ;
                padding-left: 30px ;
                padding-top: -30px ;
                font-size: 30px ;
                float: left;
            }
            #userphoto
            {
                margin: 20px 20px ;
                width: 100px ;
                height: 100px ;
                border: solid 1px #8B4513 ;
                float: left;
            }
            #userphotogra
            {
                width: 100px ;
                height: 100px ;
            }
            /*消息显示-------------------------------------------------------------------------*/
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
                font-size: 20px ;
                color: blue ;
                margin: -5px 5px ;
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
            /*user_stats样式--------------------------------------------------------*/
            #user_stats
            {
                margin: 5px 5px;
                height: 100px ;
            }
            #user_stats>a
            {
                font-size: 20px ;
                margin: 10px 3px;
                display: inline-block;
            }        
/*footer样式--------------------------------------------------------*/        
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
        .del
        {
            position: relative;
            top: -15px ;
            left: 475px;
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
    
    <div id="main">
        <div id="mainpage">
            <%
                /*从数据库中读取该用户的数据---------------------------------------------------------------*/
                    String messageinfo = "" ;
                    Class.forName("com.mysql.jdbc.Driver");
                    
                    String cutename = "" ;
                    String user_photo = "" ;

                    Connection con2=DriverManager.getConnection(connectString,user,pwd);
                    Statement stmt2=con2.createStatement(); 
                    String fmt2="select * from personInfo where username='%s'";
                    String sql2=String.format(fmt2,username) ;
                    ResultSet rs1=stmt2.executeQuery(sql2);
                    int num = 6 ; 
                    while(rs1.next())
                    {
                        cutename=rs1.getString("cutename") ;
                        user_photo=rs1.getString("img_path");
                    }
            %>
            <div id="user_top">
                <div id="userphoto">
                    <img id="userphotogra"  src=<%=user_photo%> />
                </div>
                <h3 id="user_cutename"><%=cutename%></h3>
            </div>
            <%
                Connection con1=DriverManager.getConnection(connectString,user,pwd);
                Statement stmt1=con1.createStatement(); 
                String fmt1="select * from user_message where username='%s' order by time desc";
                String sql1=String.format(fmt1,username) ;
                ResultSet rs=stmt1.executeQuery(sql1);
                String path = "" ;
                String time = "" ;
                while(rs.next()&&(num>0))
                {
                    num = num-1 ;
                    messageinfo += "<div class='showmymessage'>" +
                                        "<div id='user_message'>"+
                                            "<p class='user_message2'>'%s'</p>"+
                                            "<p class='user_message3'>'%s'</p>"+
                                        "</div>" ;
                   path = rs.getString("picture") ;
                   time = rs.getString("time") ;
                   if(path.equals("http://localhost:8080/cat/file/"))
                   {
                        messageinfo+="<a class='del' href=delMessage.jsp?path='%s'>删除</a>"+"</div>" ;
                        messageinfo=(String.format(messageinfo,rs.getString("message"),rs.getString("time"),path));
                   }
                   else
                   {
                        messageinfo+="<div class='message_photo'>"+
                                            "<img class= 'pic2' id='selfie' src='%s'>"+
                                           "</div>"+
                                     "<a class='del' href=delMessage.jsp?path='%s'>删除</a>"+
                                    "</div>" ;
                        messageinfo=(String.format(messageinfo,rs.getString("message"),rs.getString("time"),rs.getString("picture"),path));
                   }
                    
                }

                /*取关注的人数，被关注的人数，信息数------------------------------------------------------------------*/
                    String myattention = "" ;
                    String myattentioned = "" ;
                    String mymessagenum = "" ;
                    Connection con6=DriverManager.getConnection(connectString,user,pwd);
                    Statement stmt6=con6.createStatement(); 
                    String fmt6="select count(visitee) as numofvisitee from attention where visiter='%s'";
                    String sql6=String.format(fmt6,username) ;
                    ResultSet rs6=stmt6.executeQuery(sql6);
                    while(rs6.next())
                    {
                        myattention = rs6.getString("numofvisitee") ;
                    }
                    fmt6 = fmt6="select count(visiter) as numofvisiter from attention where visitee='%s'";
                    sql6 = String.format(fmt6,username) ;
                    rs6 = stmt6.executeQuery(sql6);
                    while(rs6.next())
                    {
                        myattentioned = rs6.getString("numofvisiter") ;
                    }
                    fmt6 = fmt6="select count(message) as numofmessage from user_message where username='%s'";
                    sql6 = String.format(fmt6,username) ;
                    rs6 = stmt6.executeQuery(sql6);
                    while(rs6.next())
                    {
                        mymessagenum = rs6.getString("numofmessage") ;
                    }         
            %>
            <%=messageinfo%>
        </div>
        <div id="sidepage">
            <div id="user_stats">
                <a href=""><span class="count"><%=myattention%></span> <span class="label">我关注的人</span></a>
                <br>      
                <a href=""><span class="count"><%=myattentioned%></span> <span class="label">关注我的人</span></a>
                <br>
                <a href=""><span class="count"><%=mymessagenum%></span> <span class="label">消息</span></a>
            </div>
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