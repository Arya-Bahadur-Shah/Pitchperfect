<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
    <title>Court Booking Form</title>
    <style>
        form {
            max-width: 400px;
            margin: 20px auto;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 6px;
            margin-top: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            margin-top: 15px;
            padding: 8px 15px;
            background-color: #007bff;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        p a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        p a:hover {
            text-decoration: underline;
        }
        .alert-success {
            max-width: 400px;
            margin: 20px auto;
            padding: 10px;
            border: 1px solid green;
            background-color: #d4edda;
            color: green;
            border-radius: 5px;
            text-align: center;
        }
    </style>

    <script>
        function confirmBooking() {
            return confirm("Are you sure you want to confirm the booking?");
        }
    </script>
</head>
<body>
<%@ include file="Header.jsp" %>

<%
    String success = (String) session.getAttribute("success");
    if (success != null) {
%>
    <div class="alert-success"><%= success %></div>
<%
        session.removeAttribute("success");
    }
%>

<h2 style="text-align:center;">Book a Court</h2>

<form method="post" action="<c:url value='/ctl/CourtBookingCtl'/>" onsubmit="return confirmBooking();">
    <label for="futsalCourtId">Futsal Court Name:</label>
    <select name="futsalCourtId" id="futsalCourtId" required>
        <option value="">-- Select Court --</option>
        <option value="1">Himalayan futsal</option>
        <option value="2">Bhaktapur Futsal</option>
        <option value="3">Shankhamul Futsal</option>
        <option value="4">Maitidevi Futsal</option>
        <option value="5">Royal Futsal</option>
        <option value="6">Goalz!! Futsal</option>
    </select>

    <label for="userName">User Name:</label>
    <input type="text" id="userName" name="userName" required />

    <label for="bookingDate">Booking Date (YYYY-MM-DD):</label>
    <input type="text" id="bookingDate" name="bookingDate" placeholder="2025-05-20" required />

    <label for="bookingDay">Booking Day (e.g. Monday):</label>
    <input type="text" id="bookingDay" name="bookingDay" placeholder="Monday" required />

    <label for="bookingTime">Booking Time (HH:mm):</label>
    <input type="text" id="bookingTime" name="bookingTime" placeholder="14:30" required />

    <label for="duration">Duration (in minutes):</label>
    <input type="number" id="duration" name="duration" min="15" step="15" required />

    <input type="submit" value="Book Court" />
</form>

<p><a href="<c:url value='/ctl/CourtBookingCtl?operation=list'/>">View All Bookings</a></p>

<%@ include file="Footer.jsp" %>
</body>
</html>
