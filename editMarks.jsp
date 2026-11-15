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
    "SELECT sm.*, s.name, s.roll_no, e.exam_name, e.total_marks " +
    "FROM student_marks sm " +
    "JOIN students s ON sm.student_id = s.id " +
    "JOIN exams e ON sm.exam_id = e.id " +
    "WHERE sm.id = ?"
);

ps.setInt(1, id);

ResultSet rs = ps.executeQuery();

if(rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Student Marks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
            <h3>Edit Student Marks</h3>
        </div>

        <div class="card-body">

            <form action="updateMarks.jsp" method="post">

                <input type="hidden" name="id"
                       value="<%= rs.getInt("id") %>">

                <div class="mb-3">
                    <label class="form-label">Student Name</label>
                    <input type="text" class="form-control"
                           value="<%= rs.getString("name") %>"
                           readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Roll Number</label>
                    <input type="text" class="form-control"
                           value="<%= rs.getString("roll_no") %>"
                           readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Exam Name</label>
                    <input type="text" class="form-control"
                           value="<%= rs.getString("exam_name") %>"
                           readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Total Marks</label>
                    <input type="number" class="form-control"
                           value="<%= rs.getDouble("total_marks") %>"
                           readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Marks Obtained</label>
                    <input type="number"
                           name="marks_obtained"
                           class="form-control"
                           min="0"
                           max="<%= rs.getDouble("total_marks") %>"
                           step="0.01"
                           value="<%= rs.getDouble("marks_obtained") %>"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Remarks</label>
                    <textarea name="remarks"
                              class="form-control"
                              rows="3"><%= rs.getString("remarks") == null ? "" : rs.getString("remarks") %></textarea>
                </div>

                <button type="submit" class="btn btn-success">
                    Update Marks
                </button>

                <a href="viewMarks.jsp" class="btn btn-secondary">
                    Cancel
                </a>

            </form>

        </div>
    </div>

</div>

</body>
</html>

<%
} else {
    out.println("Student Marks Record Not Found!");
}

rs.close();
ps.close();
con.close();
%>