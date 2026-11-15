<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);

PreparedStatement ps = con.prepareStatement(
    "DELETE FROM subjects WHERE id=?"
);

ps.setInt(1, id);

int result = ps.executeUpdate();

if(result > 0) {
    response.sendRedirect("viewSubjects.jsp");
} else {
    out.println("Subject Not Deleted");
}

con.close();
%>