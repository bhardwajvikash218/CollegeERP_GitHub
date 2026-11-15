<%@ page import="java.sql.*" %>

<%
String idText = request.getParameter("id");

if (idText == null) {
    response.sendRedirect("viewStudents.jsp");
    return;
}

int id = Integer.parseInt(idText);

String url = "jdbc:mysql://localhost:3306/college_erp";
String user = "root";
String password = "vikas123";

String rollNo = "";
String name = "";
String email = "";
String course = "";
int semester = 1;

try {
    Class.forName("com.mysql.jdbc.Driver");

    try (Connection con = DriverManager.getConnection(url, user, password);
         PreparedStatement ps = con.prepareStatement(
             "SELECT * FROM students WHERE id = ?")) {

        ps.setInt(1, id);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                rollNo = rs.getString("roll_no");
                name = rs.getString("name");
                email = rs.getString("email");
                course = rs.getString("course");
                semester = rs.getInt("semester");
            } else {
                out.println("Student not found.");
                return;
            }
        }
    }
} catch (Exception e) {
    application.log("Edit student error", e);
    out.println("Unable to load student details.");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Student - College ERP</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning">
            <h3>Edit Student</h3>
        </div>

        <div class="card-body">

            <form action="updateStudent.jsp" method="post">

                <input type="hidden" name="id" value="<%= id %>">

                <div class="mb-3">
                    <label class="form-label">Roll Number</label>
                    <input type="text" name="roll_no"
                           class="form-control"
                           value="<%= rollNo %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Student Name</label>
                    <input type="text" name="name"
                           class="form-control"
                           value="<%= name %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email"
                           class="form-control"
                           value="<%= email %>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Course</label>
                    <input type="text" name="course"
                           class="form-control"
                           value="<%= course %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Semester</label>
                    <input type="number" name="semester"
                           class="form-control"
                           min="1" max="8"
                           value="<%= semester %>" required>
                </div>

                <button type="submit" class="btn btn-primary">
                    Update Student
                </button>

                <a href="viewStudents.jsp" class="btn btn-secondary">
                    Cancel
                </a>

            </form>

        </div>
    </div>
</div>

</body>
</html>