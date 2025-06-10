<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/cosmo/bootstrap.min.css">
</head>
<body class="p-4">

<h2>Edit User</h2>

<!-- re-use RegisterServlet to handle update -->
<form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
  <input type="hidden" name="editing" value="true"/>
  <input type="hidden" name="username" value="${user.username}"/>

  <div class="form-group">
    <label>Username:</label>
    <input class="form-control" value="${user.username}" readonly/>
  </div>

  <div class="form-group">
    <label>Password:</label>
    <input name="password" class="form-control"
           value="${user.password}" required/>
  </div>

  <div class="form-group">
    <label>Email:</label>
    <input name="email" type="email"
           class="form-control" value="${user.email}" required/>
  </div>

  <div class="form-group">
    <label>Language:</label>
    <select name="language" class="form-control" required>
      <option value="English" ${user.language=='English'?'selected':''}>English</option>
      <option value="Spanish" ${user.language=='Spanish'?'selected':''}>Spanish</option>
      <option value="French"  ${user.language=='French' ?'selected':''}>French</option>
    </select>
  </div>

  <button class="btn btn-primary">Save</button>
  <a class="btn btn-secondary"
     href="${pageContext.request.contextPath}/UserServlet/dashboard">Cancel</a>
</form>
</body>
</html>

