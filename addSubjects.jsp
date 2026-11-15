<!DOCTYPE html>
<html>
<head>
    <title>Add Subject</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>

<body class="container mt-5">

<h2>Add New Subject</h2>
<form action="saveSubject.jsp" method="post">

    <div class="mb-3">
        <label>Subject Name</label>
        <input type="text" name="subject_name"
        class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Subject Code</label>
        <input type="text" name="subject_code"
        class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Semester</label>
        <select name="semester" class="form-control" required>
            <option value="">Select Semester</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Description</label>
        <textarea name="description"
        class="form-control"></textarea>
    </div>

    <button type="submit" class="btn btn-success">
        Save Subject
    </button>

</form>

</body>
</html>