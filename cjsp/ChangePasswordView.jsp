<%@page import="pitchperfect.controller.ChangePasswordCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="pitchperfect.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Password View</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0;">
<%@ include file="Header.jsp" %>

<section style="background-color: #4CAF50; color: white; padding: 30px; text-align: center;">
    <h1>Change Password</h1>
</section>

<div style="width: 80%; margin: 20px auto; padding: 20px; background-color: white; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <nav>
        <ol style="list-style: none; padding: 0; margin: 0;">
            <li style="display: inline; margin-right: 10px;"><a href="<%=SOTGView.WELCOME_CTL%>" style="color: #4CAF50; text-decoration: none;">Home</a></li>
            <li style="display: inline; margin-right: 10px;">&gt;</li>
            <li style="display: inline; margin-right: 10px;"><a href="<%=SOTGView.MY_PROFILE_CTL%>" style="color: #4CAF50; text-decoration: none;">My Profile</a></li>
            <li style="display: inline; margin-right: 10px;">&gt;</li>
            <li style="display: inline; color: #4CAF50;">Change Password</li>
        </ol>
    </nav>

    <div style="margin-top: 20px;">
        <font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
        <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>

        <div style="padding: 20px;">
            <form action="<%=SOTGView.CHANGE_PASSWORD_CTL%>" method="post">

                <jsp:useBean id="bean" class="pitchperfect.bean.UserBean" scope="request"></jsp:useBean>
                <input type="hidden" name="id" value="<%=bean.getId()%>">
                <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
                <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
                <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
                <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

                <div style="margin-bottom: 20px;">
                    <label for="oldPassword" style="font-size: 16px; font-weight: bold; color: #333;">Old Password</label>
                    <input type="password" name="oldPassword" placeholder="Enter Old Password Here.." 
                        value="<%=DataUtility.getString(request.getParameter("oldPassword") == null ? "" : DataUtility.getString(request.getParameter("oldPassword")))%>"
                        style="width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px;">
                    <font color="red"><%=ServletUtility.getErrorMessage("oldPassword", request)%></font>
                </div>

                <div style="margin-bottom: 20px;">
                    <label for="newPassword" style="font-size: 16px; font-weight: bold; color: #333;">New Password</label>
                    <input type="password" name="newPassword" placeholder="Enter New Password Here.." 
                        value="<%=DataUtility.getString(request.getParameter("newPassword") == null ? "" : DataUtility.getString(request.getParameter("newPassword")))%>"
                        style="width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px;">
                    <font color="red"><%=ServletUtility.getErrorMessage("newPassword", request)%></font>
                </div>

                <div style="margin-bottom: 20px;">
                    <label for="confirmPassword" style="font-size: 16px; font-weight: bold; color: #333;">Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="ReEnter Password Here.." 
                        value="<%=DataUtility.getString(request.getParameter("confirmPassword") == null ? "" : DataUtility.getString(request.getParameter("confirmPassword")))%>"
                        style="width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px;">
                    <font color="red"><%=ServletUtility.getErrorMessage("confirmPassword", request)%></font>
                </div>

                <div style="text-align: center;">
                    <input type="submit" name="operation" value="<%=ChangePasswordCtl.OP_SAVE%>" 
                        style="background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin-right: 10px;">
                    <input type="submit" name="operation" value="<%=ChangePasswordCtl.OP_CHANGE_MY_PROFILE%>" 
                        style="background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="Footer.jsp" %>

</body>
</html>
