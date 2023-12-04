/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import business.*;
import data.*;
import data.security.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tony Le
 */
public class Public extends HttpServlet {
    String url = "";
    User loggedInUser = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "default";
        }

        if (action.equals("gotoIndex")) {
            url = "/index.jsp";
        }

        if (action.equals("register")) {
            register(request);
        }

        if (action.equals("login")) {
            login(request);
        }

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    private void register(HttpServletRequest request)
            throws ServletException, IOException {
        String email = ((String) request.getParameter("email"));
        String username = ((String) request.getParameter("username"));
        String password = ((String) request.getParameter("password"));
        String verifyPassword = ((String) request.getParameter("verify-password"));

        List<String> errors = new ArrayList<>();

        if (!Validation.isEmail(email)) {
            errors.add("Email entered is invalid. A valid format looks like this: example@somesite.com");
        }
        
        if (Validation.isValidEmail(email)) {
            errors.add("The email you entered is already tied with an account.");
        }

        if (!Validation.isValidUsername(username)) {
            errors.add("The username you entered is already taken.");
        }

        if (!Validation.isValidPassword(password)) {
            errors.add("Your password must be longer than 10 characters.");
        }

        if (!password.equals(verifyPassword)) {
            errors.add("The password and password verification fields don't match.");
        }

        if (!errors.isEmpty()) {
            url = "/register.jsp";
            request.setAttribute("errors", errors);
        } else {
            try {
                RegistrationService.shared.register(email, username, password);
                url = "/login.jsp";
            } catch (SQLException ex) {
                url = "/register.jsp";
                errors.add("Something went wrong when registering the user: " + ex.getMessage());
        request.setAttribute("errors", errors);
                Logger.getLogger(Public.class.getName()).log(Level.SEVERE, null, ex);
            }                   
        }
    }

    private void login(HttpServletRequest request) {
        String usernameOrEmail = ((String) request.getParameter("email-or-username"));
        String password = ((String) request.getParameter("password"));

        List<String> errors = new ArrayList<>();

        if (usernameOrEmail.equals("")) {
            errors.add("Username or Email is null.");
            url = "/login.jsp";
            request.setAttribute("errors", errors);
            return;
        }

        if (password.equals("")) {
            errors.add("Password is null.");
            url = "/login.jsp";
            request.setAttribute("errors", errors);
            return;
        }
        
        boolean wasLogInSuccessful = AuthenticationService.shared.login(usernameOrEmail, password);
        
        if (wasLogInSuccessful) {
            try {
                loggedInUser = MarketDB.getUserInfo(usernameOrEmail);
                request.getSession().setAttribute("loggedInUser", loggedInUser);
                
                if (loggedInUser.getUserType().equals("admin")) {
                    url = "/index.jsp";
                } else {
                    url = "/index.jsp";
                }            
            } catch (Exception e) {
                errors.add("A user with the provided details does not exist.");
                        
                url = "/login.jsp";
            }
        } else {
            errors.add("Invalid username/email or password");
            url = "/login.jsp";
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
