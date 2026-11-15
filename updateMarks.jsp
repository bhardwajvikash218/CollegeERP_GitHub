<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
double marks = Double.parseDouble(
    request.getParameter("marks_obtained")
);
String remarks = request.getParameter("remarks");

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_erp",
    "root",
    System.getenv("DB_PASSWORD")
);

// Exam ke total marks check karo
PreparedStatement check = con.prepareStatement(
    "SELECT e.total_marks FROM student_marks sm " +
    "JOIN exams e ON sm.exam_id = e.id WHERE sm.id = ?"
);

check.setInt(1, id);
ResultSet rs = check.executeQuery();

if(rs.next()) {

    double totalMarks = rs.getDouble("total_marks");

    if(marks < 0 || marks > totalMarks) {
        out.println("Invalid Marks! Please enter valid marks.");
    } else {

        PreparedStatement ps = con.prepareStatement(
            "UPDATE student_marks SET marks_obtained=?, remarks=? WHERE id=?"
        );

        ps.setDouble(1, marks);
        ps.setString(2, remarks);
        ps.setInt(3, id);

        ps.executeUpdate();

        ps.close();

        response.sendRedirect("viewMarks.jsp");
    }

} else {
    out.println("Student Marks Record Not Found!");
}

rs.close();
check.close();
con.close();
%>