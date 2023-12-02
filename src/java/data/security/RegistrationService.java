/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.security;

import business.User;
import data.MarketDB;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.LinkedHashMap;

/**
 *
 * @author Tony Le
 */
public class RegistrationService {
    
    public static RegistrationService shared = new RegistrationService();
    
    public void register(String email, String username, String password) throws SQLException {
        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        
        try {
            user.setPassword(SecurityUtil.hashPassword(password));
            
            LinkedHashMap<String, User> users = MarketDB.selectAllUsers();
            
            if (users.size() == 0) {
                user.setUserType("admin");
            } else {
                user.setUserType("user");
            }
        } catch (Exception ex) {
            Logger.getLogger(RegistrationService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            MarketDB.insertUser(user);
        } catch (SQLException e) {
            throw e;
        }
    }
}
