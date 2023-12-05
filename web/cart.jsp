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
        <style>
            .container {
                text-align: center;
            }
            table {
                margin: 0 auto;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="/layout/navbar.jsp" />
        <br>
        <main id="main-content">
            <div class="container">
                <div class="row">
                    <div class="col-4"></div>
                    <div>
                        <h1>Hello <c:out value="${loggedInUser.username}"/>, this is your cart.</h1>
                        <br>
                    </div>
                    <c:if test="${empty cartItems}">
                        <h5 class="text-secondary">Your cart is feeling a bit lonely! 
                            It's a great time to explore our collection and add some fantastic items. 
                            Happy shopping!</h5>
                        </c:if>
                        <c:if test="${not empty cartItems}">
                        <table class="table table-striped table-bordered">
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
                                    <td>$${cartItem.productPrice}</td>
                                    <td style="width:1%">${cartItem.quantity}</td>
                                    <td style="width:5%">
                                        <form action="Private" method="post">
                                            <input type="hidden" name="cartID" value="${cartItem.cartID}"/>
                                            <input type="hidden" name="action" value="deleteCartItem">
                                            <button type="submit" class="btn btn-danger">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <div style="text-align: right;">
                            <p>Total Price: $<c:out value="${String.format('%.2f', cartTotal)}"/></p>
                        </div>
                        <form action="Private" method="post" style="text-align: right;">
                            <input type="hidden" name="action" value="submitCart">
                            <button type="submit" class="btn btn-success">Submit</button>
                        </form>
                    </c:if>
                </div>           
            </div>
        </main>
    </body>
</html>
