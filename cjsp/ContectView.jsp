<%@page import="pitchperfect.controller.ContectCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact</title>
    <style>
        body {
            font-family: Arial sans-serif;
            background: #eef2f7;
            margin: 0;
            padding: 0;
        }

        .contact-heading {
           
            color: black;
            text-align: center;
            padding: 40px 20px;
            font-size: 36px;
            font-weight: bold;
           
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            display: flex;
            gap: 30px;
            padding: 20px;
        }

        .info-section, .form-section {
            background: white;
            border: 1px solid #dddddd;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            border-radius: 12px;
        }

        .info-section {
            flex: 1;
        }

        .form-section {
            flex: 2;
        }

        .info-title {
            font-weight: bold;
            font-size: 18px;
            color: #222222;
            margin-top: 20px;
        }

        .info-detail {
            color: #444444;
            margin-top: 10px;
        }

        .form-section input[type="text"],
        .form-section textarea {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            border: 1px solid #cccccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .form-section input[type="submit"] {
            margin-top: 20px;
            padding: 12px 28px;
            font-weight: bold;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .submit-btn {
            background-color: #28a745;
            color: white;
        }

        .reset-btn {
            background-color: #6c757d;
            color: white;
            margin-left: 15px;
        }

        .submit-btn:hover {
            background-color: #218838;
        }

        .reset-btn:hover {
            background-color: #5a6268;
        }

        h2 {
            margin-bottom: 20px;
            color: #333333;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .error-message {
            color: red;
            font-size: 14px;
        }

        .success-message {
            color: green;
            font-size: 14px;
        }
    </style>
</head>
<body>



<div class="container">

    <!-- Contact Info -->
    <div class="info-section">
        <div class="info-title">Call Us</div>
        <div class="info-detail">+97798********</div>
      

        <div class="info-title">Location</div>
        <div class="info-detail">Kathmandu-5, New Baneshwor</div>

        <div class="info-title">Open all day</div>
        

        
    </div>

    <!-- Contact Form -->
    <div class="form-section">
        <h2>Send us a message</h2>

        <font class="error-message"><%=ServletUtility.getErrorMessage(request)%></font>
        <%
            String successMsg = ServletUtility.getSuccessMessage(request);
            if (successMsg != null && !successMsg.trim().isEmpty()) {
        %>
        <script>
            alert("<%= successMsg %>");
        </script>
        <font class="success-message"><%= successMsg %></font>
        <%
            }
        %>

        <form action="<%=SOTGView.CONTECT_CTL%>" method="post">
            <jsp:useBean id="bean" class="pitchperfect.bean.ContectBean" scope="request" />

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

            <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" placeholder="Enter your name" value="<%=DataUtility.getStringData(bean.getName())%>">
                <div class="error-message"><%=ServletUtility.getErrorMessage("name", request)%></div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="text" name="email" placeholder="Enter your email" value="<%=DataUtility.getStringData(bean.getEmail())%>">
                <div class="error-message"><%=ServletUtility.getErrorMessage("email", request)%></div>
            </div>

            <div class="form-group">
                <label>Message</label>
                <textarea name="message" rows="5" placeholder="Type your message"><%=DataUtility.getStringData(bean.getMessage()) %></textarea>
                <div class="error-message"><%=ServletUtility.getErrorMessage("message", request)%></div>
            </div>

            <div style="text-align: center">
                <input type="submit" name="operation" value="<%=ContectCtl.OP_SAVE%>" class="submit-btn">
                <input type="submit" name="operation" value="<%=ContectCtl.OP_RESET%>" class="reset-btn">
            </div>
        </form>
    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
