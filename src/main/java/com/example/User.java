package com.example;

/** Simple User model, now with “flagged”. */
public class User {
    private String username;
    private String password;
    private String email;
    private String language;
    private boolean flagged;          // NEW

    public User() { }                 // no-arg ctor (needed by JSP / EL)

    public User(String username, String password,
                String email,    String language,
                boolean flagged) {
        this.username = username;
        this.password = password;
        this.email    = email;
        this.language = language;
        this.flagged  = flagged;
    }

    // ---------- getters / setters ----------
    public String  getUsername()           { return username; }
    public void    setUsername(String u)   { this.username = u; }

    public String  getPassword()           { return password; }
    public void    setPassword(String p)   { this.password = p; }

    public String  getEmail()              { return email; }
    public void    setEmail(String e)      { this.email = e; }

    public String  getLanguage()           { return language; }
    public void    setLanguage(String l)   { this.language = l; }

    public boolean isFlagged()             { return flagged; }
    public void    setFlagged(boolean f)   { this.flagged = f; }
}

