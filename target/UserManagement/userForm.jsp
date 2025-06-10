<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><c:choose>
    <c:when test="${user != null}">Edit User</c:when>
    <c:otherwise>Add New User</c:otherwise>
  </c:choose></title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/cosmo/bootstrap.min.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8f9fa;
    }
    .container {
      max-width: 480px;
      margin: 40px auto;
      background: #fff;
      padding: 20px 30px;
      border-radius: 8px;
      box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15);
    }
    h2 {
      text-align: center;
      margin-bottom: 20px;
      font-weight: 600;
    }
    .form-group label {
      font-weight: bold;
    }
    .btn-submit {
      width: 100%;
    }
    .btn-back {
      margin-top: 10px;
      width: 100%;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>
      <c:choose>
        <c:when test="${user != null}">Edit User</c:when>
        <c:otherwise>Add New User</c:otherwise>
      </c:choose>
    </h2>

    <!-- If user != null, we are editing. Otherwise, we are adding. -->
    <form action="<c:choose>
                    <c:when test='${user != null}'>${pageContext.request.contextPath}/UserServlet/update</c:when>
                    <c:otherwise>${pageContext.request.contextPath}/RegisterServlet</c:otherwise>
                  </c:choose>"
          method="post">

      <!-- If editing, include a hidden field for original username -->
      <c:if test="${user != null}">
        <input type="hidden" name="username" value="${user.username}" />
      </c:if>

      <div class="form-group">
        <label for="userName">Name:</label>
        <input type="text" class="form-control" id="userName" name="username"
               value="${user != null ? user.username : ''}"
               <c:if test="${user != null}">readonly</c:if>
               required/>
        <!-- We make the 'username' read-only on edit, since it is the PK. -->
      </div>

      <div class="form-group">
        <label for="password">Password:</label>
        <input type="text" class="form-control" id="password" name="password"
               value="${user != null ? user.password : ''}" required/>
      </div>

      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" class="form-control" id="email" name="email"
               value="${user != null ? user.email : ''}" required/>
      </div>

      <div class="form-group">
        <label for="language">Language:</label>
        <input type="text" class="form-control" id="language" name="language"
               value="${user != null ? user.language : ''}" required/>
      </div>

      <button type="submit" class="btn btn-success btn-submit">
        <c:choose>
          <c:when test="${user != null}">Save Changes</c:when>
          <c:otherwise>Register User</c:otherwise>
        </c:choose>
      </button>

      <a href="${pageContext.request.contextPath}/UserServlet/dashboard"
         class="btn btn-secondary btn-back">Back to Dashboard</a>
    </form>
  </div>
</body>
</html>

