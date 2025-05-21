<%@ page import="java.util.List" %>
<%@ page import="pitchperfect.bean.CourtBookingBean" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
    <title>All Court Bookings</title>
</head>
<%@ include file="Header.jsp" %>
<body style="font-family: Arial, sans-serif; background-color: #f9f9f9;">


    <h2 style="text-align: center; color: #333; margin-bottom: 30px;">All Court Bookings</h2>

    <table style="width: 100%; margin: auto; border-collapse: collapse; box-shadow: 0 2px 10px rgba(0,0,0,0.1); background-color: #fff;">
        <tr style="background-color: #007bff; color: white;">
            <th style="padding: 12px;">User</th>
            <th style="padding: 12px;">Date</th>
            <th style="padding: 12px;">Day</th>
            <th style="padding: 12px;">Time</th>
            <th style="padding: 12px;">Duration</th>
        </tr>
<%
    List<CourtBookingBean> list = (List<CourtBookingBean>) request.getAttribute("list");
    if (list != null && !list.isEmpty()) {
        for (CourtBookingBean b : list) {
%>
        <tr style="text-align: center; border-bottom: 1px solid #ddd;">
            <td style="padding: 10px;"><%= b.getUserName() %></td>
            <td style="padding: 10px;"><%= b.getBookingDate() %></td>
            <td style="padding: 10px;"><%= b.getBookingDay() %></td>
            <td style="padding: 10px;"><%= b.getBookingTime() %></td>
            <td style="padding: 10px;"><%= b.getDuration() %> min</td>
        </tr>
<%
        }
    } else {
%>
        <tr>
            <td colspan="5" style="text-align: center; padding: 20px; color: #999;">No bookings found.</td>
        </tr>
<%
    }
%>
    </table>

   

</body>

<%@ include file="Footer.jsp" %>
</html>
