<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="pitchperfect.controller.UserProductCtl"%>
<%@page import="java.util.List"%>
<%@page import="pitchperfect.bean.CartBean"%>
<%@page import="pitchperfect.model.CartModel"%>
<%@page import="pitchperfect.controller.LoginCtl"%>
<%@page import="pitchperfect.controller.SOTGView"%>
<%@page import="pitchperfect.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Pitchperfect</title>
    <link href="/PitchPerfect/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        nav {
            background-color: white;
            padding: 20px 0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        nav a {
            color: black;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        nav a:hover {
            background-color: #17a2b8;
            color: white;
        }

        .navbar-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            flex-wrap: wrap;
        }

        .navbar-menu {
            list-style: none;
            display: flex;
            align-items: center;
            margin: 0;
            padding: 0;
        }

        .navbar-menu li {
            margin: 0 10px;
        }

        .navbar-search input[type="text"] {
            padding: 10px;
            font-size: 14px;
            width: 150px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .navbar-search input[type="submit"] {
            background-color: #17a2b8;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .navbar-button, .cart-icon {
            background-color: #28a745;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            font-size: 14px;
        }

        .navbar-button:hover, .cart-icon:hover {
            background-color: #218838;
        }

        .right-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-logo {
            font-size: 20px;
            color: black;
            text-decoration: none;
            margin-right: 20px;
        }

        .navbar-logo span {
            font-size: 13px;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function(){
        $('.quantity-right-plus').click(function(e){
            e.preventDefault();
            var quantity = parseInt($('#quantity').val());
            $('#quantity').val(quantity + 1);
        });

        $('.quantity-left-minus').click(function(e){
            e.preventDefault();
            var quantity = parseInt($('#quantity').val());
            if(quantity > 1){
                $('#quantity').val(quantity - 1);
            }
        });
    });
    </script>
</head>
<body>

<%
    UserBean userBean = (UserBean) session.getAttribute("user");
    boolean userLoggedIn = userBean != null;
%>

<nav>
    <div class="navbar-container">
        <!-- Logo -->
        <img src="/PitchPerfect/images/logo.jpg" alt="Logo" style="height:50px;width:150px">

        <!-- Menu -->
        <ul class="navbar-menu">
            <% if(userLoggedIn){ %>
                <% if(userBean.getRoleId() == 1){ %>
                    <li><a href="<%=SOTGView.HOME_CTL%>">Home</a></li>
                    <li><a href="<%=SOTGView.ADMIN_CTL%>">Add Admin</a></li>
                    <li><a href="<%=SOTGView.CATEGORY_LIST_CTL%>">Categories</a></li>
                    <li><a href="<%=SOTGView.PRODUCT_LIST_CTL%>">Product</a></li>
                    <li><a href="/PitchPerfect/ctl/CourtBookingCtl?operation=list">Bookings</a></li>
                <% } else if(userBean.getRoleId() == 2){ %>
                    <li><a href="<%=SOTGView.HOME_CTL%>">Home</a></li>
                    <li><a href="<%=SOTGView.USER_PRODUCT_LIST_CTL%>">Product</a></li>
                    <li><a href="/PitchPerfect/ctl/CourtBookingCtl?operation=list">Bookings</a></li>
                    <li><a href="/PitchPerfect/cjsp/AboutUsView.jsp">About Us</a></li>
                    <li><a href="/PitchPerfect/contact">Contact Us</a></li>
                <% } %>
            <% } else { %>
                <li><a href="<%=SOTGView.HOME_CTL%>">Home</a></li>
                <li><a href="<%=SOTGView.USER_PRODUCT_LIST_CTL%>">Product</a></li>
                <li><a href="/PitchPerfect/cjsp/AboutUsView.jsp">About Us</a></li>
                <li><a href="/PitchPerfect/contact">Contact Us</a></li>
            <% } %>
        </ul>

        <!-- Right Section (Search + Icons) -->
        <div class="right-section">

            <form action="<%=SOTGView.USER_PRODUCT_LIST_CTL%>" method="post" class="navbar-search">
                <input type="text" name="name" placeholder="Search Product..." value="<%=ServletUtility.getParameter("name", request)%>">
                <input type="submit" name="operation" value="<%=UserProductCtl.OP_SEARCH%>">
            </form>

            <% if(userLoggedIn) { %>
                <% if(userBean.getRoleId() == 2) {
                    CartModel cModel = new CartModel();
                    CartBean cBean = new CartBean();
                    cBean.setUserId(userBean.getId());
                    List list = cModel.search(cBean);
                %>
                    <a href="<%=SOTGView.CART_LIST_CTL%>" class="cart-icon" title="Cart">
                        <i class="fas fa-shopping-cart"></i> <span><%=list.size()%></span>
                    </a>
                <% } %>

                <a href="<%=SOTGView.MY_PROFILE_CTL%>" class="navbar-button" title="Profile">
                    <i class="fas fa-user"></i>
                </a>
                <a href="<%=SOTGView.LOGIN_CTL%>?operation=<%=LoginCtl.OP_LOG_OUT%>" class="navbar-button" title="Logout">
                    <i class="fas fa-sign-out-alt"></i>
                </a>
            <% } else { %>
                <a href="<%=SOTGView.LOGIN_CTL%>" class="navbar-button" title="Login">
                    <i class="fas fa-sign-in-alt"></i>
                </a>
                <a href="<%=SOTGView.USER_REGISTRATION_CTL%>" class="navbar-button" title="Register">
                    <i class="fas fa-user-plus"></i>
                </a>
            <% } %>
        </div>
    </div>
</nav>

</body>
</html>
