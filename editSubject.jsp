<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Subject</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Edit Subject</h2>

<%
int id = Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM subjects WHERE id=?"
);

ps.setInt(1, id);

ResultSet rs = ps.executeQuery();

if(rs.next()) {
%>
<form action="updateSubject.jsp" method="post">

<input type="hidden" name="id" value="<%= rs.getInt("id") %>">

<div class="mb-3">
    <label>Subject Name</label>
    <input type="text" name="subject_name"
    class="form-control"
    value="<%= rs.getString("subject_name") %>" required>
</div>

<div class="mb-3">
    <label>Subject Code</label>
    <input type="text" name="subject_code"
    class="form-control"
    value="<%= rs.getString("subject_code") %>" required>
</div>

<div class="mb-3">
    <label>Semester</label>
    <input type="number" name="semester"
    class="form-control"
    value="<%= rs.getInt("semester") %>" min="1" max="8" required>
</div>

<div class="mb-3">
    <label>Description</label>
    <textarea name="description" class="form-control"><%= rs.getString("description") == null ? "" : rs.getString("description") %></textarea>
</div>

<button type="submit" class="btn btn-success">
Update Subject
</button>

</form>

<%
}

con.close();
%>

</body>
</html>