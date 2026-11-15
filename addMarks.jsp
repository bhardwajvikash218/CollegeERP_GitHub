<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Student Marks</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4">

        <h2 class="mb-4">Add Student Marks</h2>

        <form action="saveMarks.jsp" method="post">

            <!-- Select Exam -->

            <div class="mb-3">

                <label>Select Exam</label>

                <select name="exam_id"
                        class="form-control" required>

                    <option value="">Select Exam</option>

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

    // Exam Dropdown

    ps = con.prepareStatement(
        "SELECT id, exam_name FROM exams ORDER BY id DESC"
    );

    rs = ps.executeQuery();

    while(rs.next()) {
%>

                    <option value="<%= rs.getInt("id") %>">
                        <%= rs.getString("exam_name") %>
                    </option>

<%
    }

    rs.close();
    ps.close();

%>

                </select>

            </div>


            <!-- Select Student -->

            <div class="mb-3">

                <label>Select Student</label>

                <select name="student_id"
                        class="form-control" required>

                    <option value="">Select Student</option>

<%
    ps = con.prepareStatement(
        "SELECT id, name, roll_no FROM students ORDER BY id"
    );

    rs = ps.executeQuery();

    while(rs.next()) {
%>

                    <option value="<%= rs.getInt("id") %>">

                        <%= rs.getString("name") %>
                        (<%= rs.getString("roll_no") %>)

                    </option>

<%
    }

    rs.close();
    ps.close();

%>

                </select>

            </div>


            <!-- Marks Obtained -->

            <div class="mb-3">

                <label>Marks Obtained</label>

                <input type="number"
                       name="marks_obtained"
                       class="form-control"
                       min="0"
                       step="0.01"
                       required>

            </div>


            <!-- Remarks -->

            <div class="mb-3">

                <label>Remarks</label>

                <textarea name="remarks"
                          class="form-control"
                          rows="3"></textarea>

            </div>


            <!-- Buttons -->

            <button type="submit"
                    class="btn btn-primary">
                Save Marks
            </button>

            <a href="adminDashboard.jsp"
               class="btn btn-secondary">
                Back
            </a>

        </form>

<%

} catch(Exception e) {

    out.println("Database Error: " + e.getMessage());

} finally {

    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();

}
%>

    </div>

</div>

</body>
</html>