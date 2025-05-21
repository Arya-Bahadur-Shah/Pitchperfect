<%@page import="pitchperfect.controller.AdminCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="pitchperfect.bean.UserBean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminView</title>
<style>
   
    .jumbotron {
        background-color: #2c3e50;
        color: white;
        padding: 40px 0;
        text-align: center;
    }
    .container {
        width: 80%;
        margin: auto;
        padding-top: 20px;
    }
    .breadcrumb {
        list-style: none;
        display: flex;
        background-color: transparent;
        padding: 0;
        margin: 0 0 20px 0;
    }
    .breadcrumb li {
        margin-right: 10px;
    }
    .breadcrumb li a {
        text-decoration: none;
        color: #3498db;
    }
    .breadcrumb li.active a {
        font-weight: bold;
    }
    body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', sans-serif;
        background-color: #f5f5f5;
        min-height: 100vh;
       
        justify:center;
        items:center;
       
    }

    .form-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: calc(100vh - 100px); /* Adjust if footer/header exists */
        margin-left:200px;
    }

    .card {
        background-color: #6dbf57;
        width: 100%;
        max-width: 400px;
        padding: 40px 30px;
        border-radius: 20px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4);
        color: white;
    }

    .card-header {
        font-size: 24px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 30px;
    }

    .form-group {
        margin-bottom: 20px;
display:flex;
items:center;
justify:center;

    }

    .form-group label {
        display: none;
    }

    .form-control {
        width: 100%;
        padding: 12px 15px;
        border: none;
        border-radius: 10px;
        font-size: 14px;
        background-color: #f0f0f0;
        color: #333;
    }

    .form-control::placeholder {
        color: #aaa;
    }

    .btn {
        width: 100%;
        padding: 12px;
        background-color: #6c5ce7;
        color: white;
        font-weight: bold;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s ease;
        margin-bottom: 10px;
    }

    .btn:hover {
        background-color: #5a4bcf;
    }

    .text-red {
        color: #ff7675;
        font-size: 12px;
        margin-top: 4px;
    }

    .text-green {
        color: #55efc4;
        font-size: 12px;
        text-align: center;
    }

    @media screen and (max-width: 480px) {
        .card {
            padding: 30px 20px;
        }
    }
</style>


   
</style>
</head>
<body>
<%@ include file="Header.jsp" %>


<div class="container">
    <ul class="breadcrumb">
        <li><a href="<%=SOTGView.HOME_CTL%>">Home</a></li>
        <li class="active"><a href="<%=SOTGView.ADMIN_CTL%>">Add Admin</a></li>
    </ul>

    <form action="<%=SOTGView.ADMIN_CTL%>" method="post">
        <jsp:useBean id="bean" class="pitchperfect.bean.UserBean" scope="request" />

        <div class="card">
            <% if(bean.getId() > 0){ %>
            <div class="card-header">Update Admin</div>
            <% } else { %>
            <div class="card-header">Add Admin</div>
            <% } %>

            <div class="text-red"><%=ServletUtility.getErrorMessage(request)%></div>
            <div class="text-green"><%=ServletUtility.getSuccessMessage(request)%></div>

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

            <div class="form-group">
                <label>First Name</label>
                <input type="text" class="form-control" name="firstName" placeholder="Enter First Name..." 
                    value="<%=DataUtility.getStringData(bean.getFirstName())%>">
                <div class="text-red"><%=ServletUtility.getErrorMessage("firstName", request)%></div>
            </div>

            <div class="form-group">
                <label>Last Name</label>
                <input type="text" class="form-control" name="lastName" placeholder="Enter Last Name..." 
                    value="<%=DataUtility.getStringData(bean.getLastName())%>">
                <div class="text-red"><%=ServletUtility.getErrorMessage("lastName", request)%></div>
            </div>

            <div class="form-group">
                <label>Login Id</label>
                <input type="text" class="form-control" name="login" placeholder="Enter Login Id..." 
                    value="<%=DataUtility.getStringData(bean.getLogin())%>">
                <div class="text-red"><%=ServletUtility.getErrorMessage("login", request)%></div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" class="form-control" name="password" placeholder="Enter Password Here..." 
                    value="<%=DataUtility.getStringData(bean.getPassword())%>">
                <div class="text-red"><%=ServletUtility.getErrorMessage("password", request)%></div>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" class="form-control" name="confirmPassword" placeholder="ReEnter Password Here..." 
                    value="<%=DataUtility.getStringData(bean.getConfirmPassword())%>">
                <div class="text-red"><%=ServletUtility.getErrorMessage("confirmPassword", request)%></div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="text" class="form-control" name="email" placeholder="Enter Email Address..." 
                    value="<%=DataUtility.getStringData(bean.getLogin())%>">
                <div class="text-red"><%=ServletUtility.getErrorMessage("email", request)%></div>
            </div>

            <div class="form-group">
                <label>Mobile No.</label>
                <input type="text" class="form-control" name="mobile" placeholder="Enter 10 Digits Mobile No." 
                    value="<%=DataUtility.getStringData(bean.getMobileNo())%>">
                <div class="text-red"><%=ServletUtility.getErrorMessage("mobile", request)%></div>
            </div>

            <div class="mx-auto">
                <input type="submit" name="operation" class="btn" value="<%=AdminCtl.OP_SAVE%>">
                <% if(bean.getId() > 0){ %>
                <input type="submit" name="operation" class="btn" value="<%=AdminCtl.OP_CANCEL%>">
                <% } else { %>
                <input type="submit" name="operation" class="btn" value="<%=AdminCtl.OP_RESET%>">
                <% } %>
            </div>
        </div>
    </form>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
