<%@ page import="java.sql.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

Connection con = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    ps = con.prepareStatement(
        "DELETE FROM fees WHERE id=?"
    );

    ps.setInt(1, id);

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
%>