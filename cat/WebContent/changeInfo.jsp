<%@ page language="java" import="java.util.*,java.sql.*"%>
<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% request.setCharacterEncoding("utf-8");
%>
<%//读数据库，从主页跳转时需要带参数username
    request.setCharacterEncoding("utf-8");
    String selfie="";
    String msg ="";     
    String personSex[]={"",""};
    String catSex[]={"",""};
    String sex="";
    int catNum=0;
    String catName="";
    List<String> cat_ids=new ArrayList<String>();   
    String img_path="";
    String location="";
    String catInfo="";
    String catAge="";
    String cate="";
    String cutename="" ;
    String username=(String)session.getAttribute("User");           
    String connectString = "jdbc:mysql://localhost:3306/maofan"
                    + "?autoReconnect=true&useUnicode=true"
                    + "&characterEncoding=UTF-8"; 
   
    try
    {
          Class.forName("com.mysql.jdbc.Driver");
          Connection con=DriverManager.getConnection(connectString, 
                         "root", "123456");
          Statement stmt=con.createStatement();
          String fmt="select * from personInfo where username='%s'";
          String sql=String.format(fmt,username);
          ResultSet rs=stmt.executeQuery(sql);
          while(rs.next())
          {
             cutename=rs.getString("cutename") ;
             sex=rs.getString("sex");        
             img_path=rs.getString("img_path");
             location=rs.getString("location");
          }
        if(cutename == null) cutename="";
        if(location==null) location="";
        if(sex!=null)
        {
            
            if(sex.indexOf("female")>=0)
            {
                personSex[1]="checked";
            }
            else if(sex.indexOf("male")>=0)
            {
                personSex[0]="checked";
            }
        }
          fmt="select * from catInfo where cat_id in (select cat_id from personCat where username='%s')";
          sql=String.format(fmt,username);
          rs=stmt.executeQuery(sql);
          while(rs.next())
          {
             catNum++;
             catName=rs.getString("cat_name");
             //out.println("<br>catName:"+catName+"<br>");
             sex=rs.getString("cat_sex");
             //out.print(sex);
             catAge=Double.toString(rs.getDouble("age"));
             cate=rs.getString("category");
             if(cate==null)cate="";
             if(sex==null)sex="";
            
                if(sex.indexOf("female")>=0)
                {
                    catSex[1]="checked";
                }
                else if(sex.indexOf("male")>=0)
                {
                    catSex[0]="checked";
                }
             if(catNum==1)
             catInfo+=String.format("<h5>喵咪%s:</h5>",Integer.toString(catNum));
             else
             catInfo+=String.format("<h5 class='h5'>喵咪%s:</h5>",Integer.toString(catNum));

             catInfo+=String.format("<div id='%s'>","cat"+Integer.toString(catNum));
             catInfo+=String.format("<input type='hidden' name='cat_id' value='%s'>",username+Integer.toString(catNum));
             catInfo+=String.format("<p class='label'>昵称：<input name='catName' type='text' value='%s'></p>",catName);
             catInfo+=String.format("<p class='label'>性别：<input name='catSex%d' type='radio' value='male' %s>男宝宝<input name='catSex%d' type='radio' value='female' %s>女宝宝</p>",catNum,catSex[0],catNum,catSex[1]);
             catInfo+=String.format("<p class='label'>年龄：<input name='age' type='text' value='%s'></p>",catAge);
             catInfo+=String.format("<p class='label'>品种：<input name='category' type='text' value='%s'>&nbsp;&nbsp;&nbsp;<a href=delCat.jsp?cat_id='%s'>删除</a></p></div>",cate,username+Integer.toString(catNum));
           }
            
            if(catNum==0)
            {
                catInfo+="<div id='cat1'>"+
                         "<input type='hidden' name='cat_id' value='%s'>"+
                        "<p class='label1'>昵称：<input name='catName' type='text'></p>"+
                        "<p class='label'>性别：<input name='catSex1' type='radio' value='male'>男宝宝"+
                        "<input name='catSex1' type='radio' value='female'>女宝宝</p>"+
                        "<p class='label'>年龄：<input name='age' type='text'></p>"+"<p class='label'>品种：<input name='category' type='text'>&nbsp;&nbsp;&nbsp;<a href=delCat.jsp?cat_id='%s'>删除</a></p></div>";
                catInfo=String.format(catInfo,username+'1',username+Integer.toString(catNum));
            }
             stmt.close();
             con.close();
    }
    catch(Exception e)
    {
        msg=e.getMessage();
    }

    request.setCharacterEncoding("gb2312");
    String fileName = "";
    String relativePath = "";
    String name = "";
    String filePath="";

    if(request.getMethod().equalsIgnoreCase("post"))
    {
        boolean isMultipart=ServletFileUpload.isMultipartContent(request);//检查表单中是否包含文件
        if (isMultipart) {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setHeaderEncoding("gb2312"); 
            List<FileItem> items = upload.parseRequest(request);
            for (int i = 0; i < items.size(); i++) {
                FileItem fi = (FileItem) items.get(i);
                if (!fi.isFormField()) {
                    DiskFileItem dfi = (DiskFileItem) fi;
                    if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
                    //out.print("文件被上传到服务上的实际位置：");
                    fileName=application.getRealPath("/file/")+ System.getProperty("file.separator")+ FilenameUtils.getName(dfi.getName());
                     filePath=new File(fileName).getAbsolutePath();
                    //out.print(filePath);  
                    dfi.write(new File(fileName));
                    }
                    
                    String basePath = request.getScheme() + "://" 
                            + request.getServerName() + ":" + request.getServerPort() 
                            + request.getContextPath() + "/file/";
                    relativePath = basePath+FilenameUtils.getName(dfi.getName());
                    img_path=relativePath;
                    //out.print(String.format("<br><a href='%s'>%s</a>",relativePath,dfi.getName()));

                } //if
            } //for
        } //if
        try{
              Class.forName("com.mysql.jdbc.Driver");
              Connection con=DriverManager.getConnection(connectString, 
                             "root", "123456");
              Statement stmt=con.createStatement();
              String fmt="update personInfo set img_path='%s' where username='%s'";
              String sql=String.format(fmt,relativePath,username);
              int cnt=stmt.executeUpdate(sql);
              if(cnt>0){      
                  msg="上传成功!!!";          
              }
        }
        catch(Exception e)
        {
            msg=e.getMessage();
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
    /*main样式--------------------------------------------------------*/
        #main 
        {   
            height: 1000px ;
            margin: 5px 10px ;
            background-color: #FFFFE0;
            overflow: hidden;
            border: solid 1px #8B4513 ;
            border-radius: 15px ;
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
        #container 
        {
            height: 820px ;
            margin: 2px auto ;
            background-color: #FFFFFF;
            overflow: hidden;
        }
        .character
        {
            text-indent: 5em ;
            text-align: left;
            display: block;
            margin-left: 10px ;
            margin-top: 10px ;
            white-space: pre;
        }
        #person>h3 
        {
            text-indent:1.5em;
            font-size: 25px ;
        }
        .button
        {
            display: block;
            margin: 50px 80px ;
        }
        .pic 
        {
            float:left;
            display:block;
            width:70px;
            height:60px;
            position: relative;
            top: -280px ;
            left: 450px ;
        }
        #cat>h3
        {
            text-indent: -1em;
            font-size: 25px ;
        }
        .label1
        {
            text-indent: 2em ;
        }    
        .label
        {
            text-indent: 8em ;
        }
        .h5
        {
            text-indent: 6em ;
        }
    </style>
</head>
<script type="text/javascript">
    var catNum=<%=catNum%>;
    function addCat(s1)
    {    
        var div = document.getElementById("main") ;

        //alert(catNum);
        catNum++;
        //var username='chenmq'
        var username=document.getElementsByName("host")[0].value;
        //alert("username:::"+username);
        var h5=document.createElement("h5");
        var txt=document.createTextNode("喵咪"+catNum.toString()+":");
        h5.setAttribute("class", "h5");
        h5.appendChild(txt);
        var pa=document.getElementById(s1);
        pa.appendChild(h5);
        
        var ide=document.createElement("input");
        ide.name="cat_id";
        ide.type="hidden";
        ide.value=username+catNum.toString();
        //alert(ide.value);
        //pa.appendChild(ide);
        
        var p1=document.createElement("p");
        p1.setAttribute("class", "label");
        p1.innerHTML="昵称：";
        var in1=document.createElement("input");
        in1.name='catName';
        in1.type="text";
        p1.appendChild(in1);
        
        var p2=document.createElement("p");
        p2.setAttribute("class", "label");
        p2.innerHTML="性别：";
        var in2=document.createElement("input");
        in2.name='catSex'+catNum.toString();
        //alert(in2.name);
        in2.type="radio";
        in2.value="male";
        p2.appendChild(in2);
        var txt1=document.createTextNode("男宝宝");
        p2.appendChild(txt1);
        var in3=document.createElement("input");
        in3.name='catSex'+catNum.toString();
        in3.type="radio";
        in3.value="female";
        p2.appendChild(in3);
        var txt2=document.createTextNode("女宝宝");
        p2.appendChild(txt2);
        
        var p3=document.createElement("p");
        var in4=document.createElement("input");
        p3.setAttribute("class", "label");
        p3.innerHTML="年龄：";
        in4.type="text";
        in4.name="age";
        p3.appendChild(in4);
        
        var p4=document.createElement("p");
        var in5=document.createElement("input");
        p4.setAttribute("class", "label");
        p4.innerHTML="品种：";
        in5.type="text";
        in5.name="category";
        p4.appendChild(in5);
        var space=document.createTextNode("\n");
        p4.appendChild(space);
        var a1=document.createElement("a");
        //alert(a1.href);
        a1.href="delCat.jsp?cat_id="+username+catNum.toString();
        a1.innerHTML="删除";
        p4.appendChild(a1);
        
        var newCat=document.createElement("div");
        newCat.id=username+catNum.toString();
        newCat.appendChild(ide);
        newCat.appendChild(p1);
        newCat.appendChild(p2);
        newCat.appendChild(p3);
        newCat.appendChild(p4);
        pa.appendChild(newCat);
    }
</script>
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
        <div id="person">
            <h3>个人信息</h3>
                <form name="fileUpload" action="changeInfo.jsp" method="POST" enctype="multipart/form-data">
                    <label class="character">上传头像 : <input id="uploadImg" name="img" type="file" value="src">&nbsp;<input type="submit" name='photo' onclick="upload()" value="上传"></label>
                </form>
            <br>
            <form action="saveChanges.jsp" method="post" >
                <label class="character">       昵称 : <input name="cutename" type="text" value=<%=cutename %>></label>
                <br>
                <label class="character">       性别 : <input name="sex" type="radio" value="male" <%=personSex[0] %>>男<input name="sex" type="radio" value="female" <%=personSex[1] %>>女</label>
                <br>
                <label class="character">   所在地 : <input name="location" type="text" value=<%=location %>></label>
                <label class="button">
                    <input type="submit" name="s1" value="保存">          
                </label>
            </form>
            <img class= "pic" id="selfie" src=<%=img_path %> >
        </div>
        
         <form name="cat_info" action="saveCats.jsp" method="post" >
            <div id="cat">
                <h3>喵宠信息</h3>
                <input type="hidden" name="host" value=<%=username %>> 
                    <%=catInfo %>  
                    </div>         
                <p>
                    &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
                    <input type="submit" name="s2" value="提交">
                    &nbsp; &nbsp;&nbsp;
                    <input type="submit" name="e2" value="退出">
                </p>
            </form> 
            <p style="text-align:center"><%=msg %></p>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
            <span class="addCat" ><input type="button" name="addCat" value="添加喵宠" onclick="addCat('cat')" ></span>
        
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