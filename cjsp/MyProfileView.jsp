<%@page import="pitchperfect.controller.MyProfileCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body style="font-family: Arial, sans-serif; background-color: #eef1f5; margin: 0; padding: 0;">

<%@ include file="Header.jsp" %>



<div style="padding: 20px 40px;">
    <ol style="list-style: none; padding: 0; margin: 0 0 20px;">
        <li style="display: inline;"><a href="<%=SOTGView.WELCOME_CTL%>" style="color: #4CAF50; text-decoration: none;">Home</a> &gt; </li>
        <li style="display: inline; color: #777;">My Profile</li>
    </ol>
</div>

<!-- Centered form container -->
<div style="max-width: 600px; margin: 0 auto; background: white; border-radius: 10px; box-shadow: 0px 0px 15px rgba(0,0,0,0.1); padding: 30px;">

    <div style="text-align: center; margin-bottom: 20px;">
        <h2 style="color: #4CAF50;">Update Your Profile</h2>
    </div>

    <div style="padding: 10px;">
        <font color="red"><%=ServletUtility.getErrorMessage(request)%></font><br>
        <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>

        <form action="<%=SOTGView.MY_PROFILE_CTL%>" method="post">
            <jsp:useBean id="bean" class="pitchperfect.bean.UserBean" scope="request" />

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

            <!-- Input group -->
            <div style="margin-bottom: 15px;">
                <label><strong>First Name</strong></label><br>
                <input type="text" name="firstName" placeholder="Enter First Name" 
                    value="<%=DataUtility.getStringData(bean.getFirstName())%>"
                    style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;">
                <font color="red"><%=ServletUtility.getErrorMessage("firstName", request)%></font>
            </div>

            <div style="margin-bottom: 15px;">
                <label><strong>Last Name</strong></label><br>
                <input type="text" name="lastName" placeholder="Enter Last Name" 
                    value="<%=DataUtility.getStringData(bean.getLastName())%>"
                    style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;">
                <font color="red"><%=ServletUtility.getErrorMessage("lastName", request)%></font>
            </div>

            <div style="margin-bottom: 15px;">
                <label><strong>Login ID</strong></label><br>
                <input type="text" name="login" placeholder="Enter Login ID" 
                    value="<%=DataUtility.getStringData(bean.getLogin())%>"
                    style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;">
                <font color="red"><%=ServletUtility.getErrorMessage("login", request)%></font>
            </div>

            <div style="margin-bottom: 15px;">
                <label><strong>Email Address</strong></label><br>
                <input type="text" name="email" placeholder="Enter Email" 
                    value="<%=DataUtility.getStringData(bean.getLogin())%>"
                    style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;">
                <font color="red"><%=ServletUtility.getErrorMessage("email", request)%></font>
            </div>

            <div style="margin-bottom: 15px;">
                <label><strong>Mobile No.</strong></label><br>
                <input type="text" name="mobile" placeholder="Enter 10-digit Mobile No." 
                    value="<%=DataUtility.getStringData(bean.getMobileNo())%>"
                    style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;">
                <font color="red"><%=ServletUtility.getErrorMessage("mobile", request)%></font>
            </div>

            <% if(userBean.getRoleId() == 2) { %>
                <div style="margin-bottom: 15px;">
                    <label><strong>Shipping Address</strong></label><br>
                    <textarea name="shippingAdd" rows="3" placeholder="Address to be Delivered"
                        style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;"><%=DataUtility.getStringData(bean.getShippingAddress())%></textarea>
                    <font color="red"><%=ServletUtility.getErrorMessage("shippingAdd", request)%></font>
                </div>

                <div style="margin-bottom: 15px;">
                    <label><strong>Billing Address</strong></label><br>
                    <textarea name="billingAdd" rows="3" placeholder="Payment Address"
                        style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;"><%=DataUtility.getStringData(bean.getBillingAddress())%></textarea>
                    <font color="red"><%=ServletUtility.getErrorMessage("billingAdd", request)%></font>
                </div>
            <%}%>

            <!-- Buttons -->
            <div style="text-align: center; margin-top: 25px;">
                <input type="submit" name="operation" value="<%=MyProfileCtl.OP_SAVE%>"
                    style="background-color: #4CAF50; color: white; padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; margin-right: 10px;">
                <input type="submit" name="operation" value="<%=MyProfileCtl.OP_CHANGE_MY_PASSWORD%>"
                    style="background-color: #2196F3; color: white; padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer;">
            </div>
        </form>
    </div>
</div>

<br><br>
<%@ include file="Footer.jsp" %>
</body>
</html>
