<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of Users</title>
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/cosmo/bootstrap.min.css">
<style>
  .table-flagged { background:#ffa726!important; }   /* orange rows */
</style>
</head>
<body class="p-4">

<h2 class="text-center">List of Users</h2>

<a href="${pageContext.request.contextPath}/UserServlet/new"
   class="btn btn-success mb-3">Add New User</a>

<table class="table table-hover">
<thead>
  <tr><th>Name</th><th>Password</th><th>Email</th>
      <th>Language</th><th>Actions</th></tr>
</thead>
<tbody>
<c:forEach var="u" items="${users}">
  <tr class="${u.flagged ? 'table-flagged' : ''}">
    <td>${u.username}</td>
    <td>${u.password}</td>
    <td>${u.email}</td>
    <td>${u.language}</td>
    <td>
      <a href="${pageContext.request.contextPath}/UserServlet/edit?username=${u.username}">
        Edit</a> |
      <a href="${pageContext.request.contextPath}/UserServlet/delete?username=${u.username}"
         onclick="return confirm('Delete ${u.username}?');">Delete</a> |
      <c:choose>
        <c:when test="${u.flagged}">
          <a href="${pageContext.request.contextPath}/UserServlet/unflag?username=${u.username}">
            Unflag</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/UserServlet/flag?username=${u.username}">
            Flag</a>
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
</c:forEach>
</tbody>
</table>
</body>
</html>

