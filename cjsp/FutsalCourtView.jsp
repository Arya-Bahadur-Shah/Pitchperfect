<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="pitchperfect.bean.FutsalCourtBean"%>
<%@ page import="pitchperfect.util.DataUtility"%>
<%@ page import="pitchperfect.util.ServletUtility"%>

<!DOCTYPE html>
<html>
<head>
    <title>Futsal Court Management</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
</head>
<body>
    <%@ include file="Header.jsp" %>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2 class="text-center">Futsal Court Management</h2>

                <!-- Multipart form for file upload -->
                <form action="<%=request.getContextPath()%>/ctl/FutsalCourtCtl" method="post" enctype="multipart/form-data">
                    <jsp:useBean id="bean" class="pitchperfect.bean.FutsalCourtBean" scope="request" />

                    <input type="hidden" name="id" value="<%=bean.getId()%>">
                    <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
                    <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
                    <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
                    <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="name" name="name" value="<%=DataUtility.getStringData(bean.getName())%>">
                        <font color="red"><%=ServletUtility.getErrorMessage("name", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea class="form-control" id="description" name="description" rows="3"><%=DataUtility.getStringData(bean.getDescription())%></textarea>
                        <font color="red"><%=ServletUtility.getErrorMessage("description", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="pricePerHour">Price Per Hour:</label>
                        <input type="number" step="0.01" class="form-control" id="pricePerHour" name="pricePerHour" value="<%=DataUtility.getStringData(bean.getPricePerHour())%>">
                        <font color="red"><%=ServletUtility.getErrorMessage("pricePerHour", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="location">Location:</label>
                        <input type="text" class="form-control" id="location" name="location" value="<%=DataUtility.getStringData(bean.getLocation())%>">
                        <font color="red"><%=ServletUtility.getErrorMessage("location", request)%></font>
                    </div>

                    <div class="form-group">
                        <label for="image">Upload Image:</label>
                        <input type="file" class="form-control" id="image" name="image">
                        <font color="red"><%=ServletUtility.getErrorMessage("image", request)%></font>
                        <% if(bean.getImage() != null && !bean.getImage().isEmpty()) { %>
                            <p>Current Image:</p>
                            <img src="<%=request.getContextPath()%>/<%=bean.getImage()%>" width="150" alt="Futsal Court Image"/>
                        <% } %>
                    </div>

                    <div class="text-center">
                        <input type="submit" name="operation" value="<%=bean.getId() > 0 ? "Update" : "Save"%>" class="btn btn-primary">
                        <input type="submit" name="operation" value="Cancel" class="btn btn-secondary">
                        <% if (bean.getId() > 0) { %>
                            <input type="submit" name="operation" value="Delete" class="btn btn-danger">
                        <% } %>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="Footer.jsp"%>

    <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
</body>
</html>
