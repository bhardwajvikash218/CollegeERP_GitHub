<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
int studentId = Integer.parseInt(request.getParameter("student_id"));

double totalFee = Double.parseDouble(request.getParameter("total_fee"));
double paidAmount = Double.parseDouble(request.getParameter("paid_amount"));

String paymentDate = request.getParameter("last_payment_date");
String remarks = request.getParameter("remarks");

if(totalFee <= 0 || paidAmount < 0 || paidAmount > totalFee) {
    out.println("Invalid fees amount!");
} else {

    double dueAmount = totalFee - paidAmount;

    String status;

    if(paidAmount == totalFee) {
        status = "Paid";
    } else if(paidAmount > 0) {
        status = "Partial";
    } else {
        status = "Pending";
    }

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/college_erp",
            "root",
            System.getenv("DB_PASSWORD")
        );

        String sql = "UPDATE fees SET student_id=?, total_fee=?, paid_amount=?, due_amount=?, status=?, last_payment_date=?, remarks=? WHERE id=?";

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
        ps.setInt(8, id);

        int result = ps.executeUpdate();

        if(result > 0) {
            response.sendRedirect("viewFees.jsp");
        } else {
            out.println("Fees record not found!");
        }

    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
}
%>