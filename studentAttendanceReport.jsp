<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Attendance Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Student-wise Attendance Report</h2>

<form method="get" action="studentAttendanceReport.jsp">

    <div class="mb-3">
        <label>Enter Student ID</label>
        <input type="number" name="student_id"
               class="form-control" required>
    </div>

    <button type="submit" class="btn btn-primary">
        Search Report
    </button>

</form>

<hr>

<%
String studentId = request.getParameter("student_id");

if(studentId != null && !studentId.trim().isEmpty()) {

    try {
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/college_erp",
            "root",
            System.getenv("DB_PASSWORD")
        );

        int sid = Integer.parseInt(studentId);

        PreparedStatement studentPs = con.prepareStatement(
            "SELECT name, roll_no FROM students WHERE id=?"
        );

        studentPs.setInt(1, sid);

        ResultSet studentRs = studentPs.executeQuery();

        if(studentRs.next()) {

            out.println("<h4>Student: " + studentRs.getString("name") + "</h4>");
            out.println("<p>Roll No: " + studentRs.getString("roll_no") + "</p>");

            studentRs.close();
            studentPs.close();

            PreparedStatement countPs = con.prepareStatement(
                "SELECT COUNT(*) AS total, " +
                "COALESCE(SUM(CASE WHEN status='Present' THEN 1 ELSE 0 END),0) AS present_count, " +
                "COALESCE(SUM(CASE WHEN status='Absent' THEN 1 ELSE 0 END),0) AS absent_count " +
                "FROM attendance WHERE student_id=?"
            );

            countPs.setInt(1, sid);
            ResultSet countRs = countPs.executeQuery();

            if(countRs.next()) {
%>

<div class="alert alert-info">
    Total Attendance: <%= countRs.getInt("total") %><br>
    Present: <%= countRs.getInt("present_count") %><br>
    Absent: <%= countRs.getInt("absent_count") %>
</div>

<%
            }

            countRs.close();
            countPs.close();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM attendance WHERE student_id=? ORDER BY attendance_date DESC"
            );

            ps.setInt(1, sid);

            ResultSet rs = ps.executeQuery();
%>

<table class="table table-bordered table-striped">

<tr>
    <th>ID</th>
    <th>Date</th>
    <th>Status</th>
    <th>Remarks</th>
</tr>

<%
            boolean found = false;

            while(rs.next()) {
                found = true;
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getDate("attendance_date") %></td>
    <td><%= rs.getString("status") %></td>
    <td><%= rs.getString("remarks") %></td>
</tr>

<%
            }

            if(!found) {
                out.println("<tr><td colspan='4'>No attendance records found.</td></tr>");
            }

            rs.close();
            ps.close();

        } else {
            out.println("<div class='alert alert-danger'>Student not found!</div>");
            studentRs.close();
            studentPs.close();
        }

        con.close();

    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>

</body>
</html>