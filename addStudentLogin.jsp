<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Student Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
            <h3>Create Student Login Account</h3>
        </div>

        <div class="card-body">

            <form action="saveStudentLogin.jsp" method="post">

                <div class="mb-3">
                    <label class="form-label">Select Student</label>

                    <select name="student_id" class="form-select" required>

                        <option value="">Select Student</option>

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

    ps = con.prepareStatement(
        "SELECT id, name, roll_no FROM students ORDER BY name"
    );

    rs = ps.executeQuery();

    while(rs.next()) {
%>

                        <option value="<%= rs.getInt("id") %>">
                            <%= rs.getString("name") %>
                            - <%= rs.getString("roll_no") %>
                        </option>

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

                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Username</label>

                    <input type="text"
                           name="username"
                           class="form-control"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>

                    <input type="password"
                           name="password"
                           class="form-control"
                           minlength="8"
                           required>
                </div>

                <button type="submit" class="btn btn-success">
                    Create Account
                </button>

                <a href="adminDashboard.jsp"
                   class="btn btn-secondary">
                    Dashboard
                </a>

            </form>

        </div>
    </div>

</div>

</body>
</html>