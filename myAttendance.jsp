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
    <title>My Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <h2 class="mb-4">My Attendance Report</h2>

    <a href="studentDashboard.jsp" class="btn btn-secondary mb-3">
        Back to Dashboard
    </a>

    <%
    try {
        Class.forName("com.mysql.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/college_erp",
            "root",
            System.getenv("DB_PASSWORD")
        );

        String countSql =
            "SELECT COUNT(*) AS total, " +
            "SUM(CASE WHEN status='Present' THEN 1 ELSE 0 END) AS present, " +
            "SUM(CASE WHEN status='Absent' THEN 1 ELSE 0 END) AS absent " +
            "FROM attendance WHERE student_id=?";

        ps = con.prepareStatement(countSql);
        ps.setInt(1, studentId);
        rs = ps.executeQuery();

        int total = 0;
        int present = 0;
        int absent = 0;
        double percentage = 0;

        if (rs.next()) {
            total = rs.getInt("total");
            present = rs.getInt("present");
            absent = rs.getInt("absent");
        }

        if (total > 0) {
            percentage = (present * 100.0) / total;
        }

        rs.close();
        ps.close();
    %>

    <div class="row mb-4">

        <div class="col-md-3">
            <div class="card p-3 shadow-sm">
                <h5>Total Classes</h5>
                <h3><%= total %></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 shadow-sm">
                <h5>Present</h5>
                <h3 class="text-success"><%= present %></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 shadow-sm">
                <h5>Absent</h5>
                <h3 class="text-danger"><%= absent %></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 shadow-sm">
                <h5>Attendance</h5>
                <h3><%= String.format("%.2f", percentage) %>%</h3>
            </div>
        </div>

    </div>

    <h4>Attendance Details</h4>

    <table class="table table-bordered table-striped bg-white">
        <thead class="table-dark">
            <tr>
                <th>Date</th>
                <th>Status</th>
                <th>Remarks</th>
            </tr>
        </thead>

        <tbody>
        <%
            String detailSql =
                "SELECT attendance_date, status, remarks " +
                "FROM attendance WHERE student_id=? " +
                "ORDER BY attendance_date DESC";

            ps = con.prepareStatement(detailSql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();

            boolean found = false;

            while (rs.next()) {
                found = true;
        %>
            <tr>
                <td><%= rs.getDate("attendance_date") %></td>
                <td><%= rs.getString("status") %></td>
                <td><%= rs.getString("remarks") %></td>
            </tr>
        <%
            }

            if (!found) {
        %>
            <tr>
                <td colspan="3" class="text-center">
                    No attendance records found.
                </td>
            </tr>
        <%
            }

        } catch (Exception e) {
            out.println("<tr><td colspan='3'>Unable to load attendance.</td></tr>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
        %>
        </tbody>
    </table>

</div>

</body>
</html>