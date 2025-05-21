<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="pitchperfect.bean.FutsalCourtBean" %>
<%@ page import="pitchperfect.util.DataUtility" %>
<%@ page import="pitchperfect.util.ServletUtility" %>

<!DOCTYPE html>
<html>
<head>
    <title>Futsal Court List</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 20px;">
    <%@ include file="Header.jsp" %>

    <div style="max-width: 1000px; margin: auto;">
        <h2 style="margin-bottom: 20px;">Futsal Court List</h2>

        <form method="get" action="<%=request.getContextPath()%>/ctl/FutsalCourtListCtl">
            <div style="margin-bottom: 10px;">
                <input 
                    type="text" 
                    name="searchName" 
                    placeholder="Search by Name"
                    value="<%=DataUtility.getString(request.getParameter("searchName"))%>" 
                    style="padding: 8px; width: 300px;"
                />
            </div>
            <div style="margin-bottom: 20px;">
                <button type="submit" style="padding: 8px 12px;">Search</button>
                <a href="<%=request.getContextPath()%>/ctl/FutsalCourtCtl" 
                   style="padding: 8px 12px; background-color: green; color: white; text-decoration: none;">Add New Court</a>
            </div>
        </form>

        <% 
            List<FutsalCourtBean> list = (List<FutsalCourtBean>) request.getAttribute("list");
            if (list == null || list.isEmpty()) { 
        %>
            <div style="padding: 10px; background-color: #ffefc6; border: 1px solid #d3b800;">
                No records found.
            </div>
        <% 
            } else { 
        %>
            <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
                <thead>
                    <tr style="background-color: #f2f2f2;">
                        <th style="border: 1px solid #ddd; padding: 8px;">ID</th>
                        <th style="border: 1px solid #ddd; padding: 8px;">Name</th>
                        <th style="border: 1px solid #ddd; padding: 8px;">Description</th>
                        <th style="border: 1px solid #ddd; padding: 8px;">Price Per Hour</th>
                        <th style="border: 1px solid #ddd; padding: 8px;">Location</th>
                        <th style="border: 1px solid #ddd; padding: 8px;">Image</th>
                        <th style="border: 1px solid #ddd; padding: 8px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% for (FutsalCourtBean court : list) { %>
                    <tr>
                        <td style="border: 1px solid #ddd; padding: 8px;"><%=court.getId()%></td>
                        <td style="border: 1px solid #ddd; padding: 8px;"><%=court.getName()%></td>
                        <td style="border: 1px solid #ddd; padding: 8px;"><%=court.getDescription()%></td>
                        <td style="border: 1px solid #ddd; padding: 8px;"><%=court.getPricePerHour()%></td>
                        <td style="border: 1px solid #ddd; padding: 8px;"><%=court.getLocation()%></td>
                        <td style="border: 1px solid #ddd; padding: 8px;">
                            <% if (court.getImage() != null && !court.getImage().isEmpty()) { %>
                                <img src="data:image/jpeg;base64,<%=court.getImage()%>" alt="Image" style="width: 80px;" />
                            <% } else { %>
                                No Image
                            <% } %>
                        </td>
                        <td style="border: 1px solid #ddd; padding: 8px;">
                            <a href="<%=request.getContextPath()%>/ctl/FutsalCourtCtl?id=<%=court.getId()%>" 
                               style="padding: 6px 10px; background-color: #007bff; color: white; text-decoration: none; margin-right: 5px;">Edit</a>
                            <a href="<%=request.getContextPath()%>/ctl/FutsalCourtListCtl?operation=Delete&id=<%=court.getId()%>" 
                               onclick="return confirm('Are you sure you want to delete this record?');"
                               style="padding: 6px 10px; background-color: #dc3545; color: white; text-decoration: none;">Delete</a>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>

            <div style="display: flex; justify-content: space-between;">
                <% 
                    int pageNo = (Integer) request.getAttribute("pageNo");
                    int pageSize = (Integer) request.getAttribute("pageSize");
                    boolean noNextPage = (Boolean) request.getAttribute("noNextPage");
                    String searchName = request.getParameter("searchName") != null ? request.getParameter("searchName") : "";
                %>

                <form method="get" action="<%=request.getContextPath()%>/ctl/FutsalCourtListCtl">
                    <input type="hidden" name="pageNo" value="<%=pageNo - 1%>"/>
                    <input type="hidden" name="pageSize" value="<%=pageSize%>"/>
                    <input type="hidden" name="searchName" value="<%=searchName%>"/>
                    <button type="submit" style="padding: 6px 12px;" <%= (pageNo <= 1) ? "disabled" : "" %>>Previous</button>
                </form>

                <form method="get" action="<%=request.getContextPath()%>/ctl/FutsalCourtListCtl">
                    <input type="hidden" name="pageNo" value="<%=pageNo + 1%>"/>
                    <input type="hidden" name="pageSize" value="<%=pageSize%>"/>
                    <input type="hidden" name="searchName" value="<%=searchName%>"/>
                    <button type="submit" style="padding: 6px 12px;" <%= (noNextPage) ? "disabled" : "" %>>Next</button>
                </form>
            </div>

        <% } %>

    </div>

    <%@ include file="Footer.jsp" %>
</body>
</html>
