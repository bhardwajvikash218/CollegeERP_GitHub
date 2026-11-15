<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Student Fees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Add Student Fees</h2>

<form action="saveFees.jsp" method="post">

    <div class="mb-3">
        <label>Student ID</label>
        <input type="number" name="student_id"
               class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Total Fees</label>
        <input type="number" name="total_fee"
               class="form-control" step="0.01" min="0.01" required>
    </div>

    <div class="mb-3">
        <label>Paid Amount</label>
        <input type="number" name="paid_amount"
               class="form-control" step="0.01" min="0" value="0" required>
    </div>

    <div class="mb-3">
        <label>Last Payment Date</label>
        <input type="date" name="last_payment_date"
               class="form-control">
    </div>

    <div class="mb-3">
        <label>Remarks</label>
        <input type="text" name="remarks"
               class="form-control">
    </div>

    <button type="submit" class="btn btn-primary">
        Save Fees
    </button>

</form>

</body>
</html>