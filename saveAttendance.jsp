<%@ page import="java.sql.*" %>

<%
String studentId = request.getParameter("student_id");
String attendanceDate = request.getParameter("attendance_date");
String status = request.getParameter("status");
String remarks = request.getParameter("remarks");

Connection con = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    String sql = "INSERT INTO attendance (student_id, attendance_date, status, remarks) VALUES (?, ?, ?, ?)";

    ps = con.prepareStatement(sql);

    ps.setInt(1, Integer.parseInt(studentId));
    ps.setDate(2, Date.valueOf(attendanceDate));
    ps.setString(3, status);
    ps.setString(4, remarks);

    int result = ps.executeUpdate();

    if (result > 0) {
        out.println("<h3>Attendance Saved Successfully!</h3>");
        out.println("<a href='markAttendance.jsp'>Mark Another Attendance</a>");
    }

} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if (ps != null) ps.close();
    if (con != null) con.close();
}
%>