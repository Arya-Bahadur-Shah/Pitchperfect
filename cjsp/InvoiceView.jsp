<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.bean.UserBean"%>
<%@page import="pitchperfect.model.ProductModel"%>
<%@page import="pitchperfect.bean.CartBean"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="pitchperfect.controller.SOTGView"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Invoice</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f5f5f5; margin: 0; padding: 0;">
<%@ include file="Header.jsp" %>

<div style="text-align: center; padding: 30px; background-color: #ffffff; margin-bottom: 20px;">
    <h1 style="font-size: 28px; margin-bottom: 10px;">Checkout Invoice</h1>
    <p style="color: #888;">Please review your order below</p>
</div>

<div style="width: 90%; max-width: 1000px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
    <form action="<%=SOTGView.CHECKOUT_CTL%>" method="post">
    
    <div style="margin-bottom: 20px; color: red;"><%=ServletUtility.getErrorMessage(request)%></div>
    <div style="margin-bottom: 20px; color: green;"><%=ServletUtility.getSuccessMessage(request)%></div>

    <table style="width: 100%; border-collapse: collapse; margin-bottom: 30px;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th style="padding: 10px; border: 1px solid #ccc;">S No.</th>
                <th style="padding: 10px; border: 1px solid #ccc;">Product</th>
                <th style="padding: 10px; border: 1px solid #ccc;">Description</th>
                <th style="padding: 10px; border: 1px solid #ccc;">Quantity</th>
                <th style="padding: 10px; border: 1px solid #ccc;">Price</th>
                <th style="padding: 10px; border: 1px solid #ccc;">Total</th>
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
                double total = 0;

                while (it.hasNext()) {
                    bean = it.next();
                    ProductModel pModel = new ProductModel();
                    ProductBean pBean = pModel.findByPK(bean.getProductId());
                    double itemTotal = bean.getFinalAmount();
                    total += itemTotal;
            %>
            <tr>
                <td style="padding: 10px; border: 1px solid #ccc;"><%=index++%></td>
                <td style="padding: 10px; border: 1px solid #ccc;"><%=pBean.getName()%></td>
                <td style="padding: 10px; border: 1px solid #ccc;"><%=pBean.getDescription()%></td>
                <td style="padding: 10px; border: 1px solid #ccc; text-align: center;"><%=bean.getQuantity()%></td>
                <td style="padding: 10px; border: 1px solid #ccc; text-align: right;">$<%=pBean.getPrice()%></td>
                <td style="padding: 10px; border: 1px solid #ccc; text-align: right;">$<%=itemTotal%></td>
            </tr>
            <% } 
                double shipping = 6.90;
            %>
            <tr style="background-color: #f9f9f9;">
                <td colspan="4"></td>
                <td style="padding: 10px; text-align: right;">Sub-Total:</td>
                <td style="padding: 10px; text-align: right;">$<%=total%></td>
            </tr>
            <tr style="background-color: #f9f9f9;">
                <td colspan="4"></td>
                <td style="padding: 10px; text-align: right;">Shipping:</td>
                <td style="padding: 10px; text-align: right;">$<%=shipping%></td>
            </tr>
            <tr style="background-color: #e0ffe0;">
                <td colspan="4"></td>
                <td style="padding: 10px; text-align: right;"><strong>Total:</strong></td>
                <td style="padding: 10px; text-align: right;"><strong>$<%=total + shipping%></strong></td>
            </tr>

            <% UserBean uBean = (UserBean) session.getAttribute("user"); %>
            <tr class="user-details">
                <td colspan="2" style="padding: 10px;"><strong>Name:</strong></td>
                <td colspan="4" style="padding: 10px;"><%=uBean.getFirstName()%> <%=uBean.getLastName()%></td>
            </tr>
            <tr class="user-details">
                <td colspan="2" style="padding: 10px;"><strong>Shipping Address:</strong></td>
                <td colspan="4" style="padding: 10px;"><%=uBean.getShippingAddress()%></td>
            </tr>
            <tr class="user-details">
                <td colspan="2" style="padding: 10px;"><strong>Billing Address:</strong></td>
                <td colspan="4" style="padding: 10px;"><%=uBean.getBillingAddress()%></td>
            </tr>
        </tbody>
    </table>
    </form>
</div>

<br>
<%@ include file="Footer.jsp" %>
</body>
</html>
