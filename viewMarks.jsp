<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Student Marks</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="mb-4">Student Marks Records</h2>

    <table class="table table-bordered table-striped">

        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Student Name</th>
                <th>Roll No</th>
                <th>Exam Name</th>
                <th>Total Marks</th>
                <th>Obtained Marks</th>
                <th>Remarks</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>

<%
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

    String sql =
        "SELECT sm.id, s.name, s.roll_no, e.exam_name, " +
        "e.total_marks, sm.marks_obtained, sm.remarks " +
        "FROM student_marks sm " +
        "JOIN students s ON sm.student_id = s.id " +
        "JOIN exams e ON sm.exam_id = e.id " +
        "ORDER BY sm.id DESC";

    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()) {
        found = true;
%>

            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("roll_no") %></td>
                <td><%= rs.getString("exam_name") %></td>
                <td><%= rs.getInt("total_marks") %></td>
                <td><%= rs.getDouble("marks_obtained") %></td>
                <td><%= rs.getString("remarks") %></td>
                <td>
                    <a href="editMarks.jsp?id=<%= rs.getInt("id") %>"
                        class="btn btn-warning btn-sm">Edit</a><br>
                        <a href="deleteMarks.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this Marks?');">Delete</a>
                </td>
            </tr>

<%
    }

    if(!found) {
%>
            <tr>
                <td colspan="7" class="text-center">
                    No Marks Records Found
                </td>
            </tr>
<%
    }

} catch(Exception e) {

    out.println("Database Error: " + e.getMessage());

} finally {

    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();

}
%>

        </tbody>

    </table>

    <a href="addMarks.jsp" class="btn btn-primary">
        Add Marks
    </a>

    <a href="adminDashboard.jsp" class="btn btn-secondary">
        Dashboard
    </a>

</div>

</body>
</html>