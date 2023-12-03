/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package business;

/**
 *
 * @author Tony Le
 */
public class Product {
    private int productID;
    private String productName;
    private String productDetails;
    private double productPrice;

    public Product() {
    }

    public Product(String productName, String productDetails, double productPrice) {
        this.productName = productName;
        this.productDetails = productDetails;
        this.productPrice = productPrice;
    }  

    public Product(int productID, String productName, String productDetails, double productPrice) {
        this.productID = productID;
        this.productName = productName;
        this.productDetails = productDetails;
        this.productPrice = productPrice;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDetails() {
        return productDetails;
    }

    public void setProductDetails(String productDetails) {
        this.productDetails = productDetails;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }
    
    
}
