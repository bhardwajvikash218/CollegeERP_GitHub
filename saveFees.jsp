<%@ page import="java.sql.*" %>

<%
int studentId = Integer.parseInt(request.getParameter("student_id"));

double totalFee = Double.parseDouble(request.getParameter("total_fee"));
double paidAmount = Double.parseDouble(request.getParameter("paid_amount"));

String paymentDate = request.getParameter("last_payment_date");
String remarks = request.getParameter("remarks");

double dueAmount = totalFee - paidAmount;

String status;

if(paidAmount == totalFee) {
    status = "Paid";
} else if(paidAmount > 0) {
    status = "Partial";
} else {
    status = "Pending";
}

if(totalFee <= 0 || paidAmount < 0 || paidAmount > totalFee) {
    out.println("Invalid fees amount!");
} else {

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/college_erp",
            "root",
            System.getenv("DB_PASSWORD")
        );

        PreparedStatement check = con.prepareStatement(
            "SELECT id FROM students WHERE id=?"
        );

        check.setInt(1, studentId);
        ResultSet rs = check.executeQuery();

        if(!rs.next()) {
            out.println("Student ID not found!");
        } else {

            String sql = "INSERT INTO fees (student_id, total_fee, paid_amount, due_amount, status, last_payment_date, remarks) VALUES (?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);

            ps.setInt(1, studentId);
            ps.setDouble(2, totalFee);
            ps.setDouble(3, paidAmount);
            ps.setDouble(4, dueAmount);
            ps.setString(5, status);

            if(paymentDate == null || paymentDate.isEmpty()) {
                ps.setNull(6, Types.DATE);
            } else {
                ps.setDate(6, Date.valueOf(paymentDate));
            }

            ps.setString(7, remarks);

            ps.executeUpdate();

            out.println("<h3>Fees Saved Successfully!</h3>");
            out.println("<a href='addFees.jsp'>Add Another Fees</a>");
        }

        rs.close();
        check.close();

    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
}
%>