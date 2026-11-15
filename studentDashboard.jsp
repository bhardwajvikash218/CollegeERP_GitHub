<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("studentId") == null) {
    response.sendRedirect("studentLogin.jsp");
    return;
}

int studentId = (Integer) session.getAttribute("studentId");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
    <div class="container">
        <span class="navbar-brand">College ERP - Student Panel</span>

        <a href="studentLogout.jsp" class="btn btn-danger btn-sm">
            Logout
        </a>
    </div>
</nav>

<div class="container mt-4">

    <div class="card shadow mb-4">
        <div class="card-body">

<%
try {

    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    ps = con.prepareStatement(
        "SELECT name, roll_no, email, course, semester " +
        "FROM students WHERE id=?"
    );

    ps.setInt(1, studentId);

    rs = ps.executeQuery();

    if(rs.next()) {
%>

           <h2>Welcome, <%= rs.getString("name") %>!</h2>
           <p class="text-muted">Welcome to College ERP Student Portal.</p>
            <hr>

            <h5>My Profile</h5>

            <p><b>Roll Number:</b> <%= rs.getString("roll_no") %></p>

            <p><b>Email:</b> <%= rs.getString("email") %></p>

            <p><b>Course:</b> <%= rs.getString("course") %></p>

            <p><b>Semester:</b> <%= rs.getInt("semester") %></p>

<%
    } else {
        out.println("Student Profile Not Found!");
    }

} catch(Exception e) {
    out.println("Database Error: " + e.getMessage());
} finally {
    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>

        </div>
    </div>

    <h4 class="mb-3">Student Services</h4>

    <div class="row">

        <div class="col-md-4 mb-3">
            <div class="card shadow h-100">
                <div class="card-body">
                    <h5>My Attendance</h5>
                    <p>View your attendance details.</p>
                    <a href="myAttendance.jsp"class="btn btn-primary">View My Attendance</a>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="card shadow h-100">
                <div class="card-body">
                    <h5>My Fees</h5>
                    <p>Check your fee details.</p>
                    <a href="myFees.jsp"class="btn btn-primary">View My Fees</a>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="card shadow h-100">
                <div class="card-body">
                    <h5>My Results</h5>
                    <p>View your examination results.</p>
                    <a href="myResult.jsp"class="btn btn-primary">View My Result</a>
                    <button onclick="window.print()"class="btn btn-success mb-4 no-print">Print My Result</button>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow p-3 mb-3">
                <h5>My Profile</h5>
                <p>View your personal and academic details.</p>
                <a href="myProfile.jsp" class="btn btn-primary">View My Profile</a>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card shadow h-100">
                <div class="card-body text-center">
                    <h5 class="card-title">Change Password</h5>
                    <p class="card-text">Update your account password.</p>
                    <a href="changeStudentPassword.jsp" class="btn btn-warning">Change Password</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>