<%-- 
    Document   : products
    Created on : Dec 2, 2023, 3:07:45 PM
    Author     : Tony Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web Market - Products</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="layout/navbar.jsp" />
        <main id="main-content">
            <div class="container">
                <div class="row">
                    <div class="col-4"></div>
                    <div class="col-4">
                        <h1>Product List</h1>
                    </div>
                    <table class="table table-striped" border="1" column="1">
                        <tr class="table-dark">
                            <th>Product Name</th>
                            <th>Details</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th></th>
                        </tr>
                        <c:forEach var="product" items="${allProducts}">
                            <tr>
                                <td>${product.productName}</td>
                                <td>${product.productDetails}</td>
                                <td>${product.productPrice}</td>
                                <td>
                                    <select id="quantity-field" name="quantity" class="form-control">
                                        <option value="" disabled selected>Select quantity</option>
                                        <% for (int i = 1; i <= 10; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% }%>
                                    </select>
                                </td>
                                <td>
                                    <form action="Private" method="post">
                                        <input type="hidden" name="productID" value="${product.productID}"/>
                                        <input type="hidden" name="action" value="addToCart">
                                        <button type="submit" class="btn btn-success">Add To Cart</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <br>
                    <div class="col-4"></div>
                </div>
            </div>
        </main>
    </body>
</html>
