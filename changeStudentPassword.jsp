<%@ page import="java.sql.*" %>

<%
    Integer studentId = (Integer) session.getAttribute("studentId");

    if (studentId == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow mx-auto" style="max-width: 500px;">

        <div class="card-header bg-primary text-white">
            <h4>Change Password</h4>
        </div>

        <div class="card-body">

            <form action="updateStudentPassword.jsp" method="post">

                <div class="mb-3">
                    <label>Current Password</label>
                    <input type="password"
                           name="currentPassword"
                           class="form-control"
                           required>
                </div>

                <div class="mb-3">
                    <label>New Password</label>
                    <input type="password"
                           name="newPassword"
                           class="form-control"
                           minlength="8"
                           required>
                </div>

                <div class="mb-3">
                    <label>Confirm New Password</label>
                    <input type="password"
                           name="confirmPassword"
                           class="form-control"
                           minlength="8"
                           required>
                </div>

                <button type="submit" class="btn btn-primary">
                    Update Password
                </button>

                <a href="studentDashboard.jsp"
                   class="btn btn-secondary">
                    Back
                </a>

            </form>

        </div>
    </div>

</div>

</body>
</html>