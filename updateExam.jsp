<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

String examName = request.getParameter("exam_name");
String examType = request.getParameter("exam_type");
int subjectId = Integer.parseInt(request.getParameter("subject_id"));
int semester = Integer.parseInt(request.getParameter("semester"));
String examDate = request.getParameter("exam_date");
int totalMarks = Integer.parseInt(request.getParameter("total_marks"));
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

    String sql = "UPDATE exams SET exam_name=?, exam_type=?, " +
                 "subject_id=?, semester=?, exam_date=?, " +
                 "total_marks=?, description=? WHERE id=?";

    ps = con.prepareStatement(sql);

    ps.setString(1, examName);
    ps.setString(2, examType);
    ps.setInt(3, subjectId);
    ps.setInt(4, semester);
    ps.setDate(5, Date.valueOf(examDate));
    ps.setInt(6, totalMarks);
    ps.setString(7, description);
    ps.setInt(8, id);

    int result = ps.executeUpdate();

    if(result > 0) {
        response.sendRedirect("viewExams.jsp");
    } else {
        out.println("Exam record not found!");
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>