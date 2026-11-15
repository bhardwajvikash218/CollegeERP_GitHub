<%@ page import="java.sql.*" %>

<%
if (session.getAttribute("adminUser") == null) {
    response.sendRedirect("login.jsp");
    return;
}

int totalStudents = 0;
int totalTeachers = 0;
int totalSubjects = 0;
String dbError = "";

try {
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/college_erp",
        "root",
        System.getenv("DB_PASSWORD")
    );

    Statement st = con.createStatement();

    ResultSet rs1 = st.executeQuery(
        "SELECT COUNT(*) AS total FROM students"
    );

    if (rs1.next()) {
        totalStudents = rs1.getInt("total");
    }
    rs1.close();

    ResultSet rs2 = st.executeQuery(
        "SELECT COUNT(*) AS total FROM teachers"
    );

    if (rs2.next()) {
        totalTeachers = rs2.getInt("total");
    }
    rs2.close();

    ResultSet rs3 = st.executeQuery(
        "SELECT COUNT(*) AS total FROM subjects"
    );

    if (rs3.next()) {
        totalSubjects = rs3.getInt("total");
    }
    rs3.close();

    st.close();
    con.close();

} catch (Exception e) {
    dbError = e.getMessage();
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - College ERP</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
    <div class="container">
        <span class="navbar-brand">College ERP Admin</span>

        <a href="logout.jsp" class="btn btn-light">Logout</a>
    </div>
</nav>

<div class="container mt-5">

    <h2 class="mb-3">College ERP - Admin Dashboard</h2>

    <p>College ERP Management Dashboard</p>

    <% if (!dbError.isEmpty()) { %>
        <div class="alert alert-danger">
            Database Error: <%= dbError %>
        </div>
    <% } %>

    <!-- Dashboard Counts -->

    <div class="row">

        <div class="col-md-6 mb-3">
            <div class="card bg-primary-subtle p-4">
                <h3>Total Students</h3>
                <h1><%= totalStudents %></h1>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="card bg-success-subtle p-4">
                <h3>Total Teachers</h3>
                <h1><%= totalTeachers %></h1>
            </div>
        </div>
        <div class="col-md-6 mb-3">
             <div class="card bg-primary-subtle p-4">
                <h5>Total Subjects</h5>
                <h2><%= totalSubjects %></h2>
                </div>
        </div>
    </div>

    <!-- Management Modules -->

    <div class="row mt-4">

        <div class="col-md-6 mb-3">
            <div class="card shadow">
                <div class="card body">
                    <h5>Student Management</h5>
                    <p>Add, view, edit and delete students.</p>

                    <a href="viewStudents.jsp"
                       class="btn btn-primary">
                        Manage Students
                    </a>

                    <a href="addStudent.jsp"
                       class="btn btn-success">
                        Add Student
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="card shadow">
                <div class="card-body">
                    <h5>Teacher Management</h5>
                    <p>Add and view college teachers.</p>

                    <a href="viewTeachers.jsp"
                       class="btn btn-primary">
                        Manage Teachers
                    </a>

                    <a href="addTeacher.jsp"
                       class="btn btn-success">
                        Add Teacher
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <div class="card shadow">
                <div class="card-body">
                    <h5>Subject Management</h5>
                    <p>Add and view college Subject.</p>

                    <a href="addSubjects.jsp"
                       class="btn btn-primary">
                        Manage Subjects
                    </a>

                    <a href="viewSubjects.jsp"
                       class="btn btn-success">
                        Add Subject
                    </a>
                </div>
            </div>
        </div>
        <!-- Attendance Management -->
         <div class="card md-4 mb-4">
            <div class="card shadow">
            <div class="card-body">
                <h4 class="card-title">Attendance Management</h4>
                <p>Manage student attendance records.</p>
                <a href="markAttendance.jsp"
                class="btn btn-primary ">Mark Attendance</a>
                <a href="viewAttendance.jsp"
                class="btn btn-success ">View Attendance</a>
                <a href="studentAttendanceReport.jsp"
                class="btn btn-info ">Attendance Report</a>
            </div>
            </div>
        </div>
        <!-- Student management!-->
        <div class="col-md-4">
    <div class="card shadow p-3 mb-3">
        <h5>Student Login Management</h5>
        <p>Manage student usernames and passwords.</p>

        <a href="addStudentLogin.jsp"
           class="btn btn-success mb-2">
            Create Student Login
        </a>

        <a href="manageStudentLogin.jsp"
           class="btn btn-warning">
            Manage Student Login
        </a>
    </div>
</div>
        <!-- Fees Management -->
         
        <div class="col-md-4 mb-4">
            <div class="card shadow">
                <div class="card-body">
                    
                    <h5 class="card-title">Fees Management</h5>
                    <p class="card-text">
                        Manage student fees and payment records.</p>
                        
                        <a href="addFees.jsp"
                        class="btn btn-primary btn-sm">Add Fees</a>
                        <a href="viewFees.jsp"
                        class="btn btn-success btn-sm">View Fees</a>
                        <a href="dueFeesReport.jsp"
                        class="btn btn-warning btn-sm">Due Fees Report</a>
                    </div>
                </div>
            </div>
            <!-- Exam Management -->
             
            <div class="col-md-4 mb-4">
                <div class="card shadow">
                    <div class="card-body">
                        <h5 class="card-title">Exam Management</h5>
                        <p class="card-text">
                            Manage exams and examination records.
                        </p>
                        <a href="addExam.jsp"
                        class="btn btn-primary btn-sm">Add Exam</a>
                        <a href="viewExams.jsp"
                        class="btn btn-success btn-sm">View Exams</a><br>
                        <a href="studentResultReport.jsp"
                        class="btn btn-primary btn-sm">Student Result Report</a>
                        <a href="searchStudentResult.jsp"
                        class="btn btn-success btn-sm"> Search Student Result</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>