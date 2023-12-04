<%-- 
    Document   : userPage
    Created on : Dec 3, 2023, 11:33:22 PM
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
        <title>Web Market - User Page</title>
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
                    <div class="col-4">
                        <h1>Orders for <c:out value="${loggedInUser.username}"/></h1>
                        <br>
                        <c:if test="${empty allOrders}">
                            <h5 class="text-secondary">Start shopping now and create your first order with Web Market!</h5>
                        </c:if>
                        <c:if test="${not empty allOrders}">
                        <table class="table table-striped table-bordered">
                            <tr class="table-dark">
                                <th>Order ID</th>                         
                                <th>Order Date</th>
                                <th>Order Total</th>
                                <th></th>
                            </tr>
                            <c:forEach var="order" items="${allOrders}">
                                <tr>
                                    <td>${order.orderID}</td>
                                    <td>${order.orderDate}</td>
                                    <td>$${order.orderTotal}</td>
                                    <td style="width:5%">
                                        <form action="Private" method="post">
                                            <input type="hidden" name="orderID" value="${order.orderID}"/>
                                            <input type="hidden" name="action" value="deleteOrder">
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
