<%@ page language="java" import="java.util.*,java.sql.*"%>
<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% request.setCharacterEncoding("utf-8");
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
    /*main样式--------------------------------------------------------*/
        #main 
        {   
            height: 350px ;
            margin: 5px 10px ;
            background-color: #FFFFE0;
            overflow: hidden;
            border: solid 1px #8B4513 ;
            border-radius: 15px ;
            font-size: 20px ;   
        }
        p
        {
            display: block;
            margin:30px 30px ;
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
        <p>1.点击设置连接即可前去设置用户头像，昵称，性别，所在地。还可以添加猫宠，以及查看或更改猫宠信息。</p>
        <p>2.在首页中可以随时发送动态，动态可以点击图片按钮添加图片。首页栏可以查看自己发送的动态和已关注用户所发送的动态。</p>
        <p>3.在我的空间中可以查看自己发过的所有动态并且可以随时删除。</p>
        <p>4.在随便看看中可以查看当下身边的好友发送过的动态，如果对某个用户感兴趣可以点击它的昵称，进入到Ta的个人主页查看Ta所发送过的信息。</p>
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