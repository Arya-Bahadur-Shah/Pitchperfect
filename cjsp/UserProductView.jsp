<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="pitchperfect.bean.CategoryBean"%>
<%@page import="pitchperfect.model.CategoryModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Product</title>
    <style>
        .category-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            color: #007bff;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s;
        }

        .category-item:hover {
            background-color: #d4edda;
            color: #155724;
        }

        .category-item.active {
            background-color: #28a745;
            color: white !important;
        }

        .pagination-button {
            padding: 8px 16px;
            margin: 0 5px;
            border-radius: 4px;
            border: 1px solid #007bff;
            background-color: white;
            color: #007bff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .pagination-button:hover:not(:disabled) {
            background-color: #007bff;
            color: white;
        }

        .pagination-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
    </style>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f5f5f5; margin: 0;">

<%@ include file="Header.jsp" %>



<div style="max-width: 1140px; margin: 20px auto;">
    <nav style="margin-bottom: 20px;">
        <ol style="padding: 10px 20px; background: #e9ecef; border-radius: 4px; list-style: none; display: flex;">
            <li style="margin-right: 10px;"><a href="<%=SOTGView.WELCOME_CTL%>">Home</a></li>
            <li style="color: #6c757d;"> / </li>
            <li style="margin-left: 10px;"><a href="<%=SOTGView.USER_PRODUCT_LIST_CTL%>">Product</a></li>
        </ol>
    </nav>

    <div style="display: flex;">
        <!-- Sidebar -->
        <div style="width: 25%; margin-right: 30px;">
            <div style="background-color: #ffffff; border: 1px solid #ddd; border-radius: 5px; overflow: hidden;">
                <div style="background-color: #007bff; color: white; padding: 10px; font-weight: bold;">Categories</div>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <%
                        CategoryModel cModel = new CategoryModel();
                        CategoryBean cBean = null;
                        List cList = cModel.list();
                        Iterator<CategoryBean> cit = cList.iterator();
                        String currentCategory = request.getParameter("Category");
                        while(cit.hasNext()){
                            cBean = cit.next();
                            boolean isActive = cBean.getName().equals(currentCategory);
                    %>
                    <li>
                        <a href="<%=SOTGView.USER_PRODUCT_LIST_CTL%>?Category=<%=cBean.getName()%>&cId=<%=cBean.getId()%>"
                           class="category-item <%= isActive ? "active" : "" %>"><%=cBean.getName()%></a>
                    </li>
                    <% } %>
                </ul>
            </div>
        </div>

        <!-- Product Grid -->
        <div style="width: 75%;">
            <div style="display: flex; flex-wrap: wrap; gap: 20px;">
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int size = (int) request.getAttribute("size");
                    ProductBean bean = null;
                    List<ProductBean> list = ServletUtility.getList(request);
                    Iterator<ProductBean> it = list.iterator();

                    while (it.hasNext()) {
                        bean = it.next();
                        String productCategory = bean.getCategoryName(); 
                %>
                <div style="width: 30%; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); overflow: hidden;">
                    <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>">
                        <img src="<%=SOTGView.APP_CONTEXT%>/images/<%=bean.getImage()%>" style="width: 100%; height: 200px; object-fit: cover;">
                    </a>
                    <div style="padding: 15px;">
                        <h4 style="margin: 0 0 10px 0;">
                            <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=bean.getName()%>&proId=<%=bean.getId()%>" style="color: #333; text-decoration: none;"><%=bean.getName()%></a>
                        </h4>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div style="color: #fff; background-color: #dc3545; padding: 5px 10px; border-radius: 5px;"><%=bean.getPrice()%></div>
                            <% if ("Futsals".equalsIgnoreCase(productCategory)) { %>
                                <!-- Book button -->
                                <a href="http://localhost:8083/PitchPerfect/ctl/CourtBookingCtl"
                                   style="background-color: #007bff; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none;">
                                   Book
                                </a>
                            <% } else { %>
                                <% if(userLoggedIn){ %>
                                    <a href="<%=SOTGView.CART_CTL%>?prodId=<%=bean.getId()%>"
                                       onclick="alert('Added to cart successfully')"
                                       style="background-color: #28a745; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none;">Add to cart</a>
                                <% } else { %>
                                    <a href="<%=SOTGView.USER_LOGIN_CTL%>?product=<%=bean.getName()%>&proIdd=<%=bean.getId()%>"
                                       onclick="alert('Added to cart successfully')"
                                       style="background-color: #28a745; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none;">Add to cart</a>
                                <% } %>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Pagination -->
            <div style="text-align: center; margin-top: 30px;">
                <form method="post" action="">
                    <input type="submit" name="operation" value="<%=UserProductCtl.OP_PREVIOUS%>"
                           class="pagination-button"
                           <%= (pageNo == 1) ? "disabled" : "" %>>

                    <input type="submit" name="operation" value="<%=UserProductCtl.OP_NEXT%>"
                           class="pagination-button"
                           <%= ((list.size() < pageSize) || size == pageNo * pageSize) ? "disabled" : "" %>>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
