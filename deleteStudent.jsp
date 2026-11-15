<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");

if (!"POST".equalsIgnoreCase(request.getMethod())) {
    response.sendError(405, "POST method required.");
    return;
}

String idText = request.getParameter("id");

try {
    int id = Integer.parseInt(idText);

    if (id <= 0) {
        response.sendError(400, "Invalid student ID.");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/college_erp";

    Class.forName("com.mysql.jdbc.Driver");

    try (
        Connection con = DriverManager.getConnection(url, "root", System.getenv("DB_PASSWORD"));
        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM students WHERE id = ?"
        )
    ) {
        ps.setInt(1, id);

        int result = ps.executeUpdate();

        if (result > 0) {
            response.sendRedirect("viewStudents.jsp");
            return;
        } else {
            out.println("Student record nahi mila.");
        }
    }

} catch (Exception e) {
    application.log("Delete student error", e);
    response.setStatus(500);
    out.println("Student delete nahi hua. Tomcat logs check karo.");
}
%>