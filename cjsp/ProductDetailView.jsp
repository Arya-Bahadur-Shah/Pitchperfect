<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.model.ProductModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        background-color: #f0f0f0;
    }

    .jumbotron {
        background-color: #007bff;
        color: white;
        padding: 40px 0;
        text-align: center;
    }

    .container {
        width: 90%;
        margin: auto;
        padding: 20px 0;
    }

    .row {
        display: flex;
        flex-wrap: wrap;
    }

    .col {
        flex: 1;
    }

    .breadcrumb {
        margin: 10px 0;
        list-style: none;
        padding: 0;
        display: flex;
        gap: 5px;
    }

    .breadcrumb-item a {
        color: #007bff;
        text-decoration: none;
    }

    .breadcrumb-item.active a {
        color: #333;
        text-decoration: none;
        pointer-events: none;
    }

    .card {
        background-color: #fff;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    .img-fluid {
        max-width: 100%;
        border-radius: 8px;
    }

    .category-list p {
        margin: 0;
        padding: 8px 0;
        border-bottom: 1px solid #ccc;
        transition: color 0.3s ease;
    }

    .category-list p:hover {
        color: #007bff;
        cursor: pointer;
    }

    .add_to_cart_block h2 {
        margin: 10px 0;
    }

    .price {
        font-size: 18px;
        color: green;
        margin: 10px 0;
    }

    .btn {
        display: inline-block;
        width: 100%;
        padding: 12px;
        background-color: #28a745;
        color: white;
        text-align: center;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
    }

    .btn:hover {
        background-color: #218838;
    }

    .fa-shopping-cart {
        margin-right: 8px;
    }
</style>
</head>
<body>
<%@ include file="Header.jsp" %>

<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading">Product</h1>
    </div>
</section>

<div class="container">
    <div class="row">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=SOTGView.WELCOME_CTL%>">Home</a></li>
                    <li class="breadcrumb-item active"><a href="<%=SOTGView.USER_PRODUCT_LIST_CTL%>">Products</a></li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div style="width: 25%; padding-right: 20px;">
            <div class="card">
                <div class="category-list">
                    <h5><b style="color: #007bff;">Categories</b></h5>
                    <p>Fresh Fruits</p>
                    <p>Vegs</p>
                    <p>Ginger</p>
                </div>
            </div>
        </div>

        <%
            Long productId=(Long)request.getAttribute("ppID"); 
            ProductModel model=new ProductModel();
            ProductBean pBean= model.findByPK(productId);
        %>

        <div style="width: 75%;">
            <div class="row">
                <div style="width: 50%; padding-right: 10px;">
                    <div class="card">
                        <div>
                            <a href="" data-toggle="modal" data-target="#productModal">
                                <img class="img-fluid" src="<%=SOTGView.APP_CONTEXT%>/images/<%=pBean.getImage()%>" />
                            </a>
                        </div>
                    </div>
                </div>

                <div style="width: 50%;">
                    <div class="card">
                        <h2><%=pBean.getName()%></h2>
                        <p class="price"><%=pBean.getPrice()%></p>
                        <p><%=pBean.getDescription()%></p>
                        <form method="get" action="cart.html">
                            <%if(userLoggedIn){%>
                                <%if(userBean.getRoleId()==2){%>
                                    <a href="<%=SOTGView.CART_CTL%>?prodId=<%=pBean.getId()%>" class="btn">
                                        <i class="fa fa-shopping-cart"></i> Add To Cart
                                    </a>
                                <%} %>
                            <%}else{ %>
                                <a href="<%=SOTGView.USER_LOGIN_CTL%>?product=<%=pBean.getName()%>&proIdd=<%=pBean.getId()%>" class="btn">
                                    <i class="fa fa-shopping-cart"></i> Add To Cart
                                </a>
                            <%}%>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
