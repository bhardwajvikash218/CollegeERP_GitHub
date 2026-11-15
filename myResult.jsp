<%@ page import="java.sql.*" %>

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
    <title>My Results</title>
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

<div class="container mt-4">

    <h2>My Exam Results</h2>

    <a href="studentDashboard.jsp" class="btn btn-secondary mb-3">
        Back to Dashboard
    </a>

    <table class="table table-bordered table-striped bg-white">
        <thead class="table-dark">
            <tr>
                <th>Exam Name</th>
                <th>Exam Date</th>
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

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/college_erp",
                "root",
                System.getenv("DB_PASSWORD")
            );

            String sql =
                "SELECT e.exam_name, e.exam_date, e.total_marks, " +
                "sm.marks_obtained " +
                "FROM student_marks sm " +
                "JOIN exams e ON sm.exam_id = e.id " +
                "WHERE sm.student_id = ? " +
                "ORDER BY e.exam_date DESC";

            ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();

            boolean found = false;

            while (rs.next()) {
                found = true;

                double total = rs.getDouble("total_marks");
                double obtained = rs.getDouble("marks_obtained");

                double percentage = total > 0
                    ? (obtained / total) * 100 : 0;

                String result = percentage >= 33 ? "Pass" : "Fail";
        %>

            <tr>
                <td><%= rs.getString("exam_name") %></td>
                <td><%= rs.getDate("exam_date") %></td>
                <td><%= total %></td>
                <td><%= obtained %></td>
                <td><%= String.format("%.2f", percentage) %>%</td>
                <td>
                    <%= result %>
                </td>
            </tr>

        <%
            }

            if (!found) {
        %>
            <tr>
                <td colspan="6" class="text-center">
                    No exam results found.
                </td>
            </tr>
        <%
            }

        } catch (Exception e) {
            out.println("<tr><td colspan='6'>Unable to load results.</td></tr>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
        %>
        </tbody>
    </table>

</div>

</body>
</html>