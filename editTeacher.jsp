<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>
            Edit Teacher</title>

            <link href="https//cdn.jsdeliver.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="container mt-5">
        <h2>Edit Teacher</h2>
        <%
int id = Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM teachers WHERE id=?"
);

ps.setInt(1, id);

ResultSet rs = ps.executeQuery();

if(rs.next()) {
%>
<form action="updateTeacher.jsp" method="post">

<input type="hidden" name="id" value="<%= rs.getInt("id") %>">

<div class="mb-3">
    <label>Teacher Name</label>
    <input type="text" name="teacher_name"
    class="form-control"
    value="<%= rs.getString("teacher_name") %>">
</div>

<div class="mb-3">
    <label>Email</label>
    <input type="email" name="email"
    class="form-control"
    value="<%= rs.getString("email") %>">
</div>

<div class="mb-3">
    <label>Subject</label>
    <input type="text" name="subject"
    class="form-control"
    value="<%= rs.getString("subject") %>">
</div>

<div class="mb-3">
    <label>Phone</label>
    <input type="text" name="phone"
    class="form-control"
    value="<%= rs.getString("phone") %>">
</div>

<button type="submit" class="btn btn-success">
Update Teacher
</button>

</form>

<%
}
else {
    out.println("Teacher Not Found");
}

con.close();
%>

</body>
</html>