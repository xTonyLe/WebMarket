<%-- 
    Document   : adminAllUsers
    Created on : Dec 3, 2023, 12:52:41 PM
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
        <title>Web Market - Admin User List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <style>
            .container {
                text-align: center;
            }
            table {
                margin: 0 auto;
            }
            .bold-username {
                font-weight: bold;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="/layout/navbar.jsp" />
        <main id="main-content">
            <br>
            <div class="container">
                <div class="row">
                    <div class="col-4"></div>
                    <div class="col-4">
                        <h1>Users Registered</h1>
                        <br>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr class="table-dark">
                                    <th>Username</th>
                                    <th>User Type</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <c:forEach var="user" items="${allUsers}">
                                        <td class="bold-username">${user.value.username}</td>
                                        <td class="bold-username">${user.value.userType}</td>
                                        <td style="width:30.5%">
                                            <form action="Private" method="post">
                                                <input type="hidden" name="userID" value="${user.value.userID}"/>
                                                <input type="hidden" name="action" value="adminDeleteUser" class="form-control"/>
                                                <button type="submit" class="btn btn-danger">Delete User</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>                  
                </div>
            </div>
        </main>
    </body>
</html>
