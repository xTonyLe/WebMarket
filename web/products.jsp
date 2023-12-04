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
        <jsp:include page="layout/navbar.jsp" />
        <main id="main-content">
            <br>
            <div class="container">
                <div class="row">
                    <div class="col-4"></div>
                    <div class="col-4">
                        <h1>Product List</h1>
                        <br>
                    </div>
                    <c:if test="${empty allProducts}"><h5 class="text-secondary">No products currently.</h5></c:if>
                    <c:if test="${not empty allProducts}">
                    <table class="table table-striped table-bordered">
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
                                <td>$${product.productPrice}</td>
                            <form action="Private" method="post">
                                <td style="width:11.2%">
                                    <select id="quantity" name="quantity" class="form-control">
                                        <option value="" disabled selected>Select quantity</option>
                                        <% for (int i = 1; i <= 10; i++) {%>
                                        <option value="<%= i%>"><%= i%></option>
                                        <% }%>
                                    </select>
                                </td>
                                <td style="width:9.6%">
                                    <input type="hidden" name="productID" value="${product.productID}"/>
                                    <input type="hidden" name="action" value="addToCart">
                                    <button type="submit" class="btn btn-success">Add To Cart</button>

                                </td>
                            </form>
                            </tr>
                        </c:forEach>
                    </table>
                    </c:if>
                    <br>
                    <div class="col-4"></div>
                </div>
            </div>
        </main>
    </body>
</html>
