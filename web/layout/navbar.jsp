<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<a href="#main-content" class="visually-hidden-focusable">Skip to Main Content</a>

<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">Web Market</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#web-market-navbar" aria-controls="web-market-navbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="web-market-navbar">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item text-dark">
                    <a href="index.jsp" class="nav-link text-dark">Home</a>
                </li>
                <c:if test="${loggedInUser.userType eq 'admin'}">
                    <!-- Begin Admin Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Admin
                        </a>
                        <ul class="dropdown-menu">
                            <li class="dropdown-item">
                                <a href="Private?action=productListAdmin" class="nav-link text-dark">Admin Products</a>
                            </li>
                            <li class="dropdown-item">
                                <a href="Private?action=orderListAdmin" class="nav-link text-dark">Admin Orders</a>
                            </li>
                            <li class="dropdown-item">
                                <a href="Private?action=adminUserAction" class="nav-link text-dark">Admin Users</a>
                            </li>
                        </ul>
                    </li>
                    <!-- End Admin Dropdown -->
                </c:if>
                <c:if test="${not empty loggedInUser || loggedInUser != null}">
                    <li class="nav-item">
                        <a href="Private?action=productList" class="nav-link text-dark">Products</a>
                    </li>
                    <li class="nav-item">
                        <a href="Private?action=cartItems" class="nav-link text-dark">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a href="Private?action=orderList" class="nav-link text-dark">User Page</a>
                    </li>
                    <form action="Private" method="post">
                        <input type="hidden" value="logout" name="action" />
                        <button role="link" type="submit" class="nav-link text-dark">Log Out</button>
                    </form>
                    </li>
                </c:if>
                <c:if test="${empty sessionScope.loggedInUser}">
                    <li class="nav-item">
                        <a href="register.jsp" class="nav-link text-dark">Register</a>
                    </li>
                    <li class="nav-item">
                        <a href="login.jsp" class="nav-link text-dark">Log In</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
</header>