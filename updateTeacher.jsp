<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

String name = request.getParameter("teacher_name");
String email = request.getParameter("email");
String subject = request.getParameter("subject");
String phone = request.getParameter("phone");

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);
PreparedStatement ps = con.prepareStatement(
    "UPDATE teachers SET teacher_name=?, email=?, subject=?, phone=? WHERE id=?"
);

ps.setString(1, name);
ps.setString(2, email);
ps.setString(3, subject);
ps.setString(4, phone);
ps.setInt(5, id);

int result = ps.executeUpdate();

if(result > 0) {
    response.sendRedirect("viewTeachers.jsp");
}
else {
    out.println("Teacher Not Updated");
}

con.close();
%> 