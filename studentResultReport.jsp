<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Result Report</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="mb-4">Student Result Report</h2>

    <a href="adminDashboard.jsp" class="btn btn-secondary mb-3">
        Dashboard
    </a>

    <div class="card shadow">
        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-bordered table-striped">

                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Student Name</th>
                            <th>Roll Number</th>
                            <th>Exam Name</th>
                            <th>Total Marks</th>
                            <th>Obtained Marks</th>
                            <th>Percentage</th>
                            <th>Result</th>
                        </tr>
                    </thead>

                    <tbody>

<%
try {

    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    String sql =
        "SELECT sm.id, s.name, s.roll_no, e.exam_name, " +
        "e.total_marks, sm.marks_obtained " +
        "FROM student_marks sm " +
        "JOIN students s ON sm.student_id = s.id " +
        "JOIN exams e ON sm.exam_id = e.id " +
        "ORDER BY s.name";

    PreparedStatement ps = con.prepareStatement(sql);

    ResultSet rs = ps.executeQuery();

    while(rs.next()) {

        double total = rs.getDouble("total_marks");
        double obtained = rs.getDouble("marks_obtained");

        double percentage = (obtained / total) * 100;

        String result = percentage >= 33 ? "Pass" : "Fail";
%>

                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("roll_no") %></td>
                            <td><%= rs.getString("exam_name") %></td>
                            <td><%= total %></td>
                            <td><%= obtained %></td>
                            <td><%= String.format("%.2f", percentage) %>%</td>
                            <td>
                                <% if(result.equals("Pass")) { %>
                                    <span class="badge bg-success">Pass</span>
                                <% } else { %>
                                    <span class="badge bg-danger">Fail</span>
                                <% } %>
                            </td>
                        </tr>

<%
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e) {
    out.println("<tr><td colspan='8'>Database Error: "
                + e.getMessage() + "</td></tr>");
}
%>

                    </tbody>
                </table>

            </div>
        </div>
    </div>

</div>

</body>
</html>