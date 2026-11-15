<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Students - College ERP</title>

    <meta charset="UTF-8">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="mb-4">College ERP - Student Records</h2>

    <a href="addStudent.jsp" class="btn btn-success mb-3">
        + Add Student
    </a>

    <div class="table-responsive">
        <table class="table table-bordered table-striped bg-white">

            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Roll Number</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Semester<th>
                        <th>Action</th>
                </tr>
            </thead>

            <tbody>

            <%
            String url = "jdbc:mysql://localhost:3306/college_erp";
            String dbUser = "root";
            String dbPassword = "vikas123";

            String sql = "SELECT id, roll_no, name, email, course, semester "
                       + "FROM students ORDER BY id DESC";

            try {
                Class.forName("com.mysql.jdbc.Driver");

                try (Connection con = DriverManager.getConnection(
                            url, dbUser, dbPassword);
                     PreparedStatement ps = con.prepareStatement(sql);
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) {
            %>

                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("roll_no") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("course") %></td>
                    <td><%= rs.getInt("semester") %></td>
                    <td>
    <a href="editStudent.jsp?id=<%= rs.getInt("id") %>"
       class="btn btn-warning btn-sm">
        Edit
    </a>

    <form action="deleteStudent.jsp"
          method="post"
          style="display:inline;"
          onsubmit="return confirm('Are you sure you want to delete this student?');">

        <input type="hidden"
               name="id"
               value="<%= rs.getInt("id") %>">

        <button type="submit" class="btn btn-danger btn-sm">
            Delete
        </button>

    </form>
</td>
                </tr>
            <%
                    }
                }

            } catch (Exception e) {
                application.log("Student list failed", e);
                out.println("<tr><td colspan='6'>"
                    + "Could not load student records. "
                    + "Check the Tomcat log.</td></tr>");
            }
            %>

            </tbody>

        </table>
    </div>

</div>

</body>
</html>