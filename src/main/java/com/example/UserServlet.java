package com.example;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Central controller for listing, flagging, editing and deleting users.
 *
 * URL patterns   (all under /UserServlet/*)
 *   /dashboard         – list all users
 *   /new               – forward to register.jsp
 *   /edit?username=…   – forward to edit.jsp with pre-filled user
 *   /delete?username=… – delete & redirect
 *   /flag?username=…   – set flagged = 1
 *   /unflag?username=… – set flagged = 0
 */
@WebServlet(name = "UserServlet", urlPatterns = "/UserServlet/*")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /* ---------- database credentials ---------- */
    private static final String JDBC_URL =
        "jdbc:mysql://34.234.51.152:3306/userdetails"
      + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String JDBC_USER = "appuser";
    private static final String JDBC_PASS = "password";

    private Connection getConn() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
    }

@Override
public void init() throws ServletException {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        throw new ServletException("MySQL JDBC driver not found", e);
    }
}


    /* =======================================================================
                                ROUTER
       ======================================================================= */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getPathInfo();              // may be null

        if (action == null || "/".equals(action) || "/dashboard".equals(action)) {
            listUsers(req, resp);
            return;
        }

        switch (action) {
            case "/new":
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                break;

            case "/edit":
                loadAndForwardUser(req.getParameter("username"), req, resp);
                break;

            case "/delete":
                deleteUser(req.getParameter("username"));
                resp.sendRedirect(req.getContextPath() + "/UserServlet/dashboard");
                break;

            case "/flag":
                toggleFlag(req.getParameter("username"), true);
                resp.sendRedirect(req.getContextPath() + "/UserServlet/dashboard");
                break;

            case "/unflag":
                toggleFlag(req.getParameter("username"), false);
                resp.sendRedirect(req.getContextPath() + "/UserServlet/dashboard");
                break;

            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /* =======================================================================
                                LIST
       ======================================================================= */
    private void listUsers(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<User> users = new ArrayList<>();
        String sql = "SELECT username,password,email,language,flagged FROM UserDetails";

        try (Connection c = getConn();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                User u = new User();
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setEmail   (rs.getString("email"));
                u.setLanguage(rs.getString("language"));
                u.setFlagged (rs.getBoolean("flagged"));
                users.add(u);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("users", users);
        req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
    }

    /* =======================================================================
                                FLAG / UNFLAG
       ======================================================================= */
    private void toggleFlag(String username, boolean flag) {
        String sql = "UPDATE UserDetails SET flagged = ? WHERE username = ?";
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, flag);
            ps.setString (2, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /* =======================================================================
                                DELETE
       ======================================================================= */
    private void deleteUser(String username) {
        String sql = "DELETE FROM UserDetails WHERE username = ?";
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /* =======================================================================
                                EDIT  (load one row)
       ======================================================================= */
    private void loadAndForwardUser(String username,
                                    HttpServletRequest req,
                                    HttpServletResponse resp)
            throws ServletException, IOException {

        String sql = "SELECT username,password,email,language,flagged "
                   + "FROM UserDetails WHERE username = ?";
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setEmail   (rs.getString("email"));
                    u.setLanguage(rs.getString("language"));
                    u.setFlagged (rs.getBoolean("flagged"));
                    req.setAttribute("user", u);

                    req.getRequestDispatcher("/edit.jsp").forward(req, resp);
                    return;
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);  // no such user
    }
}

