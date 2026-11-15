<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

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
        "SELECT * FROM fees WHERE id=?"
    );

    ps.setInt(1, id);
    rs = ps.executeQuery();

    if(rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Student Fees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Edit Student Fees</h2>

<form action="updateFees.jsp" method="post">

    <input type="hidden" name="id"
           value="<%= rs.getInt("id") %>">

    <div class="mb-3">
        <label>Student ID</label>
        <input type="number" name="student_id"
               class="form-control"
               value="<%= rs.getInt("student_id") %>" required>
    </div>

    <div class="mb-3">
        <label>Total Fees</label>
        <input type="number" name="total_fee"
               class="form-control" step="0.01"
               value="<%= rs.getDouble("total_fee") %>" required>
    </div>

    <div class="mb-3">
        <label>Paid Amount</label>
        <input type="number" name="paid_amount"
               class="form-control" step="0.01"
               value="<%= rs.getDouble("paid_amount") %>" required>
    </div>

    <div class="mb-3">
        <label>Last Payment Date</label>
        <input type="date" name="last_payment_date"
               class="form-control"
               value="<%= rs.getDate("last_payment_date") == null ? "" : rs.getDate("last_payment_date") %>">
    </div>

    <div class="mb-3">
        <label>Remarks</label>
        <input type="text" name="remarks"
               class="form-control"
               value="<%= rs.getString("remarks") == null ? "" : rs.getString("remarks") %>">
    </div>

    <button type="submit" class="btn btn-success">
        Update Fees
    </button>

</form>

</body>
</html>

<%
    } else {
        out.println("Fees record not found!");
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>