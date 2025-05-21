<%@page import="pitchperfect.util.DataUtility"%>
<%@page import="pitchperfect.util.ServletUtility"%>
<%@page import="pitchperfect.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f9f9f9;">

<%@ include file="Header.jsp" %>

<!-- Jumbotron Section -->
<section style="text-align: center; padding: 40px 20px; background-color: #e9ecef;">
    <div style="max-width: 800px; margin: 0 auto;">
        <h1 style="margin: 0;">Login</h1>
    </div>
</section>

<!-- Breadcrumb -->
<div style="max-width: 1200px; margin: 20px auto;">
    <div style="margin-bottom: 10px;">
        <nav>
            <ol style="list-style: none; display: flex; gap: 10px; padding: 0; margin: 0;">
                <li><a href="<%=SOTGView.WELCOME_CTL%>" style="text-decoration: none; color: #007bff;">Home</a></li>
                <li><a href="<%=SOTGView.LOGIN_CTL%>" style="text-decoration: none; color: #000;">Login</a></li>
            </ol>
        </nav>
    </div>
</div>
<body style="margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #ffffff;">



<!-- Wrapper -->
<div style="display: flex; height: 70vh; justify-content: center; align-items: center; gap: 40px; padding: 20px;">

    <!-- Left Panel (Welcome Message) -->
    <div style="flex: 1; max-width: 500px; min-width: 300px; background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%); display: flex; flex-direction: column; justify-content: center; align-items: center; color: white; border-radius: 12px; padding: 20px;">
        <div style="text-align: center;">
            <h1 style="font-size: 40px; margin: 0;">Welcome<br>Back!</h1>
        </div>
    </div>

    <!-- Right Panel (Login Form) -->
    <div style="flex: 1; max-width: 400px; min-width: 300px; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
        
        <!-- Title -->
        <h2 style="margin-bottom: 10px;">Login</h2>
        <p style="margin-top: 0; color: #777;">Welcome back! Please login to your account.</p>


            <!-- Messages -->
            <div style="margin-bottom: 10px;">
                <span style="color: red; font-size: 14px;"><%=ServletUtility.getErrorMessage(request)%></span><br>
                <span style="color: green; font-size: 14px;"><%=ServletUtility.getSuccessMessage(request)%></span>
            </div>

            <!-- Form -->
            <form action="<%=SOTGView.LOGIN_CTL%>" method="post">
                <jsp:useBean id="bean" class="pitchperfect.bean.UserBean" scope="request" />
                <% String uri = (String) request.getAttribute("uri"); %>

                <!-- Hidden Fields -->
                <input type="hidden" name="uri" value="<%=uri%>">
                <input type="hidden" name="id" value="<%=bean.getId()%>">
                <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
                <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
                <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
                <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

                <!-- Login ID -->
                <div style="margin-bottom: 15px;">
                    <label style="font-weight: 600;">Login ID</label>
                    <input type="text" name="login" placeholder="Enter Login Id..."
                        value="<%=DataUtility.getStringData(bean.getLogin())%>"
                        style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px;">
                    <div style="color: red; font-size: 13px;"><%=ServletUtility.getErrorMessage("login", request)%></div>
                </div>

                <!-- Password -->
                <div style="margin-bottom: 15px;">
                    <label style="font-weight: 600;">Password</label>
                    <input type="password" name="password" placeholder="Enter Password..."
                        value="<%=DataUtility.getStringData(bean.getPassword())%>"
                        style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px;">
                    <div style="color: red; font-size: 13px;"><%=ServletUtility.getErrorMessage("password", request)%></div>
                </div>

                <!-- Buttons -->
                <div style="text-align: center; margin-top: 20px;">
                    <input type="submit" name="operation" value="<%=LoginCtl.OP_SIGN_IN%>"
                        style="background-color: #7b2ff7; color: white; width: 100%; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px;">
                </div>

                <!-- Signup Option -->
                <div style="text-align: center; margin-top: 15px; font-size: 14px;">
                    New User? 
                    <input type="submit" name="operation" value="<%=LoginCtl.OP_SIGN_UP%>"
                        style="background: none; border: none; color: #7b2ff7; font-weight: bold; cursor: pointer; padding: 0;">
                </div>
            </form>
        </div>
    </div>
</div>


</body>

<br>
<%@ include file="Footer.jsp" %>

</body>
</html>
