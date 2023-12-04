<%-- 
    Document   : cart
    Created on : Dec 2, 2023, 3:45:17 PM
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
        <title>Web Market - Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="/layout/navbar.jsp" />
        <main id="main-content">
            <div class="container">
                <div class="row">
                    <div class="col-4"></div>
                    <div class="col-10">
                        <h1>Hello <c:out value="${loggedInUser.username}"/>, this is your cart.</h1>
                    </div>
                    <table class="table table-striped" border="1" column="1">
                        <tr class="table-dark">
                            <th>Product Name</th>
                            <th>Details</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th></th>
                        </tr>
                        
                        <c:forEach var="cartItem" items="${cartItems}">
                            <tr>
                                <td>${cartItem.productName}</td>
                                <td>${cartItem.productDetails}</td>
                                <td>${cartItem.productPrice}</td>
                                <td>${cartItem.quantity}</td>
                                <td>
                                    <form action="Private" method="post">
                                        <input type="hidden" name="cartID" value="${cartItem.cartID}"/>
                                        <input type="hidden" name="action" value="deleteCartItem">
                                        <button type="submit" class="btn btn-success">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <form action="Private" method="post">
                        <input type="hidden" name="action" value="submitCart">
                        <button type="submit" class="btn btn-success">Submit</button>
                    </form>
                </div>               
            </div>
        </main>
    </body>
</html>