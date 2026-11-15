<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");

String rollNo = request.getParameter("roll_no");
String name = request.getParameter("name");
String email = request.getParameter("email");
String course = request.getParameter("course");
String semesterText = request.getParameter("semester");

if (rollNo == null || name == null ||
    course == null || semesterText == null ||
    rollNo.trim().isEmpty() ||
    name.trim().isEmpty() ||
    course.trim().isEmpty() ||
    semesterText.trim().isEmpty()) {

    out.println("Please fill all required fields.");

} else {

    try {
        int semester = Integer.parseInt(semesterText);

        if (semester < 1 || semester > 8) {
            out.println("Invalid semester.");
            return;
        }

        Class.forName("com.mysql.jdbc.Driver");

        String url = "jdbc:mysql://localhost:3306/college_erp";
        String user = "root";
        String password = "vikas123";

        Connection con = DriverManager.getConnection(
            url, user, password
        );

        String sql = "INSERT INTO students " +
            "(roll_no, name, email, course, semester) " +
            "VALUES (?, ?, ?, ?, ?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, rollNo.trim());
        ps.setString(2, name.trim());
        ps.setString(3, email == null ? "" : email.trim());
        ps.setString(4, course);
        ps.setInt(5, semester);

        int result = ps.executeUpdate();

        ps.close();
        con.close();

        if (result > 0) {
            response.sendRedirect("viewStudents.jsp");
            return;
        }

    } catch (Exception e) {
        application.log("Student save error", e);
        out.println("Student save nahi hua. ");
        out.println("Error: " + e.getMessage());
    }
}
%>