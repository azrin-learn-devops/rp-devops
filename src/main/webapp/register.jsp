<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register New User</title>

  <!-- Bootswatch Cosmo (Bootstrap 4) for quick styling -->
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/cosmo/bootstrap.min.css">

  <style>
    body {
      background: #f8f9fa;
      font-family: Arial, sans-serif;
    }
    .card {
      max-width: 480px;
      margin: 40px auto;
      box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15);
    }
    .card-header {
      text-align: center;
      font-weight: 600;
      font-size: 1.4rem;
    }
    .btn-block {
      width: 100%;
    }
  </style>
</head>

<body>
  <div class="card">
    <div class="card-header">Add New User</div>

    <div class="card-body">
      <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">

        <!-- Username -->
        <div class="form-group">
          <label for="username">Name:</label>
          <input type="text"
                 id="username"
                 name="username"
                 class="form-control"
                 required />
        </div>

        <!-- Password -->
        <div class="form-group">
          <label for="password">Password:</label>
          <input type="password"
                 id="password"
                 name="password"
                 class="form-control"
                 required />
        </div>

        <!-- Email -->
        <div class="form-group">
          <label for="email">Email:</label>
          <input type="email"
                 id="email"
                 name="email"
                 class="form-control"
                 required />
        </div>

        <!-- Language -->
        <div class="form-group">
          <label for="language">Language:</label>
          <select id="language"
                  name="language"
                  class="form-control"
                  required>
            <option value="" disabled selected>-- choose --</option>
            <option value="English">English</option>
            <option value="Spanish">Spanish</option>
            <option value="French">French</option>
          </select>
        </div>


        <!-- Submit -->
        <button type="submit"
                class="btn btn-success btn-block">
          Register User
        </button>

        <!-- Back link -->
        <a href="${pageContext.request.contextPath}/UserServlet/dashboard"
           class="btn btn-secondary btn-block mt-2">
          Back to Dashboard
        </a>
      </form>
    </div>
  </div>
</body>
</html>

