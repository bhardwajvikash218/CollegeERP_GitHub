<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Subjects</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>

<body class="container mt-5">

<h2>All Subjects</h2>

<table class="table table-bordered table-striped mt-4">
<tr>
    <th>ID</th>
    <th>Subject Name</th>
    <th>Subject Code</th>
    <th>Semester</th>
    <th>Description</th>
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

    ResultSet rs = st.executeQuery("SELECT * FROM subjects");

    while(rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("subject_name") %></td>
    <td><%= rs.getString("subject_code") %></td>
    <td><%= rs.getInt("semester") %></td>
    <td><%= rs.getString("description") %></td>
<td>
    <a href="editSubject.jsp?id=<%= rs.getInt("id") %>"
    class="btn btn-primary btn-sm">Edit</a>
    <a href="deleteSubject.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</a>
</tr>

<%
    }

    con.close();

} catch(Exception e) {
    out.println(e);
}
%>

</table>

<a href="adminDashboard.jsp" class="btn btn-secondary">
Back to Dashboard
</a>

</body>
</html>