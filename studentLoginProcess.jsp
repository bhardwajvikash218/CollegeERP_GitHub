<%@ page import="java.sql.*" %>
<%@ page import="javax.crypto.*" %>
<%@ page import="javax.crypto.spec.*" %>
<%@ page import="java.util.Base64" %>

<%
request.setCharacterEncoding("UTF-8");

String username = request.getParameter("username");
String password = request.getParameter("password");

if(username == null || password == null ||
   username.trim().isEmpty() || password.isEmpty()) {

    response.sendRedirect("studentLogin.jsp");
    return;
}

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

    ps = con.prepareStatement(
        "SELECT sl.student_id, sl.password_hash, s.name " +
        "FROM student_login sl " +
        "JOIN students s ON sl.student_id = s.id " +
        "WHERE sl.username = ?"
    );

    ps.setString(1, username.trim());

    rs = ps.executeQuery();

    boolean valid = false;
    int studentId = 0;
    String studentName = "";

    if(rs.next()) {

        String stored = rs.getString("password_hash");

        String[] parts = stored.split(":");

        if(parts.length == 2) {

            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] storedHash = Base64.getDecoder().decode(parts[1]);

            PBEKeySpec spec = new PBEKeySpec(
                password.toCharArray(),
                salt,
                120000,
                256
            );

            SecretKeyFactory factory =
                SecretKeyFactory.getInstance(
                    "PBKDF2WithHmacSHA256"
                );

            byte[] enteredHash =
                factory.generateSecret(spec).getEncoded();

            spec.clearPassword();

            valid = java.security.MessageDigest.isEqual(
                storedHash, enteredHash
            );

            if(valid) {
                studentId = rs.getInt("student_id");
                studentName = rs.getString("name");
            }
        }
    }

    rs.close();
    ps.close();
    con.close();

    if(valid) {

        session.setAttribute("studentId", studentId);
        session.setAttribute("studentName", studentName);

        response.sendRedirect("studentDashboard.jsp");

    } else {

        response.sendRedirect("studentLogin.jsp?error=1");
    }

} catch(Exception e) {

    out.println("Login Error: " + e.getMessage());

} finally {

    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>