<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.model.ProductModel"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CartList</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 0; background-color: #f5f5f5;">

<%@ include file="Header.jsp" %>

<!-- Header -->
<section style="text-align: center; color: black; padding: 40px 0;">
    <h1 style="margin: 0;">Cart</h1>
</section>

<!-- Cart Table -->
<form action="<%=SOTGView.CART_LIST_CTL%>" method="post">
    <div style="padding: 20px; max-width: 1000px; margin: auto;">
        <div style="overflow-x:auto; background-color: white; padding: 20px; border-radius: 8px;">
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr style="background-color: #f1f1f1;">
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">Product</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">Description</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">Quantity</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">Price</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">Total</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">Delete</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">View</th>
                        <th style="padding: 10px; border-bottom: 1px solid #ccc;">Update</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int pageNo = ServletUtility.getPageNo(request);
                        int pageSize = ServletUtility.getPageSize(request);
                        int index = ((pageNo - 1) * pageSize) + 1;
                        CartBean bean = null;
                        List list = ServletUtility.getList(request);
                        Iterator<CartBean> it = list.iterator();
                        double n1 = 0, n2 = 0, n3 = 0;
                        int i = 1;

                        while (it.hasNext()) {
                            bean = it.next();
                            ProductModel pModel = new ProductModel();
                            ProductBean pBean = pModel.findByPK(bean.getProductId());
                    %>
                    <tr>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;"><%=pBean.getName()%></td>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;"><%=pBean.getDescription()%></td>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;">
                            <input type="text" name="quantity<%=i++%>" value="<%=(bean.getQuantity() == 0) ? 1 : bean.getQuantity()%>" 
                                style="width: 60px; padding: 5px; text-align: center; border: 1px solid #ccc; border-radius: 4px;" />
                        </td>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;">$<%=pBean.getPrice()%></td>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;">$<%=bean.getFinalAmount()%></td>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;">
                            <a href="<%=SOTGView.CART_LIST_CTL%>?dcid=<%=bean.getId()%>" 
                               onclick="return confirm('Are you sure you want to delete this item?');"
                               style="color: white; background-color: #dc3545; padding: 6px 12px; border-radius: 4px; text-decoration: none;">Delete</a>
                        </td>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;">
                            <a href="<%=SOTGView.PRODUCT_DETAIL_CTL%>?product=<%=pBean.getName()%>&proId=<%=pBean.getId()%>" 
                               style="color: white; background-color: #007bff; padding: 6px 12px; border-radius: 4px; text-decoration: none;">View</a>
                        </td>
                        <td style="padding: 10px; border-bottom: 1px solid #eee;">
                            <input type="submit" name="operation" value="Update" 
                                   style="background-color: #007bff; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer;">
                        </td>
                    </tr>
                    <%
                            n1 = bean.getFinalAmount();
                            n2 = n3 + n1;
                            n3 = n2;
                        }
                        double shipping = 6.90;
                    %>

                    <% if (list.size() > 0) { %>
                    <!-- Subtotal -->
                    <tr>
                        <td colspan="6"></td>
                        <td style="text-align: right; font-weight: bold;">Sub-Total</td>
                        <td style="text-align: right;">$<%=n3%></td>
                    </tr>
                    <!-- Shipping -->
                    <tr>
                        <td colspan="6"></td>
                        <td style="text-align: right; font-weight: bold;">Shipping</td>
                        <td style="text-align: right;">$<%=shipping%></td>
                    </tr>
                    <!-- Total -->
                    <tr>
                        <td colspan="6"></td>
                        <td style="text-align: right; font-weight: bold;">Total</td>
                        <td style="text-align: right;"><strong>$<%=shipping + n3%></strong></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Buttons -->
        <div style="display: flex; justify-content: space-between; margin-top: 20px; flex-wrap: wrap; gap: 10px;">
            <a href="<%=SOTGView.USER_PRODUCT_LIST_CTL%>" 
               style="background-color: #f0f0f0; color: #333; padding: 10px 20px; border-radius: 4px; text-decoration: none;">Continue Shopping</a>
            <% if (list.size() > 0) { %>
            <a href="<%=SOTGView.CHECKOUT_CTL%>" 
               style="background-color: #28a745; color: white; padding: 10px 20px; border-radius: 4px; text-decoration: none;">Checkout</a>
            <% } %>
        </div>
    </div>
</form>

<%@ include file="Footer.jsp" %>
</body>
</html>
