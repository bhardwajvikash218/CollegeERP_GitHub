<%@ page language="java" import="java.sql.*" %>
<html>
<head>
    <title>Database Connection</title>
</head>
<body>
    <h2>College ERP - Database Connection</h2>
    <%
    String url="jdbc:mysql://localhost:3306/college_erp";
    String user="root";
    String password="vikas123";
    try{
        Class.forName("com.mysql.cjdbc.Driver");
        Connection con=DriverManager.getConnection(url, user, password);
        out.println("<h3 style='color:green;'>Database Connected Successfully!</h3>");
        con.close();
    }
    catch (Exception e) {
        out.println("<h3 style='color:red;'>Database Connection Failed!</h3>");
        out.println("<p>" + e.getMessage() + "</p>");
    }
    %>
</body>
</html>