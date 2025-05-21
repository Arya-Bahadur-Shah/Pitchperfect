<%@page import="pitchperfect.controller.ProductListCtl"%>
<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="pitchperfect.bean.CategoryBean"%>
<%@page import="pitchperfect.model.CategoryModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product</title>
<style>
    .category-link {
        text-decoration: none;
        color: #333;
        display: block;
        padding: 8px 0;
        border-bottom: 1px solid #ccc;
        transition: background-color 0.2s, color 0.2s;
    }
    .category-link:hover {
        background-color: blue;
        color: white;
    }
</style>
</head>
<body style="margin: 0; font-family: Arial, sans-serif; background-color: #f9f9f9;">
<%@ include file="Header.jsp" %>



<div style="padding: 20px;">
    <div style="margin-bottom: 20px;">
        <div>
            <ul style="list-style: none; padding: 0; display: flex; gap: 10px;">
                <li><a href="<%=SOTGView.HOME_CTL%>" style="text-decoration: none; color: #007bff;">Home</a></li>
                <li><a href="<%=SOTGView.PRODUCT_LIST_CTL%>" style="text-decoration: none; color: #555;">Product</a></li>
            </ul>
        </div>
    </div>

    <div style="display: flex;">
        <!-- Sidebar -->
        <div style="width: 25%; margin-right: 20px;">
            <div style="background-color: #e9ecef; padding: 15px; border-radius: 5px;">
                <h3 style="margin: 0 0 10px; color: #007bff;">Categories</h3>
                <ul style="list-style: none; padding: 0;">
                <% 
                    CategoryModel cModel = new CategoryModel();
                    CategoryBean cBean = null;
                    List cList = cModel.list();
                    Iterator<CategoryBean> cit = cList.iterator();
                    while(cit.hasNext()){
                        cBean = cit.next();
                %>
                    <li>
                        <a href="<%=SOTGView.PRODUCT_LIST_CTL%>?Category=<%=cBean.getName()%>&cId=<%=cBean.getId()%>" class="category-link"><%=cBean.getName()%></a>
                    </li>
                <% } %>
                </ul>
            </div>
        </div>

        <!-- Main content -->
        <div style="width: 75%;">
            <div style="display: flex; flex-wrap: wrap; gap: 20px;">
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int size = (int)request.getAttribute("size");
                    int index = ((pageNo - 1) * pageSize) + 1;
                    ProductBean bean = null;
                    List list = ServletUtility.getList(request);
                    Iterator<ProductBean> it = list.iterator();

                    while (it.hasNext()) {
                        bean = it.next();
                %>
                <div style="background-color: white; border: 1px solid #ddd; border-radius: 8px; width: calc(33.33% - 20px); padding: 10px; box-shadow: 2px 2px 6px #ccc;">
                    <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>">
                        <img src="<%=SOTGView.APP_CONTEXT%>/images/<%=bean.getImage()%>" alt="Product" style="width: 100%; height: 200px; object-fit: cover; border-radius: 5px;">
                    </a>
                    <div style="padding: 10px 0;">
                        <h4 style="margin: 0 0 10px;">
                            <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>" style="text-decoration: none; color: #333;"><%=bean.getName()%></a>
                        </h4>
                        <p style="margin: 0 0 10px; color: green; font-weight: bold;">$<%=bean.getPrice()%></p>
                        <div style="display: flex; justify-content: space-between;">
                            <!-- Delete Button with confirmation -->
                            <a href="<%=SOTGView.PRODUCT_LIST_CTL%>?prdId=<%=bean.getId()%>" 
                               onclick="return confirm('Are you sure you want to delete?');" 
                               style="padding: 6px 12px; background-color: #dc3545; color: white; text-decoration: none; border-radius: 4px;">
                               Delete
                            </a>
                            <a href="<%=SOTGView.PRODUCT_CTL%>?id=<%=bean.getId()%>" style="padding: 6px 12px; background-color: #28a745; color: white; text-decoration: none; border-radius: 4px;">Edit</a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <div style="margin-top: 30px; text-align: center;">
                <form method="post" action="<%=SOTGView.PRODUCT_LIST_CTL%>">
                    <input type="submit" name="operation" value="<%=ProductListCtl.OP_PREVIOUS%>" 
                        style="padding: 8px 16px; margin-right: 10px;" 
                        <%= (pageNo == 1) ? "disabled" : "" %> >
                        
                    <input type="submit" name="operation" value="<%=ProductListCtl.OP_NEXT%>" 
                        style="padding: 8px 16px; margin-right: 10px;" 
                        <%= ((list.size() < pageSize) || size == pageNo * pageSize) ? "disabled" : "" %> >
                        
                    <a href="<%=SOTGView.PRODUCT_CTL%>" style="padding: 8px 16px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px;">Add New Product</a>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
