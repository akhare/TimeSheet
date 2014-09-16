<%@ page import="com.pms.*"%>
<%@ page import="com.pms.ProjectCodeRequest"%>
<%
try {
String pCode = request.getParameter("pCode");

} catch (Exception e) {

	} 
%>
<!DOCTYPE HTML>
<html>
<head>



<title>Home - Veracitiz Solutions Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="The free Minima Iphone web template, Andriod web template, Smartphone web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(
hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<!-- google fonts -->
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Pontano+Sans' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'>
<!-- end google fonts -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/jquery.min.js"></script>
<script src="js/slider.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
	function preventBack() {
		window.history.forward();
	}

	$(function() {
		var pull = $('#menu');
		menu = $('nav ul');
		menuHeight = menu.height();

		$(pull).on('click', function(e) {
			e.preventDefault();
			// Set the options for the effect type chosen
			var options = {
				direction : 'left'
			};
			// Set the duration (default: 400 milliseconds)
			var duration = 900;
			menu.toggle('drop', options, duration);
		});

		$(window).resize(function() {
			var w = $(window).width();
			if (w > 320 && menu.is(':hidden')) {
				menu.removeAttr('style');
			}
		});
	});

	$(function() {
		// Slideshow 1
		$("#slider").responsiveSlides({
			maxwidth : 500,
			speed : 800
		});
	});

</script>
</head>
<body onload="preventBack(); onSubmit();">

	<div class="body">
		<div class="wrap">
			<div class="wrapper">
				<div class="header">
					<div class="logo">
						<a href="index.jsp"><img src="images/logo4.png" alt=""></a>
					</div>
					<div class="cssmenu">
						<ul>
							<li class="active"><a href="index.jsp">Home</a></li>
							<% if (session.getAttribute("employeeId") == null) { %>
							<li><a href="login.jsp">Login</a></li>
							<% } if (session.getAttribute("employeeId") != null) { %>
							<li><a href="time_sheet.jsp">Time&nbsp;Sheet</a></li>
							<li><a href="time_expanses.jsp">Time&nbsp;Expenses</a></li>
							<li><a href="ProjectCodeRequest.jsp">PCR</a></li>
							<li><a href="log_out.jsp">Log&nbsp;Out</a></li>
							<% } %>
							<div class="clear"></div>
						</ul>
					</div>
					<div class="clear"></div>
					<div class="top-nav">
						<nav class="clearfix">
							<a href="#" id="pull"><img src="images/nav-icon.png" id="menu" alt="" /></a>
							<ul id="navigationMenu">
								<!-- <li><a class="home" href="index.jsp"> <span>Home</span></a></li> -->
								<% if (session.getAttribute("employeeId") == null) { %>
								<li><a class="home" href="login.jsp"> <span>Login</span></a></li>
								<% } if (session.getAttribute("employeeId") != null) { %>
								<!-- <li><a class="portfolio" href="ProjectCodeRequest.jsp"> <span>PCR</span></a></li> -->
								<li><a class="about" href="ProjectCodeRequest.jsp"> <span>PCR</span></a>
								<li><a class="services" href="time_sheet.jsp"> <span>Time&nbsp;Sheet</span></a></li>
								<li><a class="portfolio" href="time_expanses.jsp"> <span>Time&nbsp;Expenses</span></a></li>
								
								<li><a class="contact" href="log_out.jsp"> <span>Log&nbsp;Out</span></a></li>
								<% } %>
							</ul>
						</nav>
					</div>
				</div>
				<!-- start banner -->
				<div class="banner">
					<br>
					<h3>
						Welcome to Veracitiz <%=session.getAttribute("name") != null ? session.getAttribute("name") : ""%>....!!!
					</h3>
					<br>

					<!-- Image Slider -->
					<ul id="slider" class="slider">
						<li><img src="images/slider/6.jpg" alt="" /></li>
					    <li><img src="images/slider/5.jpg" alt="" /></li>
						<li><img src="images/slider/4.jpg" alt="" /></li>
						<li><img src="images/slider/3.jpg" alt="" /></li>
						<li><img src="images/slider/2.jpg" alt="" /></li>
						<li><img src="images/slider/1.jpg" alt="" /></li> 
					</ul>

				</div>
				<!-- start content -->
				<div class="main">
					<div class="content"></div>

				</div>
			</div>
		</div>
	</div>
</body>
</html>