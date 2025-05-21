<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Footer</title>
<style type="text/css">
.footer {
    background-color: #3C3C3C;
    color: #ccc;
    padding: 40px 0;
    font-size: 14px;
  }
  
  .f-container {
    width: 90%;
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    gap: 80px;
    flex-wrap: wrap;
  }
  
  .f-about {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 35%;  
}
  
  .f-about img.footer-logo {
    width: 71px;
    height: 17px;
    margin-bottom: 15px;
  }
  
  .f-about p {
    line-height: 1.6;
    font-size: 10px;
  }
  
  .f-lnks,
  .f-contact {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 20%;  
  }
  
  .f-links h4,
  .f-contact h4 {
    margin-bottom: 15px;
    font-size: 16px;
    color: white;
  }
  
  .f-links ul {
    list-style: none;
    padding: 0;
  }
  
  .f-links ul li {
    margin-bottom: 8px;
  }
  
  .f-links ul li a {
    text-decoration: none;
    color: #ccc;
    transition: color 0.3s ease;
  }
  
  .f-links ul li a:hover {
    text-decoration: underline;
  }
  
  .f-contact .social-icons a {
    margin-right: 10px;
    display: inline-block;
  }
  
  .f-contact .social-icons img {
    width: 24px;
    height: 24px;
    transition: transform 0.3s ease;
  }
  
  .f-contact .social-icons img:hover {
    transform: scale(1.2);
  }
  

</style>
</head>
<body>
	<footer class="footer">
    <div class="f-container">
      <div class="f-about">
        <img src="/PitchPerfect/images/logo.jpg" alt="Pitch Perfect Logo" class="footer-logo" />
        <p>
          Pitch Perfect has a dedicated trusted platform offering a full range of services and products for football enthusiasts. From booking local matches with real-time availability to shopping high-quality football gear, we make it easy to play, shop, and stay connected to the game. Whether you're organizing a friendly match or gearing up for a league, Pitch Perfect has everything you need in one place.
        </p>
      </div>
      <div class="f-links">
        <h4>Useful Links</h4>
        <ul>
          <li><a href="home.html">Futsal</a></li>
          <li><a href="assesories.html">Accessories</a></li>
          <li><a href="account.html">Account</a></li>
        </ul>
      </div>
      <div class="f-contact">
        <h4>Contact</h4>
        <div class="social-icons">
          <a href="#"><img src="img/ig.jpeg" alt="Instagram"></a>
          <a href="#"><img src="img/facebook.png" alt="Facebook"></a>
          <a href="#"><img src="img/x.png" alt="Twitter/X"></a>
          <a href="#"><img src="img/github.png" alt="GitHub"></a>
        </div>
      </div>
    </div>
  </footer>
</body>
</html>