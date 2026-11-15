<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Student Result</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
          <style>
            @media print {
                .no-print {
                    display: none !important
                }
            }
          </style>
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
            <h3>Search Student Result</h3>
        </div>

        <div class="card-body">

            <form method="get" action="searchStudentResult.jsp"
                class="no-print">

                <div class="mb-3">
                    <label class="form-label">Enter Student Roll Number</label>

                    <input type="text"
                           name="roll_no"
                           class="form-control"
                           placeholder="Enter Roll Number"
                           value="<%= request.getParameter("roll_no") == null ? "" : request.getParameter("roll_no") %>"
                           required>
                </div>

                <button type="submit" class="btn btn-primary">
                    Search Result
                </button>

                <a href="adminDashboard.jsp"
                   class="btn btn-secondary">
                    Dashboard
                </a>

            </form>

            <hr>

<%
String rollNo = request.getParameter("roll_no");

if(rollNo != null && !rollNo.trim().isEmpty()) {

    try {

        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/college_erp",
            "root",
            System.getenv("DB_PASSWORD")
        );

        String sql =
            "SELECT s.name, s.roll_no, e.exam_name, " +
            "e.total_marks, sm.marks_obtained " +
            "FROM student_marks sm " +
            "JOIN students s ON sm.student_id = s.id " +
            "JOIN exams e ON sm.exam_id = e.id " +
            "WHERE s.roll_no = ?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, rollNo.trim());

        ResultSet rs = ps.executeQuery();

        boolean found = false;

        while(rs.next()) {

            found = true;

            double total = rs.getDouble("total_marks");
            double obtained = rs.getDouble("marks_obtained");

            double percentage = (obtained / total) * 100;

            String result = percentage >= 33 ? "Pass" : "Fail";
%>

            <h5 class="mt-3">Student Result</h5>
            <button onclick="window.print()"
            type="button" class="btn btn-success no-print mb-3">Print Result</button>

            <table class="table table-bordered">

                <tr>
                    <th>Student Name</th>
                    <td><%= rs.getString("name") %></td>
                </tr>

                <tr>
                    <th>Roll Number</th>
                    <td><%= rs.getString("roll_no") %></td>
                </tr>

                <tr>
                    <th>Exam Name</th>
                    <td><%= rs.getString("exam_name") %></td>
                </tr>

                <tr>
                    <th>Total Marks</th>
                    <td><%= total %></td>
                </tr>

                <tr>
                    <th>Obtained Marks</th>
                    <td><%= obtained %></td>
                </tr>

                <tr>
                    <th>Percentage</th>
                    <td><%= String.format("%.2f", percentage) %>%</td>
                </tr>

                <tr>
                    <th>Result</th>
                    <td>
                        <% if(result.equals("Pass")) { %>
                            <span class="badge bg-success">Pass</span>
                        <% } else { %>
                            <span class="badge bg-danger">Fail</span>
                        <% } %>
                    </td>
                </tr>

            </table>

            <hr>

<%
        }

        if(!found) {
            out.println("<div class='alert alert-warning'>No Result Found for this Roll Number!</div>");
        }

        rs.close();
        ps.close();
        con.close();

    } catch(Exception e) {
        out.println("<div class='alert alert-danger'>Database Error: "
                    + e.getMessage() + "</div>");
    }
}
%>

        </div>
    </div>

</div>

</body>
</html>