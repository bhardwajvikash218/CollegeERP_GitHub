<%@ page import="java.sql.*" %>

<%
String subjectName = request.getParameter("subject_name");
String subjectCode = request.getParameter("subject_code");
int semester = Integer.parseInt(request.getParameter("semester"));
String description = request.getParameter("description");

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);
PreparedStatement ps = con.prepareStatement(
    "INSERT INTO subjects (subject_name, subject_code, semester, description) VALUES (?, ?, ?, ?)"
);

ps.setString(1, subjectName);
ps.setString(2, subjectCode);
ps.setInt(3, semester);
ps.setString(4, description);

int result = ps.executeUpdate();

if(result > 0) {
    response.sendRedirect("viewSubjects.jsp");
} else {
    out.println("Subject Not Saved");
}

con.close();
%>