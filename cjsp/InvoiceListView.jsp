<%@page import="pitchperfect.controller.InvoiceListCtl"%>
<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="pitchperfect.bean.InvoiceBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>History</title>
</head>
<body style="margin: 0; font-family: Arial, sans-serif; background-color: #f4f4f4;">

<%@ include file="Header.jsp" %>

<section style="background-color: #007bff; color: white; padding: 20px 0; text-align: center;">
    <div style="max-width: 800px; margin: 0 auto;">
        <h1 style="margin: 0;">History</h1>
    </div>
</section>

<form action="<%=SOTGView.INVOICE_LIST_CTL%>" method="post"></form>

<div style="max-width: 1000px; margin: 20px auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
    <div style="overflow-x:auto;">
        <table style="width: 100%; border-collapse: collapse; text-align: left;">
            <thead>
                <tr style="background-color: #007bff; color: white;">
                    <th style="padding: 12px; border: 1px solid #ddd;">S No.</th>
                    <th style="padding: 12px; border: 1px solid #ddd;">Product</th>
                    <% if(userBean.getRoleId()==1){ %>
                    <th style="padding: 12px; border: 1px solid #ddd;">User Name</th>
                    <% } %>
                    <th style="padding: 12px; border: 1px solid #ddd;">Shipping Address</th>
                    <th style="padding: 12px; border: 1px solid #ddd;">Billing Address</th>
                    <th style="padding: 12px; border: 1px solid #ddd;">Date</th>
                    <th style="padding: 12px; border: 1px solid #ddd;">Price</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;
                    int size = (int) request.getAttribute("size");
                    InvoiceBean bean = null;
                    List list = ServletUtility.getList(request);
                    Iterator<InvoiceBean> it = list.iterator();
                    while (it.hasNext()) {
                        bean = it.next();
                %>
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 10px; border: 1px solid #ddd;"><%=index++%></td>
                    <td style="padding: 10px; border: 1px solid #ddd;"><%=bean.getProductName()%></td>
                    <% if(userBean.getRoleId()==1){ %>
                    <td style="padding: 10px; border: 1px solid #ddd;"><%=bean.getUserName()%></td>
                    <% } %>
                    <td style="padding: 10px; border: 1px solid #ddd;"><%=bean.getShippingAddress()%></td>
                    <td style="padding: 10px; border: 1px solid #ddd;"><%=bean.getBillingAddress()%></td>
                    <td style="padding: 10px; border: 1px solid #ddd; text-align: right;"><%=DataUtility.getDateString(bean.getDate())%></td>
                    <td style="padding: 10px; border: 1px solid #ddd; text-align: right;">$<%=bean.getAmount()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <div style="margin-top: 20px; display: flex; justify-content: space-between;">
        <input type="submit" name="operation" value="<%=InvoiceListCtl.OP_PREVIOUS%>"
            style="padding: 10px 20px; font-size: 14px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;"
            <%= (pageNo == 1) ? "disabled style='opacity:0.6; cursor: not-allowed;'" : "" %>>
        
        <input type="submit" name="operation" value="<%=InvoiceListCtl.OP_NEXT%>"
            style="padding: 10px 20px; font-size: 14px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;"
            <%= ((list.size() < pageSize) || size==pageNo*pageSize) ? "disabled style='opacity:0.6; cursor: not-allowed;'" : "" %>>
    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>
