/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package business;

import java.time.LocalDate;

/**
 *
 * @author Tony Le
 */
public class Order {
    private int orderID;
    private int userID;
    private LocalDate orderDate;
    private double orderTotal;

    public Order() {
    }

    public Order(int userID, LocalDate orderDate, double orderTotal) {
        this.userID = userID;
        this.orderDate = orderDate;
        this.orderTotal = orderTotal;
    }

    public Order(int orderID, int userID, LocalDate orderDate, double orderTotal) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.orderTotal = orderTotal;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public double getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(double orderTotal) {
        this.orderTotal = orderTotal;
    }
    
    
}
