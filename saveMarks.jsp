<%@ page import="java.sql.*" %>

<%
String examId = request.getParameter("exam_id");
String studentId = request.getParameter("student_id");
String marks = request.getParameter("marks_obtained");
String remarks = request.getParameter("remarks");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    int eId = Integer.parseInt(examId);
    int sId = Integer.parseInt(studentId);
    double obtainedMarks = Double.parseDouble(marks);

    // Check Exam Total Marks

    ps = con.prepareStatement(
        "SELECT total_marks FROM exams WHERE id=?"
    );

    ps.setInt(1, eId);
    rs = ps.executeQuery();

    if(!rs.next()) {
        out.println("Exam not found!");
    } else {

        double totalMarks = rs.getDouble("total_marks");
        rs.close();
        ps.close();
        rs = null;
        ps = null;

        if(obtainedMarks < 0 || obtainedMarks > totalMarks) {

            out.println("Invalid Marks! Maximum marks are " + totalMarks);

        } else {

            // Save Student Marks

            ps = con.prepareStatement(
                "INSERT INTO student_marks " +
                "(exam_id, student_id, marks_obtained, remarks) " +
                "VALUES (?, ?, ?, ?)"
            );

            ps.setInt(1, eId);
            ps.setInt(2, sId);
            ps.setDouble(3, obtainedMarks);
            ps.setString(4, remarks);

            int result = ps.executeUpdate();

            if(result > 0) {
                response.sendRedirect("viewMarks.jsp");
            } else {
                out.println("Marks not saved!");
            }
        }
    }

} catch(Exception e) {

    out.println("Error: " + e.getMessage());

} finally {

    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();

}
%>