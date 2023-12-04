/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import business.*;
import data.MarketDB;
import data.security.SecurityUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.*;

/**
 *
 * @author Tony Le
 */
public class Private extends HttpServlet {

    String url = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect("Public");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "default";
        }

        switch (action) {
            case "logout": {
                logout(request);

                break;
            }
            case "orderList": {
                url = "/userPage.jsp";
                ArrayList<Order> allOrders = new ArrayList();

                try {
                    allOrders = MarketDB.selectAllOrders();
                } catch (SQLException e) {
                    Logger.getLogger(MarketDB.class.getName()).log(Level.SEVERE, null, e);
                }

                request.setAttribute("allOrders", allOrders);
                break;
            }
            case "productList": {
                url = "/products.jsp";
                ArrayList<Product> allProducts = new ArrayList();

                try {
                    allProducts = MarketDB.selectAllProducts();
                } catch (SQLException e) {
                    Logger.getLogger(MarketDB.class.getName()).log(Level.SEVERE, null, e);
                }

                request.setAttribute("allProducts", allProducts);
                break;
            }
            case "productListAdmin": {
                url = "/adminProducts.jsp";
                ArrayList<Product> allProducts = new ArrayList();

                try {
                    allProducts = MarketDB.selectAllProducts();
                } catch (SQLException e) {
                    Logger.getLogger(MarketDB.class.getName()).log(Level.SEVERE, null, e);
                }

                request.setAttribute("allProducts", allProducts);
                break;
            }
            case "addToCart": {
                url = "/Private?action=cartItems";

                int productID = 0;

                try {
                    productID = Integer.parseInt(request.getParameter("productID"));
                } catch (NumberFormatException en) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, en);
                }

                int quantity = 0;

                try {
                    quantity = Integer.parseInt(request.getParameter("quantity"));
                } catch (NumberFormatException en) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, en);
                }

                Cart cart = new Cart(loggedInUser.getUserID(), productID, quantity);

                try {
                    MarketDB.addToCart(cart);
                } catch (SQLException ex) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            }
            case "cartItems": {
                url = "/cart.jsp";
                ArrayList<CartItem> cartItems = new ArrayList();
                int userID = loggedInUser.getUserID();

                try {
                    cartItems = MarketDB.getCartItemsByUserID(userID);
                } catch (SQLException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                request.setAttribute("cartItems", cartItems);
                break;
            }
            case "deleteCartItem": {
                int cartID = 0;

                try {
                    cartID = Integer.parseInt(request.getParameter("cartID"));
                } catch (NumberFormatException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                try {
                    MarketDB.deleteCartItem(cartID);
                } catch (SQLException ex) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, ex);
                }

                url = "/Private?action=cartItems";
                break;
            }
            case "submitCart": {
                url = "/confirmation.jsp";

                int userID = loggedInUser.getUserID();

                ArrayList<CartItem> cartItems = new ArrayList();

                try {
                    cartItems = MarketDB.getCartItemsByUserID(userID);
                } catch (SQLException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                double orderTotal = 0;

                for (CartItem cartItem : cartItems) {
                    orderTotal += cartItem.getProductPrice();
                }

                Order order = new Order(userID, LocalDate.now(), orderTotal);

                try {
                    MarketDB.submitCart(order);
                } catch (SQLException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                try {
                    MarketDB.clearCart(userID);
                } catch (SQLException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                break;
            }
            case "addProduct": {
                url = "/addProduct.jsp";

                break;
            }
            case "submitProduct": {
                String name = request.getParameter("productName");
                String details = request.getParameter("productDetails");
                double price = Double.parseDouble(request.getParameter("productPrice"));

                Product product = new Product(name, details, price);

                try {
                    MarketDB.insertProduct(product);
                } catch (SQLException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                url = "/Private?action=productListAdmin";
                break;
            }
            case "deleteProduct": {
                int productID = 0;

                try {
                    productID = Integer.parseInt(request.getParameter("productID"));
                } catch (NumberFormatException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                try {
                    MarketDB.deleteProduct(productID);
                } catch (SQLException ex) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, ex);
                }

                url = "/Private?action=productListAdmin";
                break;
            }
            case "deleteOrder": {
                int orderID = 0;

                try {
                    orderID = Integer.parseInt(request.getParameter("orderID"));
                } catch (NumberFormatException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                try {
                    MarketDB.deleteOrder(orderID);
                } catch (SQLException ex) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, ex);
                }

                url = "/Private?action=orderList";
                break;
            }
            case "adminUserAction": {
                url = "/adminAllUsers.jsp";
                LinkedHashMap<String, User> allUsers = new LinkedHashMap();

                try {
                    allUsers = MarketDB.selectAllUsers();
                } catch (SQLException e) {
                    Logger.getLogger(MarketDB.class.getName()).log(Level.SEVERE, null, e);
                }

                request.setAttribute("allUsers", allUsers);
                break;
            }
            case "adminDeleteUser": {
                int userID = 0;

                try {
                    userID = Integer.parseInt(request.getParameter("userID"));
                } catch (NumberFormatException e) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, e);
                }

                try {
                    MarketDB.deleteUser(userID);
                } catch (SQLException ex) {
                    Logger.getLogger(Private.class.getName()).log(Level.SEVERE, null, ex);
                }

                url = "/Private?action=adminUserAction";
                break;
            }
        }

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    private void logout(HttpServletRequest request) {
        request.getSession().invalidate();
        url = "/Public?action=gotoIndex";
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
