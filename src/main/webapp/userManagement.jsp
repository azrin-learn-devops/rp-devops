<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>User Management Dashboard</title>

  <!-- Bootswatch “Cosmo” for styling + FontAwesome for icons -->
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/cosmo/bootstrap.min.css">
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body {
      background:#f3f4f6;
      font-family:'Inter','Roboto',sans-serif;
    }
    .card {
      border:none;
      border-radius:1rem;
      box-shadow:0 0.5rem 1rem rgba(0,0,0,.08);
      margin: 40px auto;
      max-width: 960px;
    }
    h3 {
      font-weight:600;
      letter-spacing:.5px;
    }
    .table thead th {
      border-bottom:none;
      text-transform:uppercase;
      font-size:.75rem;
      letter-spacing:.08em;
      color:#6c757d;
    }
    .table tbody tr:hover {
      background:#eff6ff;
    }
    .btn-pill {
      border-radius:50rem;
      padding:.35rem 1.1rem;
      font-size:.85rem;
    }
    .btn-add {
      background:#28a745;
      color:#fff;
    }
    .btn-edit { color:#17a2b8; }
    .btn-del  { color:#dc3545; }
    .btn-edit:hover { color:#0f6674; }
    .btn-del:hover  { color:#a71d2a; }
    .btn i { margin-right:.35rem; }
  </style>
</head>
<body>
  <div class="card p-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3>List of Users</h3>
      <a href="${pageContext.request.contextPath}/UserServlet/new"
         class="btn btn-add btn-pill">
         <i class="fa fa-user-plus"></i> Add New User
      </a>
    </div>

    <table class="table table-hover">
      <thead>
        <tr>
          <th>Name</th>
          <th>Password</th>
          <th>Email</th>
          <th>Language</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="user" items="${listUsers}">
          <tr>
            <td><c:out value="${user.username}" /></td>
            <td><c:out value="${user.password}" /></td>
            <td><c:out value="${user.email}" /></td>
            <td><c:out value="${user.language}" /></td>
            <td>
              <a class="btn btn-link btn-edit"
                 href="${pageContext.request.contextPath}/UserServlet/edit?username=${user.username}">
                 <i class="fa fa-pen"></i> Edit
              </a>
              &nbsp;
              <a class="btn btn-link btn-del"
                 onclick="return confirm('Are you sure you want to delete user ${user.username}?');"
                 href="${pageContext.request.contextPath}/UserServlet/delete?username=${user.username}">
                 <i class="fa fa-trash"></i> Delete
              </a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</body>
</html>

