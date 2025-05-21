<%@page import="pitchperfect.controller.UserRegistrationCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@ page import="pitchperfect.controller.SOTGView" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ include file="Header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
        }

        .main-body {
            min-height: calc(100vh - 120px); /* leave space for header & footer */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            display: flex;
            width: 90%;
            max-width: 1000px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            overflow: hidden;
        }

        .left-panel {
            background-color: #6dbf57;
            color: white;
            width: 40%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .left-panel h2 {
            font-size: 36px;
            text-align: center;
        }

        .left-panel form {
            margin-top: 30px;
        }

        .left-panel .signin-btn {
            background-color: transparent;
            color: white;
            border: 2px solid white;
            padding: 10px 30px;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .left-panel .signin-btn:hover {
            background-color: white;
            color: #9b8ce2;
        }

        .form-panel {
            background-color: white;
            width: 60%;
            padding: 40px;
        }

        .form-panel h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-panel form {
            display: flex;
            flex-direction: column;
        }

        .form-panel label {
            margin-top: 10px;
            font-weight: 600;
        }

        .form-panel input,
        .form-panel textarea {
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-signup {
            background-color: #6a1b9a;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
        }

        .btn-reset {
            background-color: #999;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
        }

        .messages {
            text-align: center;
            margin-bottom: 10px;
        }

        .messages font {
            display: block;
        }

    </style>
</head>
<body>

<div class="main-body">
    <div class="container">
        <!-- Left Side -->
        <div class="left-panel">
            <h2>Welcome Back!</h2>
            <p>To keep connected with us please login with your personal info</p>
            <form action="<%=SOTGView.LOGIN_CTL%>">
                <button type="submit" class="signin-btn">SIGN IN</button>
            </form>
        </div>

        <!-- Right Side (Form) -->
        <div class="form-panel">
            <h2>Create Account</h2>

            <div class="messages">
                <font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
                <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
            </div>

            <form action="<%=SOTGView.USER_REGISTRATION_CTL%>" method="post">
                <jsp:useBean id="bean" class="pitchperfect.bean.UserBean" scope="request"/>

                <input type="hidden" name="id" value="<%=bean.getId()%>">
                <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
                <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
                <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
                <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

                <label>First Name</label>
                <input type="text" name="firstName" value="<%=DataUtility.getStringData(bean.getFirstName())%>">
                <font color="red"><%=ServletUtility.getErrorMessage("firstName", request)%></font>

                <label>Last Name</label>
                <input type="text" name="lastName" value="<%=DataUtility.getStringData(bean.getLastName())%>">
                <font color="red"><%=ServletUtility.getErrorMessage("lastName", request)%></font>

                <label>Login Id</label>
                <input type="text" name="login" value="<%=DataUtility.getStringData(bean.getLogin())%>">
                <font color="red"><%=ServletUtility.getErrorMessage("login", request)%></font>

                <label>Password</label>
                <input type="password" name="password" value="<%=DataUtility.getStringData(bean.getPassword())%>">
                <font color="red"><%=ServletUtility.getErrorMessage("password", request)%></font>

                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" value="<%=DataUtility.getStringData(bean.getConfirmPassword())%>">
                <font color="red"><%=ServletUtility.getErrorMessage("confirmPassword", request)%></font>

                <label>Email</label>
                <input type="text" name="email" value="<%=DataUtility.getStringData(bean.getLogin())%>">
                <font color="red"><%=ServletUtility.getErrorMessage("email", request)%></font>

                <label>Mobile No.</label>
                <input type="text" name="mobile" value="<%=DataUtility.getStringData(bean.getMobileNo())%>">
                <font color="red"><%=ServletUtility.getErrorMessage("mobile", request)%></font>

                <label>Shipping Address</label>
                <textarea name="shippingAdd"><%=DataUtility.getStringData(bean.getShippingAddress())%></textarea>
                <font color="red"><%=ServletUtility.getErrorMessage("shippingAdd", request)%></font>

                <label>Billing Address</label>
                <textarea name="billingAdd"><%=DataUtility.getStringData(bean.getBillingAddress())%></textarea>
                <font color="red"><%=ServletUtility.getErrorMessage("billingAdd", request)%></font>

                <div class="btn-group">
                    <input type="submit" name="operation" value="<%=UserRegistrationCtl.OP_SIGN_UP%>" class="btn-signup">
                    <input type="submit" name="operation" value="<%=UserRegistrationCtl.OP_RESET%>" class="btn-reset">
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
