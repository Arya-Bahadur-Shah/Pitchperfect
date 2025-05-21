<%@page import="pitchperfect.controller.ProductCtl"%>
<%@page import="pitchperfect.util.HTMLUtility"%>
<%@page import="java.util.List"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="pitchperfect.util.ServletUtility"%>
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
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
    }

    .jumbotron {
       
        color: white;
        padding: 30px 0;
        text-align: center;
    }

    .container {
        width: 90%;
        margin: 20px auto;
    }

    .breadcrumb {
        list-style: none;
        display: flex;
        padding: 0;
        gap: 5px;
    }

    .breadcrumb-item a {
        text-decoration: none;
        color: #007bff;
    }

    .breadcrumb-item.active a {
        color: #333;
        pointer-events: none;
    }

    .card {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }

    .card-header {
        font-size: 18px;
        font-weight: bold;
        background-color: #007bff;
        color: white;
        padding: 10px;
        border-radius: 5px 5px 0 0;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        margin-bottom: 6px;
        font-weight: bold;
    }

    .form-control {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    textarea.form-control {
        resize: vertical;
    }

    .btn {
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        font-weight: bold;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 10px;
    }

    .btn:hover {
        background-color: #0056b3;
    }

    .mx-auto {
        text-align: center;
        margin-top: 20px;
    }

    font[color="red"], font[color="green"] {
        display: block;
        margin-top: 5px;
    }
</style>
</head>
<body>
<%@ include file="Header.jsp" %>

<section class="jumbotron">
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
                    <li class="breadcrumb-item"><a href="<%=SOTGView.PRODUCT_LIST_CTL%>">Product</a></li>
                    <li class="breadcrumb-item active"><a href="<%=SOTGView.PRODUCT_CTL%>">Add Product</a></li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<form action="<%=SOTGView.PRODUCT_CTL%>" method="post" enctype="multipart/form-data">
<div class="container">
    <div class="row">
        <div class="col">
            <div class="card">
                <jsp:useBean id="bean" class="pitchperfect.bean.ProductBean" scope="request"></jsp:useBean>
                <% if(bean.getId()>0){ %>
                    <div class="card-header">Update Product</div>
                <% } else { %>
                    <div class="card-header">Add Product</div>
                <% } %>

                <font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
                <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>

                <div class="card-body">
                    <input type="hidden" name="id" value="<%=bean.getId()%>">
                    <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
                    <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
                    <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
                    <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

                    <% List li=(List)request.getAttribute("catList"); %>

                    <div class="form-group">
                        <label for="name">Category Name</label>
                        <%=HTMLUtility.getList("categoryId", String.valueOf(bean.getCategoryId()), li)%>
                        <font color="red"><%=ServletUtility.getErrorMessage("categoryId", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" name="name" placeholder="Enter Product Name..." value="<%=DataUtility.getStringData(bean.getName())%>">
                        <font color="red"><%=ServletUtility.getErrorMessage("name", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="name">Price</label>
                        <input type="text" class="form-control" name="price" placeholder="Enter Product Price..." value="<%=(bean.getPrice()>0.0)?bean.getPrice():""%>">
                        <font color="red"><%=ServletUtility.getErrorMessage("price", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="name">Image</label>
                        <input type="file" class="form-control" name="photo" placeholder="Upload Image Here..." value="<%=DataUtility.getStringData(bean.getImage())%>">
                        <font color="red"><%=ServletUtility.getErrorMessage("photo", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="message">Description</label>
                        <textarea rows="5" class="form-control" name="description" placeholder="Enter Product Description Here..."><%=DataUtility.getStringData(bean.getDescription())%></textarea>
                        <font color="red"><%=ServletUtility.getErrorMessage("description", request)%></font>
                    </div>

                    <div class="mx-auto">
                        <input type="submit" name="operation" class="btn" value="<%=ProductCtl.OP_SAVE%>">
                        <% if(bean.getId()>0){ %>
                            <input type="submit" name="operation" class="btn" value="<%=ProductCtl.OP_CANCEL%>">
                        <% } else { %>
                            <input type="submit" name="operation" class="btn" value="<%=ProductCtl.OP_RESET%>">
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</form>

<br>
<%@ include file="Footer.jsp" %>
</body>
</html>
