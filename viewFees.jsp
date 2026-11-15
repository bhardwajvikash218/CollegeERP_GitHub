<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Student Fees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Student Fees Records</h2>

<table class="table table-bordered table-striped mt-4">

<tr>
    <th>ID</th>
    <th>Student Name</th>
    <th>Roll No</th>
    <th>Total Fees</th>
    <th>Paid Amount</th>
    <th>Due Amount</th>
    <th>Status</th>
    <th>Payment Date</th>
    <th>Remarks</th>
    <th>Action</th>
</tr>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    String sql = "SELECT f.*, s.name, s.roll_no " +
                 "FROM fees f JOIN students s " +
                 "ON f.student_id = s.id";

    PreparedStatement ps = con.prepareStatement(sql);

    ResultSet rs = ps.executeQuery();

    while(rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("roll_no") %></td>
    <td><%= rs.getDouble("total_fee") %></td>
    <td><%= rs.getDouble("paid_amount") %></td>
    <td><%= rs.getDouble("due_amount") %></td>
    <td><%= rs.getString("status") %></td>
    <td><%= rs.getDate("last_payment_date") %></td>
    <td><%= rs.getString("remarks") %></td>
    <td>
        <a href="editFees.jsp?id=<%=rs.getInt("id") %>"
            class="btn btn-primary btn-sm">Edit</a>
             <a href="deleteFees.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this fees record?');">Delete</a>
    </td>
</tr>

<%
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e) {
    out.println("Database Error: " + e.getMessage());
}
%>

</table>

<a href="addFees.jsp" class="btn btn-primary">
    Add New Fees
</a>

</body>
</html>