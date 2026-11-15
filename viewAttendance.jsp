<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Attendance</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Student Attendance Record</h2>

<table class="table table-bordered table-striped mt-4">
<tr>
    <th>ID</th>
    <th>Student ID</th>
    <th>Date</th>
    <th>Status</th>
    <th>Remarks</th>
    <th>Action</th>
</tr>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery("SELECT * FROM attendance");

    while(rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getInt("Student_id") %></td>
    <td><%= rs.getDate("attendance_date") %></td>
    <td><%= rs.getString("status") %></td>
    <td><%= rs.getString("remarks") %></td>
    <td>
    <a href="editAttendance.jsp?id=<%= rs.getInt("id") %>"
    class="btn btn-primary btn-sm">Edit</a>
     <a href="deleteAttendance.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this Attendance?');">Delete</a>
</td>
</tr>

<%
    }
    rs.close();
    st.close();
    con.close();

} catch(Exception e) {
    out.println(e);
}
%>

</table>

<a href="markAttendance.jsp" class="btn btn-primary">
Mark Attendance
</a>

</body>
</html>