<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>
<%@ page import="pitchperfect.bean.CourtBookingBean" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Court Booking</title>
</head>
<body>
    <h2>Court Booking Form</h2>

    <form method="post" action="<c:url value='/ctl/CourtBookingCtl'/>">
        <label>Futsal Court Name:</label>
<select name="futsalCourtId" required>
  <!-- insert logic here -->
   <option value="1">Himalayan futsal</option>
  <option value="2">Radhe krishna futsal</option>
  <option value="3">Ithari futsal</option>
  
</select><br/>
        

        <label>User Name:</label>
        <input type="text" name="userName" required /><br/>

        <label>Booking Date (YYYY-MM-DD):</label>
        <input type="text" name="bookingDate" required /><br/>

        <label>Booking Day (e.g. Monday):</label>
        <input type="text" name="bookingDay" required /><br/>

        <label>Booking Time (HH:mm):</label>
        <input type="text" name="bookingTime" required /><br/>

        <label>Duration (in minutes):</label>
        <input type="number" name="duration" required /><br/>

        <input type="submit" value="Book Court"/>
    </form>

    <h3>All Bookings</h3>

    <table border="1">
        <tr>
            <th>User</th>
            <th>Date</th>
            <th>Day</th>
            <th>Time</th>
            <th>Duration</th>
        </tr>
<%
    List<CourtBookingBean> list = (List<CourtBookingBean>) request.getAttribute("list");
    if (list != null) {
        for (CourtBookingBean b : list) {
%>
            <tr>
                <td><%= b.getUserName() %></td>
                <td><%= b.getBookingDate() %></td>
                <td><%= b.getBookingDay() %></td>
                <td><%= b.getBookingTime() %></td>
                <td><%= b.getDuration() %> min</td>
            </tr>
<%
        }
    }
%>
    </table>
</body>
</html>
