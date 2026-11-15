<html>
<head>
    <title>Add Student - College ERP</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3>Add New Student</h3>
        </div>

        <div class="card-body">

            <form action="saveStudent.jsp" method="post">

                <div class="mb-3">
                    <label class="form-label">Roll Number</label>
                    <input type="text" name="roll_no"
                           class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Student Name</label>
                    <input type="text" name="name"
                           class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email"
                           class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">Course</label>
                    <select name="course" class="form-select" required>
                        <option value="">Select Course</option>
                        <option value="B.Tech CSE">B.Tech CSE</option>
                        <option value="BCA">BCA</option>
                        <option value="MCA">MCA</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Semester</label>
                    <select name="semester" class="form-select" required>
                        <option value="">Select Semester</option>
                        <% for(int i = 1; i <= 8; i++) { %>
                            <option value="<%=i%>">
                                Semester <%=i%>
                            </option>
                        <% } %>
                    </select>
                </div>

                <button type="submit" class="btn btn-success">
                    Save Student
                </button>

                <a href="index.jsp" class="btn btn-secondary">
                    Back
                </a>

            </form>

        </div>
    </div>

</div>

</body>
</html>