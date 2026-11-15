<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Due Fees Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="mb-4">Due Fees Report</h2>

    <table class="table table-bordered table-striped">

        <thead class="table-dark">
            <tr>
                <th>Roll No</th>
                <th>Student Name</th>
                <th>Total Fee</th>
                <th>Paid Amount</th>
                <th>Due Amount</th>
                <th>Status</th>
            </tr>
        </thead>

        <tbody>

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

    String sql = "SELECT s.roll_no, s.name, f.total_fee, " +
                 "f.paid_amount, f.due_amount, f.status " +
                 "FROM fees f JOIN students s " +
                 "ON f.student_id = s.id " +
                 "WHERE f.due_amount > 0";

    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()) {
        found = true;
%>

            <tr>
                <td><%= rs.getString("roll_no") %></td>
                <td><%= rs.getString("name") %></td>
                <td>₹<%= rs.getInt("total_fee") %></td>
                <td>₹<%= rs.getInt("paid_amount") %></td>
                <td>₹<%= rs.getInt("due_amount") %></td>
                <td><%= rs.getString("status") %></td>
            </tr>

<%
    }

    if(!found) {
%>
            <tr>
                <td colspan="6" class="text-center">
                    No Due Fees Found
                </td>
            </tr>
<%
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>

        </tbody>
    </table>

    <a href="adminDashboard.jsp" class="btn btn-secondary">
        Back to Dashboard
    </a>

</div>

</body>
</html>