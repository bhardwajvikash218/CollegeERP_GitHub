<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    <title>My Fees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <h2>My Fees Details</h2>

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

        String sql = "SELECT total_fee, paid_amount, due_amount, status, last_payment_date, remarks FROM fees WHERE student_id=?";

        ps = con.prepareStatement(sql);
        ps.setInt(1, studentId);
        rs = ps.executeQuery();

        if (rs.next()) {
    %>

    <div class="card shadow p-4">
        <h4 class="mb-3">Fee Summary</h4>

        <table class="table table-bordered">
            <tr>
                <th>Total Fees</th>
                <td>₹<%= rs.getBigDecimal("total_fee") %></td>
            </tr>

            <tr>
                <th>Paid Amount</th>
                <td class="text-success">
                    ₹<%= rs.getBigDecimal("paid_amount") %>
                </td>
            </tr>

            <tr>
                <th>Due Amount</th>
                <td class="text-danger">
                    ₹<%= rs.getBigDecimal("due_amount") %>
                </td>
            </tr>

            <tr>
                <th>Status</th>
                <td><%= rs.getString("status") %></td>
            </tr>

            <tr>
                <th>Last Payment Date</th>
                <td><%= rs.getDate("last_payment_date") %></td>
            </tr>

            <tr>
                <th>Remarks</th>
                <td><%= rs.getString("remarks") %></td>
            </tr>
        </table>
    </div>

    <%
        } else {
    %>
        <div class="alert alert-info">
            No fee record found for your account.
        </div>
    <%
        }

    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Unable to load fee details.</div>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
    %>

</div>

</body>
</html>