<%@page import="pitchperfect.controller.CategoryListCtl"%>
<%@page import="pitchperfect.controller.CategoryCtl"%>
<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="pitchperfect.bean.CategoryBean"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CategoryListView</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 0; background-color: #f4f6f8;">

<%@ include file="Header.jsp" %>

<form action="<%=SOTGView.CATEGORY_LIST_CTL%>" method="post">

<!-- Header -->
<div style=" padding: 40px 0; color: black; text-align: center;">
    <h1 style="margin: 0;">Manage Categories</h1>
</div>

<!-- Breadcrumb -->
<div style="padding: 15px 30px; background-color: #ecf0f1; font-size: 14px;">
    <span><a href="<%=SOTGView.HOME_CTL%>" style="color: #27ae60; text-decoration: none;">Home</a> / Categories</span>
</div>

<!-- Category Cards -->
<div style="padding: 30px;">
    <div style="display: flex; flex-wrap: wrap; gap: 30px; justify-content: center;">
        <%
            int pageNo = ServletUtility.getPageNo(request);
            int pageSize = ServletUtility.getPageSize(request);
            int size = (int) request.getAttribute("size");
            int index = ((pageNo - 1) * pageSize) + 1;
            CategoryBean bean = null;
            List list = ServletUtility.getList(request);
            Iterator<CategoryBean> it = list.iterator();

            while (it.hasNext()) {
                bean = it.next();
        %>
        <div style="width: 300px; height: 350px; background-color: white; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.3s;">
            <a href="<%=SOTGView.PRODUCT_LIST_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>">
                <img src="<%=SOTGView.APP_CONTEXT%>/images/<%=bean.getImage()%>" alt="Category Image"
                     style="width: 100%; height: 220px; object-fit: cover;">
            </a>
            <div style="padding: 20px; display: flex; flex-direction: column; justify-content: space-between; ">
                <h2 style="margin: 0 0 10px; font-size: 20px;">
                    <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>"
                       style="color: #2c3e50; text-decoration: none;"><%=bean.getName()%></a>
                </h2>
                <div style="display: flex; justify-content: space-between; gap: 10px;">
                    <a href="<%=SOTGView.CATEGORY_LIST_CTL%>?dId=<%=bean.getId()%>"
                       onclick="return confirm('Are you sure you want to delete this category?');"
                       style="flex: 1; padding: 10px; background-color: #e74c3c; color: white; text-align: center; text-decoration: none; border-radius: 5px;">
                       Delete
                    </a>
                    <a href="<%=SOTGView.CATEGORY_CTL%>?id=<%=bean.getId()%>"
                       style="flex: 1; padding: 10px; background-color: #3498db; color: white; text-align: center; text-decoration: none; border-radius: 5px;">
                       Edit
                    </a>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Pagination & Add -->
    <div style="margin-top: 40px; display: flex; justify-content: space-between; align-items: center;">
        <!-- Pagination Buttons -->
        <div style="display: flex; gap: 10px;">
            <input type="submit" name="operation" value="<%=CategoryListCtl.OP_PREVIOUS%>"
                   <%= (pageNo == 1) ? "disabled" : "" %>
                   style="padding: 10px 20px; background-color: #bdc3c7; border: none; border-radius: 5px; cursor: pointer;">
            <input type="submit" name="operation" value="<%=CategoryListCtl.OP_NEXT%>"
                   <%= ((list.size() < pageSize) || size == pageNo * pageSize) ? "disabled" : "" %>
                   style="padding: 10px 20px; background-color: #bdc3c7; border: none; border-radius: 5px; cursor: pointer;">
        </div>
        <!-- Add Button -->
        <div>
            <a href="<%=SOTGView.CATEGORY_CTL%>"
               style="padding: 12px 25px; background-color: #2ecc71; color: white; text-decoration: none; font-weight: bold; border-radius: 5px;">
               + Add New Category
            </a>
        </div>
    </div>
</div>

</form>

<%@ include file="Footer.jsp" %>
</body>
</html>
