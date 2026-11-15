<%@ page import="java.sql.*" %>

<%
String name = request.getParameter("teacher_name");
String email = request.getParameter("email");
String subject = request.getParameter("subject");
String phone = request.getParameter("phone");

try {

    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO teachers (teacher_name, email, subject, phone) VALUES (?, ?, ?, ?)"
    );

    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, subject);
    ps.setString(4, phone);

    int i = ps.executeUpdate();

    if(i > 0) {
        out.println("Teacher Added Successfully!");
    }

    con.close();

} catch(Exception e) {
    out.println(e);
}
%>