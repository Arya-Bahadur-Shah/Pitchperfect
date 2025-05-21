<%@page import="pitchperfect.bean.CategoryBean"%>
<%@page import="pitchperfect.model.CategoryModel"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="pitchperfect.bean.ProductBean"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>

<style>
    .card {
        width: 22%;
        min-width: 250px;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
    }

    .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
    }
</style>

</head>
<%@ include file="Header.jsp" %>
<body style="margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f9f9f9;">

<div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 30px; padding: 40px; background-color: #f9f9f9;">

    <!-- Card 1 -->
    <div class="card">
        <img src="/PitchPerfect/images/futsal1.jpg" alt="Himalayan Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Himalayan Futsal</h3>
            <p style="margin: 0;">Lamingtan Marg 4, Kathmandu 44600</p>
            <p style="margin: 4px 0;">01-5548290</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1200 per hour</p>
        </div>
    </div>

    <!-- Card 2 -->
    <div class="card">
        <img src="/PitchPerfect/images/bhaktapur futsal.webp" alt="Bhaktapur Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Bhaktapur Futsal</h3>
            <p style="margin: 0;">Sallaghari Bhaktapur</p>
            <p style="margin: 4px 0;">01-5548290</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1500 per hour</p>
        </div>
    </div>

    <!-- Card 3 -->
    <div class="card">
        <img src="/PitchPerfect/images/shankhamul futsal.jpg" alt="Shankhamul Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Shankhamul Futsal</h3>
            <p style="margin: 0;">Shankhamul, Baneshwor</p>
            <p style="margin: 4px 0;">01-4782088, 9841567114</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1600 per hour</p>
        </div>
    </div>

    <!-- Card 4 -->
    <div class="card">
        <img src="/PitchPerfect/images/maitidevi futsal.jpg" alt="Maitidevi Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Maitidevi Futsal</h3>
            <p style="margin: 0;">Maitidevi</p>
            <p style="margin: 4px 0;">980-3129270</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1700 per hour</p>
        </div>
    </div>

    <!-- Card 5 -->
    <div class="card">
        <img src="/PitchPerfect/images/royal futsal.jpg" alt="Royal Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Royal Futsal</h3>
            <p style="margin: 0;">Thapa Gaun, Anamnagar</p>
            <p style="margin: 4px 0;">01-5244436, 980-8192257</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1400 per hour</p>
        </div>
    </div>

    <!-- Card 6 -->
    <div class="card">
        <img src="/PitchPerfect/images/goaltz futsal.jpg" alt="Goalz!! Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Goalz!! Futsal</h3>
            <p style="margin: 0;">Kathmandu Fun Park, Bhrikuti</p>
            <p style="margin: 4px 0;">9803641222</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1400 per hour</p>
        </div>
    </div>

    <!-- Duplicate Cards if needed -->
    <div class="card">
        <img src="/PitchPerfect/images/goaltz futsal.jpg" alt="Goalz!! Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Goalz!! Futsal</h3>
            <p style="margin: 0;">Kathmandu Fun Park, Bhrikuti</p>
            <p style="margin: 4px 0;">9803641222</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1400 per hour</p>
        </div>
    </div>

    <div class="card">
        <img src="/PitchPerfect/images/goaltz futsal.jpg" alt="Goalz!! Futsal" style="width: 100%; height: 200px; object-fit: cover;">
        <div style="padding: 16px;">
            <h3 style="margin: 0 0 8px; font-size: 18px;">Goalz!! Futsal</h3>
            <p style="margin: 0;">Kathmandu Fun Park, Bhrikuti</p>
            <p style="margin: 4px 0;">9803641222</p>
            <p style="margin: 8px 0 0; font-weight: bold; color: #2E8B57;">Rs 1400 per hour</p>
        </div>
    </div>

</div>

</body>
<%@ include file="Footer.jsp" %>
</html>
