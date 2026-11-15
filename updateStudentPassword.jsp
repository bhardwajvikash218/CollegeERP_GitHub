<%@ page import="java.sql.*" %>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*" %>
<%@ page import="javax.crypto.spec.*" %>
<%@ page import="java.util.Base64" %>

<%
Integer studentId = (Integer) session.getAttribute("studentId");

if (studentId == null) {
    response.sendRedirect("studentLogin.jsp");
    return;
}

String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword");

if (currentPassword == null || newPassword == null ||
    confirmPassword == null ||
    currentPassword.isEmpty() ||
    newPassword.isEmpty() ||
    confirmPassword.isEmpty()) {

    out.println("All fields are required.");
    return;
}

if (newPassword.length() < 8) {
    out.println("Password must contain at least 8 characters.");
    return;
}

if (!newPassword.equals(confirmPassword)) {
    out.println("New passwords do not match.");
    return;
}

Connection con = null;

try {

    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    String sql = "SELECT password_hash FROM student_login WHERE student_id=?";

    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, studentId);

    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
        rs.close();
        ps.close();
        out.println("Student account not found.");
        return;
    }

    String storedPassword = rs.getString("password_hash");

    rs.close();
    ps.close();

    String[] parts = storedPassword.split(":");

    if (parts.length != 2) {
        out.println("Password data is invalid.");
        return;
    }

    byte[] salt = Base64.getDecoder().decode(parts[0]);
    byte[] oldHash = Base64.getDecoder().decode(parts[1]);

    SecretKeyFactory factory =
        SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

    PBEKeySpec oldSpec = new PBEKeySpec(
        currentPassword.toCharArray(),
        salt,
        120000,
        256
    );

    byte[] enteredHash =
        factory.generateSecret(oldSpec).getEncoded();

    oldSpec.clearPassword();

    if (!MessageDigest.isEqual(oldHash, enteredHash)) {
        out.println("Current password is incorrect.");
        return;
    }

    SecureRandom random = new SecureRandom();

    byte[] newSalt = new byte[16];
    random.nextBytes(newSalt);

    PBEKeySpec newSpec = new PBEKeySpec(
        newPassword.toCharArray(),
        newSalt,
        120000,
        256
    );

    byte[] newHash =
        factory.generateSecret(newSpec).getEncoded();

    newSpec.clearPassword();

    String finalPassword =
        Base64.getEncoder().encodeToString(newSalt) + ":" +
        Base64.getEncoder().encodeToString(newHash);

    String updateSql =
        "UPDATE student_login SET password_hash=? WHERE student_id=?";

    PreparedStatement updatePs = con.prepareStatement(updateSql);

    updatePs.setString(1, finalPassword);
    updatePs.setInt(2, studentId);

    int result = updatePs.executeUpdate();

    updatePs.close();

    if (result > 0) {
        out.println("<h3>Password changed successfully!</h3>");
        out.println("<a href='studentDashboard.jsp'>Go to Dashboard</a>");
    } else {
        out.println("Password could not be updated.");
    }

} catch (Exception e) {

    out.println("Error: " + e.getClass().getSimpleName());

} finally {

    if (con != null) {
        try {
            con.close();
        } catch (Exception e) {
        }
    }
}
%>