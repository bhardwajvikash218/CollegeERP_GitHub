<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
int studentId = Integer.parseInt(request.getParameter("student_id"));

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

    String sql = "UPDATE attendance SET student_id=?, attendance_date=?, status=?, remarks=? WHERE id=?";

    ps = con.prepareStatement(sql);

    ps.setInt(1, studentId);
    ps.setDate(2, Date.valueOf(attendanceDate));
    ps.setString(3, status);
    ps.setString(4, remarks);
    ps.setInt(5, id);

    int result = ps.executeUpdate();

    if(result > 0) {
        response.sendRedirect("viewAttendance.jsp");
    } else {
        out.println("Attendance record not found!");
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>