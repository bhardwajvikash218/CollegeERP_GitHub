<%@ page import="java.sql.*" %>

<%
String error = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {

        String url = "jdbc:mysql://localhost:3306/college_erp";

        try {
            Class.forName("com.mysql.jdbc.Driver");

            try (
                Connection con = DriverManager.getConnection(
                    url, "root", System.getenv("DB_PASSWORD")
                );

                PreparedStatement ps = con.prepareStatement(
                    "SELECT id FROM admin_users WHERE username=? AND password=?"
                )
            ) {
                ps.setString(1, username.trim());
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        session.setAttribute("adminUser", username);
                        response.sendRedirect("adminDashboard.jsp");
                        return;
                    } else {
                        error = "Invalid username or password!";
                    }
                }
            }

        } catch (Exception e) {
            application.log("Admin login error", e);
            error = "Database connection error. Check Tomcat logs.";
        }

    } else {
        error = "Please enter username and password.";
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - College ERP</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">

            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3 class="text-center">College ERP Login</h3>
                </div>

                <div class="card-body">

                    <% if (!error.isEmpty()) { %>
                        <div class="alert alert-danger">
                            <%= error %>
                        </div>
                    <% } %>

                    <form method="post" action="login.jsp">

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
                                   required>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">
                            Login
                        </button>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>