<%
session.removeAttribute("studentId");
session.removeAttribute("studentName");
session.invalidate();

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

response.sendRedirect("studentLogin.jsp");
%>