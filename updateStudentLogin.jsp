<%@ page import="java.sql.*" %>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*" %>
<%@ page import="javax.crypto.spec.*" %>
<%@ page import="java.util.Base64" %>

<%
String studentId = request.getParameter("student_id");
String username = request.getParameter("username");
String password = request.getParameter("password");

if (studentId == null || username == null || password == null ||
    studentId.trim().isEmpty() || username.trim().isEmpty() ||
    password.length() < 8) {
    out.println("Please enter valid details. Password must be at least 8 characters.");
    return;
}

Connection con = null;
PreparedStatement ps = null;

try {
    // Generate a new random salt
    byte[] salt = new byte[16];
    new SecureRandom().nextBytes(salt);

    // Create password hash
    PBEKeySpec spec = new PBEKeySpec(
        password.toCharArray(), salt, 120000, 256
    );

    SecretKeyFactory factory =
        SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

    byte[] hash = factory.generateSecret(spec).getEncoded();
    spec.clearPassword();

    String passwordHash =
        Base64.getEncoder().encodeToString(salt) + ":" +
        Base64.getEncoder().encodeToString(hash);

    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    String sql = "UPDATE student_login SET username=?, password_hash=? WHERE student_id=?";

    ps = con.prepareStatement(sql);
    ps.setString(1, username.trim());
    ps.setString(2, passwordHash);
    ps.setInt(3, Integer.parseInt(studentId));

    int result = ps.executeUpdate();

    if (result > 0) {
        out.println("<h3>Student login updated successfully!</h3>");
        out.println("<a href='manageStudentLogin.jsp'>Back to Manage Login</a>");
    } else {
        out.println("Student login record not found.");
    }

} catch (SQLIntegrityConstraintViolationException e) {
    out.println("This username is already in use. Please choose another.");

} catch (Exception e) {
    out.println("Unable to update student login. Please check the details and database connection.");

} finally {
    if (ps != null) try { ps.close(); } catch (Exception e) {}
    if (con != null) try { con.close(); } catch (Exception e) {}
}
%>