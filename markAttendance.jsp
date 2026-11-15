<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2>Mark Student Attendance</h2>

    <form action="saveAttendance.jsp" method="post">

        <div class="mb-3">
            <label>Student ID</label>
            <input type="number" name="student_id"
                   class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Attendance Date</label>
            <input type="date" name="attendance_date"
                   class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Status</label>
            <select name="status" class="form-control" required>
                <option value="">Select Status</option>
                <option value="Present">Present</option>
                <option value="Absent">Absent</option>
                <option value="Leave">Leave</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Remarks</label>
            <input type="text" name="remarks"
                   class="form-control">
        </div>

        <button type="submit" class="btn btn-primary">
            Save Attendance
        </button>

    </form>

</body>
</html>
