<%@ page contentType="text/html; charset=gb2312" %>   
<%@ page language="java" %>      
<%@ page import="java.sql.*" %>   
<%   
String driverName="com.mysql.jdbc.Driver";   
String userName="root";   
String userPasswd="123456";   
String dbName="maofan";   
String tableName="user";   
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/"+dbName+"?user="+userName+"&password="+userPasswd;    
Connection conn=DriverManager.getConnection(url);   
Statement stmt = conn.createStatement();   
String sql="SELECT * FROM "+tableName;   
ResultSet rs = stmt.executeQuery(sql);   
out.print("id");   
out.print("|");   
out.print("name");   
out.print("|");   
out.print("phone");   
out.print("<br>");   
while(rs.next()) {   
out.print(rs.getString(1)+" ");   
out.print("|");   
out.print(rs.getString(2)+" ");   
out.print("|");   
out.print(rs.getString(3));   
out.print("<br>");   
}   
out.print("<br>");   
out.print("ok， Database Query Successd！");   
rs.close();   
stmt.close();   
conn.close();   
%>  