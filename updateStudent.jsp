<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");

String idText = request.getParameter("id");
String rollNo = request.getParameter("roll_no");
String name = request.getParameter("name");
String email = request.getParameter("email");
String course = request.getParameter("course");
String semesterText = request.getParameter("semester");

try {
    int id = Integer.parseInt(idText);
    int semester = Integer.parseInt(semesterText);

    if (id <= 0 || semester < 1 || semester > 8 ||
        rollNo == null || rollNo.trim().isEmpty() ||
        name == null || name.trim().isEmpty() ||
        course == null || course.trim().isEmpty()) {

        response.sendError(400, "Invalid student details.");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/college_erp";

    try (Connection con = DriverManager.getConnection(url, "root", System.getenv("DB_PASSWORD"));
         PreparedStatement ps = con.prepareStatement(
             "UPDATE students SET roll_no=?, name=?, email=?, " +
             "course=?, semester=? WHERE id=?")) {

        ps.setString(1, rollNo.trim());
        ps.setString(2, name.trim());
        ps.setString(3, email == null ? "" : email.trim());
        ps.setString(4, course.trim());
        ps.setInt(5, semester);
        ps.setInt(6, id);

        ps.executeUpdate();

        response.sendRedirect("viewStudents.jsp");
        return;
    }

} catch (Exception e) {
    application.log("Update student error", e);
    response.setStatus(500);
    out.println("Student update nahi hua. Tomcat logs check karo.");
}
%>