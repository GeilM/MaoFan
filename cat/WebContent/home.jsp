<%@ page language="java" import="java.util.*,java.sql.*"%>
<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% request.setCharacterEncoding("utf-8");
/*获取当前时间------------------------------------------------------------------------------*/
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.util.Date currentTime = new java.util.Date();//得到当前系统时间
String str_date1 = formatter.format(currentTime); //将日期时间格式化 
String str_date2 = currentTime.toString(); //将Date型日期时间转换成字符串形式 
/*上传图片---------------------------------------------------------------------------------*/
    String photoname = "" ;
    String path = "" ;
    String img_path = "" ;
    String fileName = "";
    String relativePath = "";
    String name = "";
    String filePath="";
    String other = "" ;
    boolean isMultipart=ServletFileUpload.isMultipartContent(request);//检查表单中是否包含文件
    if (isMultipart) 
    {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("gb2312"); 
            List<FileItem> items = upload.parseRequest(request);
            for (int i = 0; i < items.size(); i++) 
            {
                FileItem fi = (FileItem) items.get(i);
                if(fi.isFormField())
                {
                    other = fi.getString("utf-8") ;
                }
                else
                {
                    DiskFileItem dfi = (DiskFileItem) fi;
                    if (!dfi.getName().trim().equals("")) 
                    {   
                        fileName=application.getRealPath("/file/")+ System.getProperty("file.separator")+ FilenameUtils.getName(dfi.getName());
                         filePath=new File(fileName).getAbsolutePath();
                        //out.print(filePath);  
                        dfi.write(new File(fileName));
                    }
                    
                    String basePath = request.getScheme() + "://" 
                            + request.getServerName() + ":" + request.getServerPort() 
                            + request.getContextPath() + "/file/";
                    relativePath = basePath+FilenameUtils.getName(dfi.getName());
                    photoname = FilenameUtils.getName(dfi.getName()) ;
                    img_path=relativePath;
                } 
            } 
     }
