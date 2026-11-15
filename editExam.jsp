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

    ps = con.prepareStatement("SELECT * FROM exams WHERE id=?");
    ps.setInt(1, id);

    rs = ps.executeQuery();

    if(rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4">

        <h2 class="mb-4">Edit Exam</h2>

        <form action="updateExam.jsp" method="post">

            <input type="hidden" name="id" value="<%= id %>">

            <label>Exam Name</label>
            <input type="text" name="exam_name"
                   class="form-control mb-3"
                   value="<%= rs.getString("exam_name") %>" required>

            <label>Exam Type</label>
            <select name="exam_type" class="form-control mb-3" required>
                <option value="Internal" <%= "Internal".equals(rs.getString("exam_type")) ? "selected" : "" %>>Internal</option>
                <option value="Mid-Term" <%= "Mid-Term".equals(rs.getString("exam_type")) ? "selected" : "" %>>Mid-Term</option>
                <option value="Final" <%= "Final".equals(rs.getString("exam_type")) ? "selected" : "" %>>Final</option>
            </select>

            <label>Subject ID</label>
            <input type="number" name="subject_id"
                   class="form-control mb-3"
                   value="<%= rs.getInt("subject_id") %>" required>

            <label>Semester</label>
            <input type="number" name="semester"
                   class="form-control mb-3"
                   value="<%= rs.getInt("semester") %>" min="1" required>

            <label>Exam Date</label>
            <input type="date" name="exam_date"
                   class="form-control mb-3"
                   value="<%= rs.getDate("exam_date") %>" required>

            <label>Total Marks</label>
            <input type="number" name="total_marks"
                   class="form-control mb-3"
                   value="<%= rs.getInt("total_marks") %>" min="1" required>

            <label>Description</label>
            <textarea name="description"
                      class="form-control mb-3"><%= rs.getString("description") == null ? "" : rs.getString("description") %></textarea>

            <button type="submit" class="btn btn-primary">Update Exam</button>

            <a href="viewExams.jsp" class="btn btn-secondary">Cancel</a>

        </form>

    </div>
</div>

</body>
</html>

<%
    } else {
        out.println("Exam record not found!");
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>