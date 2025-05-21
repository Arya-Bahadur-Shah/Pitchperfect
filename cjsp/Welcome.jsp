<%@page import="pitchperfect.controller.WelcomeCtl"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.controller.SOTGView"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="pitchperfect.bean.CategoryBean"%>
<%@page import="pitchperfect.model.CategoryModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pitch Perfect</title>
<style>
    .category-link {
        text-decoration: none;
        color: #333;
        display: block;
        padding: 8px 0;
        transition: background-color 0.3s, color 0.3s;
        border-radius: 3px;
    }

    .category-link:hover {
        background-color: #007bff;
        color: white;
    }
</style>
</head>
<body style="font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa;">

<%@ include file="Header.jsp" %>

<div style=" color: black; text-align: center; padding: 50px 20px;">
    <h1 style="margin: 0;">Welcome</h1>
    <p style="margin: 10px 0 0;">To Pitchperfect</p>
</div>

<div style="padding: 20px;">
    <div>
        <nav>
            <ol style="list-style: none; padding: 0;">
                <li><a href="index.html" style="text-decoration: none; color: #007bff;">Home</a></li>
            </ol>
        </nav>
    </div>

    <div style="display: flex; flex-wrap: wrap; gap: 20px;">
        <!-- Left Category Column -->
        <div style="flex: 1 1 20%; max-width: 250px; background-color: #e9ecef; padding: 15px; border-radius: 5px;">
            <div style="background-color: #007bff; color: white; padding: 10px; border-radius: 3px; font-weight: bold;">Categories</div>
            <ul style="list-style-type: none; padding-left: 0; margin-top: 10px;">
                <% 
                    CategoryModel cModel = new CategoryModel();
                    CategoryBean cBean = null;
                    List cList = cModel.list();
                    Iterator<CategoryBean> cit = cList.iterator();
                    while (cit.hasNext()) {
                        cBean = cit.next();
                %>
                <li style="border-bottom: 1px solid #ccc;">
                    <a href="<%=SOTGView.USER_PRODUCT_LIST_CTL%>?Category=<%=cBean.getName()%>&cId=<%=cBean.getId()%>" class="category-link"><%=cBean.getName()%></a>
                </li>
                <% } %>
            </ul>
        </div>

        <!-- Right Product Section -->
        <div style="flex: 1 1 75%;">
            <div style="display: flex; flex-wrap: wrap; gap: 20px;">
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int size = (int) request.getAttribute("size");
                    int index = ((pageNo - 1) * pageSize) + 1;
                    ProductBean bean = null;
                    List list = ServletUtility.getList(request);
                    Iterator<ProductBean> it = list.iterator();

                    while (it.hasNext()) {
                        bean = it.next();
                %>
                <div style="flex: 1 1 calc(33% - 20px); border: 1px solid #ccc; border-radius: 5px; background-color: #fff; overflow: hidden;">
                    <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>">
                        <img src="<%=SOTGView.APP_CONTEXT%>/images/<%=bean.getImage()%>" alt="Product Image" style="width: 100%; height: 200px; object-fit: cover;">
                    </a>
                    <div style="padding: 15px;">
                        <h4 style="margin: 0 0 10px;">
                            <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>" style="text-decoration: none; color: #000;"><%=bean.getName()%></a>
                        </h4>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <p style="margin: 0; background-color: #dc3545; color: white; padding: 5px 10px; border-radius: 3px;"><%=bean.getPrice()%></p>
                            <% if(userLoggedIn){ %>
                            <a href="<%=SOTGView.CART_CTL%>?prodId=<%=bean.getId()%>" style="background-color: #28a745; color: white; padding: 5px 10px; border-radius: 3px; text-decoration: none;">Add to cart</a>
                            <% } else { %>
                            <a href="<%=SOTGView.USER_LOGIN_CTL%>?product=<%=bean.getName()%>&proIdd=<%=bean.getId()%>" style="background-color: #28a745; color: white; padding: 5px 10px; border-radius: 3px; text-decoration: none;">Add to cart</a>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Pagination -->
            <div style="margin-top: 20px; text-align: center;">
                <form method="post" style="display: inline-block;">
                    <input type="submit" name="operation" value="<%=WelcomeCtl.OP_PREVIOUS%>" 
                        <%= (pageNo == 1) ? "disabled" : "" %>
                        style="padding: 10px 15px; margin-right: 10px; border: none; background-color: green; color: white; border-radius: 3px;">
                    <input type="submit" name="operation" value="<%=WelcomeCtl.OP_NEXT%>" 
                        <%= ((list.size() < pageSize) || size == pageNo * pageSize) ? "disabled" : "" %>
                        style="padding: 10px 15px; border: none; background-color: #007bff; color: white; border-radius: 3px;">
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
