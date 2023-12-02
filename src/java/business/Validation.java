/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package business;

import data.MarketDB;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Tony Le
 */
public class Validation {
    
    private static final Logger LOG = Logger.getLogger(MarketDB.class.getName());
    
    public static boolean isEmail(String email) {
        // checks to see if user input is a valid email
        String emailPattern = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailPattern);
        Matcher matcher = pattern.matcher(email);

        return matcher.matches();
    }
    
    public static boolean isValidEmail(String email) {
        // email must have more than 5 characters and contain a @ and a . after the @
        // email must be unique for every user
        boolean result = false;
        
        try {
            result = MarketDB.validateEmail(email);
        } catch (SQLException e) {
            LOG.log(Level.SEVERE, "*** SQL error in checking email.");
        }
        
        return result;
    }
    
    public static boolean isValidUsername(String username) {
        // username must be unique for every user
        boolean result = false;
        boolean rs = false;
        
        try {
            rs = MarketDB.validateUsername(username);
        } catch (SQLException e) {
            LOG.log(Level.SEVERE, "*** SQL error in checking username.");
        }
        
        return result;
    }
    
    public static boolean isValidPassword(String password) {
        // password must be more than 10 characters long
        boolean result = false;
        
        if (password.length() > 10) {
            result = true;
        }
        
        return result;
    }
}
