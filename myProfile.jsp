<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
Integer studentId = (Integer) session.getAttribute("studentId");

if (studentId == null) {
    response.sendRedirect("studentLogin.jsp");
    return;
}

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <h2>My Profile</h2>

    <a href="studentDashboard.jsp"
       class="btn btn-secondary mb-3">
       Back to Dashboard
    </a>

    <%
    try {
        Class.forName("com.mysql.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/college_erp?useUnicode=true&characterEncoding=UTF-8",
            "root",
            System.getenv("DB_PASSWORD")
        );

        String sql = "SELECT name, roll_no, email, course, semester FROM students WHERE id=?";

        ps = con.prepareStatement(sql);
        ps.setInt(1, studentId);
        rs = ps.executeQuery();

        if (rs.next()) {
    %>

    <div class="card shadow p-4">
        <h4>Student Information</h4>

        <p><b>Name:</b> <%= rs.getString("name") %></p>
        <p><b>Roll Number:</b> <%= rs.getString("roll_no") %></p>
        <p><b>Email:</b> <%= rs.getString("email") %></p>
        <p><b>Course:</b> <%= rs.getString("course") %></p>
        <p><b>Semester:</b> <%= rs.getString("semester") %></p>
    </div>

    <%
        } else {
            out.println("Student record not found.");
        }

    } catch (Exception e) {
        out.println("Unable to load profile.");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
    %>

</div>
</body>
</html>