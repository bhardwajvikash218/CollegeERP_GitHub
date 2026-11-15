<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM attendance WHERE id=?"
);

ps.setInt(1, id);

ResultSet rs = ps.executeQuery();

if(rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Edit Attendance</h2>

<form action="updateAttendance.jsp" method="post">

    <input type="hidden" name="id"
           value="<%= rs.getInt("id") %>">

    <div class="mb-3">
        <label>Student ID</label>
        <input type="number" name="student_id"
               class="form-control"
               value="<%= rs.getInt("student_id") %>" required>
    </div>

    <div class="mb-3">
        <label>Attendance Date</label>
        <input type="date" name="attendance_date"
               class="form-control"
               value="<%= rs.getDate("attendance_date") %>" required>
    </div>

    <div class="mb-3">
        <label>Status</label>
        <select name="status" class="form-control" required>
            <option value="Present" <%= "Present".equals(rs.getString("status")) ? "selected" : "" %>>Present</option>
            <option value="Absent" <%= "Absent".equals(rs.getString("status")) ? "selected" : "" %>>Absent</option>
            <option value="Leave" <%= "Leave".equals(rs.getString("status")) ? "selected" : "" %>>Leave</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Remarks</label>
        <input type="text" name="remarks"
               class="form-control"
               value="<%= rs.getString("remarks") == null ? "" : rs.getString("remarks") %>">
    </div>

    <button type="submit" class="btn btn-success">
        Update Attendance
    </button>

</form>

</body>
</html>

<%
}

rs.close();
ps.close();
con.close();
%>