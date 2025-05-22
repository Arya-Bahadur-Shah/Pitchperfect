<%@page import="pitchperfect.controller.UserLoginCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="pitchperfect.controller.SOTGView"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login - PitchPerfect</title>
</head>
<%@ include file="Header.jsp" %>
<body style="margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #ffffff;">



<!-- Wrapper -->
<div style="display: flex; height: 100vh;">

    <!-- Left Panel (Welcome Back) -->
    <div style="flex: 1; background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%); display: flex; flex-direction: column; justify-content: center; align-items: center; color: white;">
        <div style="text-align: center;">
            <h1 style="font-size: 48px; margin: 0;">Welcome<br>Back!</h1>
        </div>
    </div>

    <!-- Right Panel (Login Form) -->
    <div style="flex: 1; display: flex; justify-content: center; align-items: center; background: #f9f9f9;">
        <div style="width: 100%; max-width: 400px; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
            
            <h2 style="margin-bottom: 10px;">Login</h2>
            <p style="margin-top: 0; color: #777;">Welcome back! Please login to your account.</p>

            <span style="color: red; font-size: 14px;"><%=ServletUtility.getErrorMessage(request)%></span><br>
            <span style="color: green; font-size: 14px;"><%=ServletUtility.getSuccessMessage(request)%></span>

            <form action="<%=SOTGView.LOGIN_CTL%>" method="post" style="margin-top: 20px;">
                <jsp:useBean id="bean" class="pitchperfect.bean.UserBean" scope="request" />
                <% String uri = (String) request.getAttribute("uri"); %>

                <input type="hidden" name="uri" value="<%=uri%>">
                <input type="hidden" name="id" value="<%=bean.getId()%>">
                <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
                <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
                <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
                <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

                <!-- Email -->
                <div style="margin-bottom: 15px;">
                    <label for="email" style="font-weight: 600;">User Name</label>
                    <input type="text" name="login" placeholder="username@gmail.com"
                           value="<%=DataUtility.getStringData(bean.getLogin())%>"
                           style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px;">
                    <div style="color: red; font-size: 13px;"><%=ServletUtility.getErrorMessage("login", request)%></div>
                </div>

                <!-- Password -->
                <div style="margin-bottom: 15px;">
                    <label for="password" style="font-weight: 600;">Password</label>
                    <input type="password" name="password" placeholder="********"
                           value="<%=DataUtility.getStringData(bean.getPassword())%>"
                           style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px;">
                    <div style="color: red; font-size: 13px;"><%=ServletUtility.getErrorMessage("password", request)%></div>
                </div>

                <!-- Remember Me + Forgot -->
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 14px; margin-bottom: 20px;">
                    <label>
                        <input type="checkbox" style="margin-right: 6px;"> Remember Me
                    </label>
                    <a href="<%=SOTGView.FORGET_PASSWORD_CTL%>" style="text-decoration: none; color: #888;">Forgot Password?</a>
                </div>

                <!-- Login Button -->
                <div style="text-align: center;">
                    <input type="submit" name="operation" value="<%=UserLoginCtl.OP_SIGN_IN%>"
                           style="background-color: #7b2ff7; color: white; width: 100%; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px;">
                </div>

                <!-- Sign up Link -->
                <div style="text-align: center; margin-top: 15px; font-size: 14px;">
                    New User? 
                    <input type="submit" name="operation" value="<%=UserLoginCtl.OP_SIGN_UP%>"
                           style="background: none; border: none; color: #7b2ff7; font-weight: bold; cursor: pointer; padding: 0;">
                </div>
            </form>
        </div>
    </div>
</div>


</body>

<%@ include file="Footer.jsp" %>
</html>
