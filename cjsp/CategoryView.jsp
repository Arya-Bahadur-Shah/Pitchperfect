<%@page import="pitchperfect.controller.CategoryCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Categories</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f9f9f9; margin: 0; padding: 0;">

<%@ include file="Header.jsp" %>

<section style="text-align: center; padding: 40px; background-color: #4CAF50; color: white;">
    <div>
        <h1 style="margin: 0;">Categories</h1>
    </div>
</section>

<div style="padding: 20px;">
    <div>
        <nav>
            <ol style="list-style: none; display: flex; padding: 0; background-color: #eee; margin-bottom: 20px; border-radius: 5px;">
                <li style="margin-right: 10px;"><a href="<%=SOTGView.WELCOME_CTL%>" style="text-decoration: none; color: #333;">Home</a> &gt;</li>
                <li style="margin-right: 10px;"><a href="<%=SOTGView.CATEGORY_LIST_CTL%>" style="text-decoration: none; color: #333;">Categories</a> &gt;</li>
                <li><a href="<%=SOTGView.CART_CTL%>" style="text-decoration: none; color: #333;">Add Categories</a></li>
            </ol>
        </nav>
    </div>
</div>

<form action="<%=SOTGView.CATEGORY_CTL%>" method="post" enctype="multipart/form-data">
    <div style="width: 60%; margin: auto; background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.1);">
        <jsp:useBean id="bean" class="pitchperfect.bean.CategoryBean" scope="request" />
        
        <% if(bean.getId() > 0) { %>
            <div style="background-color: #007BFF; padding: 15px; color: white; border-radius: 5px 5px 0 0; font-size: 20px;">Update Categories</div>
        <% } else { %>
            <div style="background-color: #007BFF; padding: 15px; color: white; border-radius: 5px 5px 0 0; font-size: 20px;">Add Categories</div>
        <% } %>

        <div style="color: red; margin-top: 10px;"><%=ServletUtility.getErrorMessage(request)%></div>
        <div style="color: green; margin-bottom: 20px;"><%=ServletUtility.getSuccessMessage(request)%></div>

        <input type="hidden" name="id" value="<%=bean.getId()%>">
        <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
        <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
        <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
        <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

        <div style="margin-bottom: 15px;">
            <label for="name" style="display: block; margin-bottom: 5px;">Name</label>
            <input type="text" name="name" placeholder="Enter Category Name..." value="<%=DataUtility.getStringData(bean.getName())%>" 
                style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
            <div style="color: red;"><%=ServletUtility.getErrorMessage("name", request)%></div>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="photo" style="display: block; margin-bottom: 5px;">Image</label>
            <input type="file" name="photo" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
            <div style="color: red;"><%=ServletUtility.getErrorMessage("photo", request)%></div>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="description" style="display: block; margin-bottom: 5px;">Description</label>
            <textarea name="description" rows="5" placeholder="Enter Description Here.." 
                style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;"><%=DataUtility.getStringData(bean.getDescription())%></textarea>
            <div style="color: red;"><%=ServletUtility.getErrorMessage("description", request)%></div>
        </div>

        <div style="text-align: center; margin-top: 20px;">
            <input type="submit" name="operation" value="<%=CategoryCtl.OP_SAVE%>" 
                style="padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer;">
            <% if(bean.getId() > 0) { %>
                <input type="submit" name="operation" value="<%=CategoryCtl.OP_CANCEL%>" 
                    style="padding: 10px 20px; background-color: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px;">
            <% } else { %>
                <input type="submit" name="operation" value="<%=CategoryCtl.OP_RESET%>" 
                    style="padding: 10px 20px; background-color: #ffc107; color: black; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px;">
            <% } %>
        </div>
    </div>
</form>

<br>
<%@ include file="Footer.jsp" %>
</body>
</html>