/*上传信息至数据库--------------------------------------------------------------------------------------------------------*/
    String msg="";
    String flag="0";
    String connectString = "jdbc:mysql://localhost:3306/maofan?characterEncoding=utf8&useSSL=true";
    String user = "root" ; String pwd = "123456" ;  
    String username = (String)session.getAttribute("User") ;   
    
    if(request.getMethod().equalsIgnoreCase("post"))
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection(connectString,user,pwd);
        Statement stmt=con.createStatement(); 
        try
        {
            String fmt="insert into user_message(username,message,picture,time) values('%s','%s','%s','%s')";
            String sql = String.format(fmt,username,other,img_path,str_date1);
            int cnt = stmt.executeUpdate(sql);
            if(cnt>0)msg = "保存成功!";
            stmt.close();
            con.close();
        }
        catch (Exception e)
        {
            msg = e.getMessage();
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
            *{font-family:Arial,sans-serif; color:#F4A460;}
            body
            {
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
                background: #FFFFE0;
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
                #seehere
                {
                    padding: 0px 0px 0px 0px;
                    margin: 0px 15px 5px 10px;
                }
                /*inputdata样式--------------------------------------------------------*/
                h2
                {
                    margin: 10px 20px 10px 20px  ;
                }
                .textarea-wrapper
                {
                    margin: 10px 20px 10px 20px  ;
                }
                #imagelogo
                {
                    margin: 0px 20px 0px 20px  ;
                    z-index: 5 ;
                }
                #upload-image
                {
                    position: relative;
                    top: -5px;
                    left: -50px ;
                    width: 20px ;
                    filter:alpha(opacity=0);
                    -moz-opacity:0;
                    opacity: 0 ;
                }
                #inputsubmit
                {
                    position: relative;
                    top: -5px ;
                    left: 395px ;
                }
                .showmymessage
                {
                    border: dashed 1px grey;
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
                    border: solid 1px rgba(45,200,255,1) ;
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
                /*user_top样式--------------------------------------------------------*/
                #user_top
                {
                    padding-bottom: 10px ;
                    margin-bottom: 5px ;
                    background: url(line.gif) repeat-x bottom;
                    height: 80px ;
                } 
                #user_top>h3
                {
                    display: block;
                    font-weight: bold;
                    z-index: -5 ;
                    padding-left: 75px ;
                    padding-top: 10px ;
                }
                #userphoto
                {
                    margin: 10px 10px ;
                    margin-right: 5px ;
                    float: left;
                    width: 50px ;
                    height: 40px ;
                    overflow: hidden;
                    border: solid 1px rgba(45,200,255,1) ;
                }
                #userphotogra
                {
                    display:block;
                    width:50px;
                    height:40px;
                }
                #a1
                {
                    float: left;
                    display: block;
                    margin: 20px -60px ;
                }
                #a2
                {
                    float: left;
                    display: block;
                    margin: 20px 15px ;
                }
                /*user_stats样式--------------------------------------------------------*/
                #user_stats
                {
                    margin: 5px 5px;
                    height: 30px ;
                }
                #user_stats>a
                {
                    font-size: 10px ;
                    margin: 0px 3px;
                    display: inline-block;
                    cursor: pointer;
                    float: left;
                }
                /*goodapp样式--------------------------------------------------------*/
                #goodapp
                {
                    height: 230px ;
                    margin: 5px 5px ;
                }
                #goodapp>span
                {
                    display: inline-block;
                    margin: 1px 5px ;
                    text-align: left;
                    font-size: 13px ;
                }
                #goodapp>strong
                {
                    text-align: left;
                }
                #goodapp div
                {
                    margin: 8px auto ;
                }
                /*navtabs样式--------------------------------------------------------*/
                #navtabs
                {
                    text-align: left;
                    text-indent: 5px ;
                }
                #searchr
                {
                    margin: 5px 11px ;
                }
                /*trendtabs样式--------------------------------------------------------*/
                #trendtabs
                {
                    text-align: left;
                    text-indent: 5px ;
                }
                #trendtabs>h2
                {
                    text-indent: -5px ;
                }
                /*sect样式--------------------------------------------------------*/
                #sect
                {
                    margin: 0px 0px ;
                }
                #sect>h2
                {
                    text-indent: -5px ;
                    display: inline-block;
                    margin: 2px 15px ;
                }
                #sect>p
                {
                    text-align: left;
                    text-indent: 15px ;
                    display: inline-block;
                    margin: 1.8px -5px ;
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
    /*新增样式----------------------------------------------------------*/
        
     /*   #content
        {
            border:1px solid #8B4513;
            float: right; 
        }
        #main
        {
            background-color: #FFFFE0;
        }
        #mainpage
        {
            background: #FFFFE0;
        }
        #helptip
        {
            border:1px solid #8B4513;
        }
        #sidepage
        {
            border:1px solid #8B4513;
            background: #FFFFE0;
        }
        #footer
        {
            border:1px solid #8B4513;
        }*/
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
            <div id="helptip">
                <h3>新手上路</h3>
                <div id="seehere">猫饭是方便你随时随地交流与分享的迷你博客。可以通过网页/MSN/QQ/手机等几十种方式使用，想知道更多关于猫饭的用法？ <a target="_blank" href="help.jsp">查看这里» </a>
                </div>   
            </div> 
            <div id="inputdata">
                <form name="Upload" action="home.jsp" method="POST" enctype="multipart/form-data">
                    <h2 class="slogan">你在做什么</h2>
                    <div class="textarea-wrapper">
                        <textarea tabindex="1" name="other" rows="3" cols="70" class="qs" id ="tt"></textarea>
                    </div>                     
                    <div class="act">
                        <i id="imagelogo" class="fa fa-picture-o fa-2x" aria-hidden="true"></i>
                        <input title="上传图片，最大2MB"  type="file" name="picture" id="upload-image" /> 
                        <input id="inputsubmit" tabindex="2" type="submit" class="formbutton" title="按Ctrl+Enter键发送消息" value="发送"/>
                    </div>
                    
                </form>           
            </div>
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
                int num = 5 ; 
                while(rs1.next())
                {
                    cutename=rs1.getString("cutename") ;
                    user_photo=rs1.getString("img_path");
                }
                Connection con1=DriverManager.getConnection(connectString,user,pwd);
                Statement stmt1=con1.createStatement(); 
                String fmt1="select * from user_message where username='%s' order by time desc";
                String sql1=String.format(fmt1,username) ;
                ResultSet rs=stmt1.executeQuery(sql1);
                String time = "" ;
                while(rs.next()&&(num>0))
                {
                    num = num-1 ;
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
            /*取关注的人的消息----------------------------------------------------------------------*/
                Connection con3=DriverManager.getConnection(connectString,user,pwd);
                Statement stmt3=con3.createStatement(); 
                String fmt3="select * from attention where visiter='%s'";
                String sql3=String.format(fmt3,username) ;
                ResultSet rs3=stmt3.executeQuery(sql3);
                String cutename2 = "" ;
                String user_photo2 = "" ;
                while(rs3.next())
                {
                    String visitee = rs3.getString("visitee") ;
                    
                    Connection con4=DriverManager.getConnection(connectString,user,pwd);
                    Statement stmt4=con4.createStatement(); 
                    String fmt4="select * from personInfo where username='%s'";
                    String sql4=String.format(fmt4,visitee) ;
                    ResultSet rs4=stmt4.executeQuery(sql4);
                    while(rs4.next())
                    {
                        cutename2=rs4.getString("cutename") ;
                        user_photo2=rs4.getString("img_path");
                    }
                    Connection con5=DriverManager.getConnection(connectString,user,pwd);
                    Statement stmt5=con5.createStatement(); 
                    String fmt5="select * from user_message where username='%s' order by time desc";
                    String sql5=String.format(fmt5,visitee) ;
                    ResultSet rs5=stmt5.executeQuery(sql5);
                    while(rs5.next())
                    {
                        messageinfo += "<div class='showmymessage'>" +
                                "<div class='user_photo'>" +
                                    "<img class='pic' src='%s'>"+
                                "</div>"+
                                "<div id='user_message'>"+
                                    "<p class='user_message1'><a href=otherhome.jsp?visitee='%s'>'%s'</a></p>"+
                                    "<p class='user_message2'>'%s'</p>"+
                                    "<p class='user_message3'>'%s'</p>"+
                                "</div>" ;
                       path = rs5.getString("picture") ;
                       time = rs5.getString("time") ;
                       if(path.equals("http://localhost:8080/cat/file/"))
                       {
                            messageinfo+="</div>" ;
                            messageinfo=(String.format(messageinfo,user_photo2,visitee,cutename2,rs5.getString("message"),rs5.getString("time"),path));
                       }
                       else
                       {
                            messageinfo+="<div class='message_photo'>"+
                                                "<img class= 'pic2' id='selfie' src='%s'>"+
                                               "</div>"+
                                        "</div>" ;
                            messageinfo=(String.format(messageinfo,user_photo2,visitee,cutename2,rs5.getString("message"),rs5.getString("time"),rs5.getString("picture"),path));
                       }
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
            <div id="user_top">
                <div id="userphoto">
                    <img id="userphotogra"  src=<%=user_photo%> />
                </div>
                <h3 id="user_cutename"><%=cutename%></h3>
                <a id ="a1" href="changeInfo.jsp">上传头像！</a>
                <a id ="a2" href="changeInfo.jsp">绑定手机！</a>
            </div>
            <div id="user_stats">
                <a href=""><span class="count"><%=myattention%></span> <span class="label">我关注的人</span></a>      
                <a href=""><span class="count"><%=myattentioned%></span> <span class="label">关注我的人</span></a>
                <a href=""><span class="count"><%=mymessagenum%></span> <span class="label">消息</span></a>
            </div>
            <div id="goodapp">
                <a href="" target="_blank">
                <strong>猫饭微信机器人</strong>
                <a></a>
                <span>猫饭非官方微信机器人，你可以在微信中直接发送猫饭消息以及查看猫饭消息。
                    <div style="text-align: center">
                        <img width="128" height="128" style="margin: 0.5em;" src="http://mtmos.com/v1/mss_3d027b52ec5a4d589e68050845611e68/ff/n0/0b/n0/xq_161298.jpg">
                    </div>
                </span>
                </a>
            </div> 
            <div class="stabs" id="navtabs">
                    <li id="navtabs-home"  class="current"><a href="" style="font-size:16px ;">首页</a></li>
                    <li><a href=""><span class="label">@提到我的</span> </a></li>
                    <li><a href=""><span class="label">私信</span> </a></li>
                    <li><a href=""><span class="label">收藏</span></a></li>
                    <li><a href=""><span class="label">照片</span></a></li>
            </div>
            <div id="searchr">
                <form action="http://fanfou.com/search" method="get" id="searchr-form">
                <input type="text" id="searchr-input" name="q" value="" /><input type="submit" id="searchr-submit" value="搜索" />
                </form>
            </div>
            <div id="savedsearchs" class="stabs colltab trendtabs" style="display:none;">
                <b></b>
                <h2>保存的搜索</h2>
                <ul></ul>
            </div>
            <div class="stabs colltab trendtabs" id="trendtabs">
                <b id="trendicon"></b>
                <h2 id="trendtitle">热门话题</h2>
                <li><a href="" squery="沙尘暴"><span class="label">沙尘暴</span></a></li>
                <li><a href="" squery="T恤"><span class="label">T恤</span></a></li>    
            </div>
            <div id="sect">
                <h2>邀请朋友加入</h2>
                <p>把下面的网址通过MSN/QQ发送给朋友</p>
                <p><textarea name="invite-url" id="invite-url" rows="2" cols="25" class="auto-select" readonly="readonly"></textarea></p>
                <p class="formtip">朋友注册后会自动关注你</p>
                <p>或者 <a href="/finder#finder_invite">发 Email 邀请朋友</a></p>
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