<%@page import="pitchperfect.controller.CheckoutCtl"%>
<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.model.ProductModel"%>
<%@page import="java.util.Iterator"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Checkout View</title>
    <style>
        body {
            margin: 0; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f9fafb; 
            color: #333;
        }
        .container {
            max-width: 960px;
            margin: 30px auto 60px;
            background: white;
            box-shadow: 0 4px 12px rgb(0 0 0 / 0.05);
            border-radius: 8px;
            padding: 30px 40px;
        }
        h1 {
            text-align: center;
            color: #222;
            font-weight: 700;
            margin-bottom: 40px;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            font-size: 15px;
        }
        thead tr {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            border-radius: 8px;
        }
        thead th {
            padding: 15px 12px;
            text-align: left;
        }
        tbody tr {
            background-color: #fff;
            box-shadow: 0 1px 3px rgb(0 0 0 / 0.1);
            border-radius: 6px;
        }
        tbody tr td {
            padding: 15px 12px;
            vertical-align: middle;
            border-bottom: none !important;
        }
        tbody tr td:nth-child(6),
        tbody tr td:nth-child(5) {
            text-align: right;
            font-feature-settings: 'tnum';
            font-variant-numeric: tabular-nums;
        }
        tbody tr.total-row td {
            font-weight: 700;
            font-size: 16px;
            border-top: 2px solid #ddd;
        }
        tbody tr.total-row td:last-child {
            text-align: right;
            color: #007bff;
        }
        .user-details {
            margin-top: 50px;
            background: #007bff;
            color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgb(0 123 255 / 0.25);
        }
        .user-details-header {
            background: #0056b3;
            padding: 18px 30px;
            font-size: 20px;
            font-weight: 700;
        }
        .user-details-content {
            background: white;
            color: #222;
            padding: 25px 30px;
            font-size: 16px;
            line-height: 1.5;
        }
        .user-details-content p {
            margin: 8px 0;
        }
        .user-details-content b {
            width: 120px;
            display: inline-block;
            color: #444;
        }
        .pay-button-container {
            text-align: center;
            margin-top: 40px;
        }
        .pay-button {
            background-color: #28a745;
            border: none;
            padding: 15px 45px;
            font-size: 18px;
            font-weight: 700;
            border-radius: 6px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .pay-button:hover {
            background-color: #218838;
        }
        a.pay-button {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <%@ include file="Header.jsp" %>

    <div class="container">
        <h1>Checkout</h1>

        <form action="<%=SOTGView.CHECKOUT_CTL%>" method="post">
            <div style="overflow-x:auto;">
                <table>
                    <thead>
                        <tr>
                            <th>S No.</th>
                            <th>Product</th>
                            <th>Description</th>
                            <th style="text-align:center;">Quantity</th>
                            <th style="text-align:right;">Price</th>
                            <th style="text-align:right;">Total</th>
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
                        double n1=0, n2=0, n3=0;
                        while (it.hasNext()) {
                            bean = it.next();
                            ProductModel pModel = new ProductModel();
                            ProductBean pBean = pModel.findByPK(bean.getProductId());
                    %>
                        <tr>
                            <td><%=index++%></td>
                            <td><%=pBean.getName()%></td>
                            <td><%=pBean.getDescription()%></td>
                            <td style="text-align:center;"><%=bean.getQuantity()%></td>
                            <td style="text-align:right;">$<%=pBean.getPrice()%></td>
                            <td style="text-align:right;">$<%=bean.getFinalAmount()%></td>
                        </tr>
                    <%
                            n1 = bean.getFinalAmount();
                            n2 = n3 + n1;
                            n3 = n2;
                        }
                        double shipping = 50;
                    %>
                    <tr class="total-row">
                        <td colspan="4"></td>
                        <td>Sub-Total</td>
                        <td>$<%=String.format("%.2f", n3)%></td>
                    </tr>
                    <tr class="total-row">
                        <td colspan="4"></td>
                        <td>Shipping</td>
                        <td>$<%=String.format("%.2f", shipping)%></td>
                    </tr>
                    <tr class="total-row">
                        <td colspan="4"></td>
                        <td>Total</td>
                        <td><strong>$<%=String.format("%.2f", shipping + n3)%></strong></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- User Details -->
            <div class="user-details">
                <div class="user-details-header">Confirm Detail</div>
                <%
                    UserBean uBean = (UserBean)session.getAttribute("user");
                %>
                <div class="user-details-content">
                    <p><b>Name:</b> <span><%=uBean.getFirstName() + " " + uBean.getLastName()%></span></p>
                    <p><b>Email:</b> <span><%=uBean.getEmailAddress()%></span></p>
                    <p><b>Mobile No:</b> <span><%=uBean.getMobileNo()%></span></p>
                </div>
            </div>
        </form>

        <div class="pay-button-container">
            <a href="<%=request.getContextPath()%>/cjsp/PaymentView.jsp" class="pay-button">
                Pay
            </a>
        </div>
    </div>

    <%@ include file="Footer.jsp" %>
</body>
</html>
