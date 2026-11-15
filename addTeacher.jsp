<html>
<head>
    <title>Add Teacher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-5">

    <h2>Add New Teacher</h2>

    <form action="saveTeacher.jsp" method="post">

        <label>Teacher Name</label>
        <input type="text" name="teacher_name" class="form-control" required>

        <br>

        <label>Email</label>
        <input type="email" name="email" class="form-control" required>

        <br>

        <label>Subject</label>
        <input type="text" name="subject" class="form-control" required>

        <br>

        <label>Phone</label>
        <input type="text" name="phone" class="form-control" required>

        <br>

        <button type="submit" class="btn btn-primary">Save Teacher</button>

    </form>

</body>
</html>