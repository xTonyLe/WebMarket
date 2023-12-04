<%-- 
    Document   : addProduct
    Created on : Dec 3, 2023, 3:18:05 PM
    Author     : Tony Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("loggedInUser") == null) {
        // Redirect to a different page if loggedInUser is not in the session
        response.sendRedirect("login.jsp"); // Replace "login.jsp" with the desired redirection URL
        return; // To stop further execution of JSP
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web Market - Admin Add Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="layout/navbar.jsp" />
        <br>
        <main id="main-content">
            <h1 class="text-center">Add a Product</h1>
            <br>
            <div class="container">
                <div class="row">
                    <div class="col-4"></div>                   
                    <div class="col-4">
                        <form action="Private" method="post">
                            <input type="hidden" name="action" value="submitProduct">
                            <label for="name-field">Product Name</label>
                            <br>
                            <input type="text" id="name-field" name="productName" class="form-control" required>
                            <br>
                            <label for="details-field">Product Details</label>
                            <br>
                            <textarea id="details-field" name="productDetails" rows="5" cols="50" class="form-control" required></textarea>
                            <br>
                            <label for="price-field">Product Price</label>
                            <br>
                            <input type="text" id="price-field" name="productPrice" class="form-control" title="Enter a valid price (e.g., 10 or 10.99)" required>
                            <br>                          
                            <button type="submit" class="btn btn-success">Add Product</button>
                        </form>
                    </div>                                                              
                    <div class="col-4"></div>
                </div>
            </div>
        </main>
    </body>
</html>
