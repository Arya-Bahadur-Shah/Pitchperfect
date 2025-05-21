<%@page import="pitchperfect.controller.CheckoutCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payment</title>
</head>
<body style="margin: 0; font-family: Arial, sans-serif; background-color: #f5f5f5;">

<%@ include file="Header.jsp"%>

<section style="padding: 40px 0; background-color: #4CAF50; color: white; text-align: center;">
    <div style="max-width: 800px; margin: auto;">
        <h1 style="margin: 0;">Payment</h1>
    </div>
</section>

<div style="max-width: 800px; margin: 30px auto; background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">

    <div style="display: flex; flex-wrap: wrap;">
        <aside style="flex: 1; min-width: 300px; padding: 20px;">
            <p style="font-size: 18px; font-weight: bold;">Payment</p>

            <div style="padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
                <form role="form" action="<%=SOTGView.CHECKOUT_CTL%>" method="post">
                    <div style="margin-bottom: 15px;">
                        <label for="username" style="display: block; margin-bottom: 5px;">Full name (on the card)</label>
                        <div style="display: flex; align-items: center; border: 1px solid #ccc; border-radius: 4px; padding: 5px;">

                            <input type="text" name="username" required
                                style="flex: 1; border: none; outline: none; font-size: 16px;">
                        </div>
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label for="cardNumber" style="display: block; margin-bottom: 5px;">Card number</label>
                        <div style="display: flex; align-items: center; border: 1px solid #ccc; border-radius: 4px; padding: 5px;">
                        
                            <input type="text" name="cardNumber"
                                style="flex: 1; border: none; outline: none; font-size: 16px;">
                        </div>
                    </div>

                    <div style="display: flex; flex-wrap: wrap; gap: 20px;">
                        <div style="flex: 2;">
                            <label style="display: block; margin-bottom: 5px;">Expiration</label>
                            <div style="display: flex; gap: 10px;">
                                <select style="flex: 1; padding: 5px; font-size: 14px;">
                                    <option>Month</option>
                                    <option>01 - January</option>
                                    <option>02 - February</option>
                                    <option>03 - March</option>
                                    <option>04 - April</option>
                                    <option>05 - May</option>
                                    <option>06 - June</option>
                                    
                                </select>
                                <select style="flex: 1; padding: 5px; font-size: 14px;">
                                    <option>Year</option>
                                    <option>2025</option>
                                </select>
                            </div>
                        </div>
                        <div style="flex: 1;">
                            <label style="display: block; margin-bottom: 5px;">CVV</label>
                            <input type="text" required
                                style="width: 100%; padding: 5px; font-size: 14px; border: 1px solid #ccc; border-radius: 4px;">
                        </div>
                    </div>

                    <div style="margin-top: 20px;">
                        <input type="submit" name="operation" value="<%=CheckoutCtl.OP_CONFIRM_PAYMENT%>"
                            style="width: 100%; background-color: #4CAF50; color: white; border: none; padding: 10px; font-size: 16px; border-radius: 4px; cursor: pointer;">
                    </div>
                </form>
            </div>
        </aside>
    </div>
</div>

<%@ include file="Footer.jsp"%>
</body>
</html>
