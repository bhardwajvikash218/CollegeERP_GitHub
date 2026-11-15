<%@ page import="java.sql.*" %>

<%
String examName = request.getParameter("exam_name");
String examType = request.getParameter("exam_type");
String subjectId = request.getParameter("subject_id");
String semester = request.getParameter("semester");
String examDate = request.getParameter("exam_date");
String totalMarks = request.getParameter("total_marks");
String description = request.getParameter("description");

Connection con = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    String sql = "INSERT INTO exams " +
        "(exam_name, exam_type, subject_id, semester, exam_date, total_marks, description) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";

    ps = con.prepareStatement(sql);

    ps.setString(1, examName);
    ps.setString(2, examType);
    ps.setInt(3, Integer.parseInt(subjectId));
    ps.setInt(4, Integer.parseInt(semester));
    ps.setDate(5, Date.valueOf(examDate));
    ps.setInt(6, Integer.parseInt(totalMarks));
    ps.setString(7, description);

    int result = ps.executeUpdate();

    if(result > 0) {
        response.sendRedirect("viewExams.jsp");
    } else {
        out.println("Exam not saved!");
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>