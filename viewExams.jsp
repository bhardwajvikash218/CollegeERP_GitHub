<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Exams</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="mb-4">All Exams</h2>

    <table class="table table-bordered table-striped">

        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Exam Name</th>
                <th>Exam Type</th>
                <th>Subject ID</th>
                <th>Semester</th>
                <th>Exam Date</th>
                <th>Total Marks</th>
                <th>Description</th>
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

    String sql = "SELECT * FROM exams ORDER BY id DESC";

    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();

    while(rs.next()) {
%>

            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("exam_name") %></td>
                <td><%= rs.getString("exam_type") %></td>
                <td><%= rs.getInt("subject_id") %></td>
                <td><%= rs.getInt("semester") %></td>
                <td><%= rs.getDate("exam_date") %></td>
                <td><%= rs.getInt("total_marks") %></td>
                <td><%= rs.getString("description") %></td>
                <td>
                    <a href="editExam.jsp?id=<%= rs.getInt("id") %>"
                        class="btn btn-warning btn-sm">Edit</a><br>
                        <a href="deleteExam.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this Exam?');">Delete</a>
                    </td>
            </tr>
<%
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>

    </tbody>
    </table>

    <a href="addExam.jsp" class="btn btn-primary">Add New Exam</a>

    <a href="adminDashboard.jsp" class="btn btn-secondary">Dashboard</a>

</div>

</body>
</html>