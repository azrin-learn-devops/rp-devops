package com.example;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "RegisterServlet", urlPatterns = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /* ---------- DB credentials ---------- */
    private static final String JDBC_URL =
        "jdbc:mysql://34.234.51.152:3306/userdetails"
      + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String JDBC_USER = "appuser";
    private static final String JDBC_PASS = "password";

    /* load driver once */
    @Override public void init() throws ServletException {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); }
        catch (ClassNotFoundException e) {
            throw new ServletException("Cannot load MySQL driver", e);
        }
    }

    /* ---------------------------------------------------------- */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email    = req.getParameter("email");
        String language = req.getParameter("language");

        boolean editing = "true".equals(req.getParameter("editing"));

        String sqlInsert = "INSERT INTO UserDetails "
                         + "(username,password,email,language) VALUES (?,?,?,?)";
        String sqlUpdate = "UPDATE UserDetails SET "
                         + "password=?, email=?, language=? WHERE username=?";

        try (Connection c = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             PreparedStatement ps = c.prepareStatement(editing ? sqlUpdate : sqlInsert))
        {
            if (editing) {
                /* UPDATE order matches sqlUpdate fields */
                ps.setString(1, password);
                ps.setString(2, email);
                ps.setString(3, language);
                ps.setString(4, username);
            } else {
                /* INSERT */
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, email);
                ps.setString(4, language);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Database error while "
                    + (editing ? "updating" : "inserting") + " user", e);
        }

        /* back to dashboard */
        resp.sendRedirect(req.getContextPath() + "/UserServlet/dashboard");
    }
}

