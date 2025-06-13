# UserManagement

A simple Java web-app for managing users (create, list, edit, delete, flag/unflag)  
Built with Maven, Tomcat 9, JSP/Servlets, and MySQL.

## Features

- **Add/Edit** users with name, password, email, language  
- **List** users in a dashboard with flag/unflag toggle  
- **Delete** users with confirmation  
- **Clean three-tier architecture** (JSP → Servlets → MySQL)

## Prerequisites

- Java 11+ and Maven  
- MySQL 8 (create a database `userdetails`)  
- Tomcat 9

## Quickstart

```bash
# 1. Clone
git clone git@github.com:your-username/UserManagement.git
cd UserManagement

# 2. Configure DB credentials in src/main/java/com/example/*.java

# 3. Build
./mvnw clean package

# 4. Deploy to Tomcat
cp target/UserManagement.war /path/to/tomcat/webapps/
systemctl restart tomcat9

# 5. Browse
http://localhost:8080/UserManagement/UserServlet/dashboard

