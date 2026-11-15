<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

String name = request.getParameter("subject_name");
String code = request.getParameter("subject_code");
int semester = Integer.parseInt(request.getParameter("semester"));
String description = request.getParameter("description");

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);

PreparedStatement ps = con.prepareStatement(
    "UPDATE subjects SET subject_name=?, subject_code=?, semester=?, description=? WHERE id=?"
);

ps.setString(1, name);
ps.setString(2, code);
ps.setInt(3, semester);
ps.setString(4, description);
ps.setInt(5, id);

int result = ps.executeUpdate();

if(result > 0) {
    response.sendRedirect("viewSubjects.jsp");
} else {
    out.println("Subject Not Updated");
}

con.close();
%>