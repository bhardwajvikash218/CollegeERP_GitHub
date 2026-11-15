<%@ page import="java.sql.*" %>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*" %>
<%@ page import="javax.crypto.spec.*" %>
<%@ page import="java.util.Base64" %>

<%
int studentId = Integer.parseInt(request.getParameter("student_id"));
String username = request.getParameter("username");
String password = request.getParameter("password");

if(password == null || password.length() < 8) {
    out.println("Password must contain at least 8 characters.");
    return;
}

Connection con = null;
PreparedStatement ps = null;

try {

    // Generate random salt
    byte[] salt = new byte[16];
    SecureRandom random = new SecureRandom();
    random.nextBytes(salt);

    // Hash password using PBKDF2
    PBEKeySpec spec = new PBEKeySpec(
        password.toCharArray(), salt, 120000, 256
    );

    SecretKeyFactory factory =
        SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

    byte[] hash = factory.generateSecret(spec).getEncoded();

    spec.clearPassword();

    String saltText = Base64.getEncoder().encodeToString(salt);
    String hashText = Base64.getEncoder().encodeToString(hash);

    String passwordHash = saltText + ":" + hashText;

    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    ps = con.prepareStatement(
        "INSERT INTO student_login " +
        "(student_id, username, password_hash) VALUES (?, ?, ?)"
    );

    ps.setInt(1, studentId);
    ps.setString(2, username);
    ps.setString(3, passwordHash);

    int result = ps.executeUpdate();

    if(result > 0) {
        out.println("<h3>Student Login Account Created Successfully!</h3>");
        out.println("<a href='addStudentLogin.jsp'>Create Another Account</a>");
    }

} catch(Exception e) {

    out.println("Error: " + e.getMessage());

} finally {

    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>