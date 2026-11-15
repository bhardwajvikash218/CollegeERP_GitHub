<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow p-4">

        <h2 class="mb-4">Add New Exam</h2>

        <form action="saveExam.jsp" method="post">

            <div class="mb-3">
                <label>Exam Name</label>
                <input type="text" name="exam_name"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Exam Type</label>
                <select name="exam_type" class="form-control" required>
                    <option value="">Select Exam Type</option>
                    <option value="Internal">Internal</option>
                    <option value="Mid-Term">Mid-Term</option>
                    <option value="Final">Final</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Subject ID</label>
                <input type="number" name="subject_id"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Semester</label>
                <input type="number" name="semester"
                       class="form-control" min="1" required>
            </div>

            <div class="mb-3">
                <label>Exam Date</label>
                <input type="date" name="exam_date"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Total Marks</label>
                <input type="number" name="total_marks"
                       class="form-control" min="1" required>
            </div>

            <div class="mb-3">
                <label>Description</label>
                <textarea name="description"
                          class="form-control"></textarea>
            </div>

            <button type="submit" class="btn btn-primary">
                Save Exam
            </button>

            <a href="adminDashboard.jsp"
               class="btn btn-secondary">
                Back
            </a>

        </form>

    </div>

</div>

</body>
</html>