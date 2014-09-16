<!DOCTYPE HTML>
<html>
<head>
<title>LogIn - Veracitiz Solutions Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="The free Minima Iphone web template, Andriod web template, Smartphone web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(
hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
    function preventBack(){window.history.forward();}
    
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
</script>
</head>
<body onload="preventBack();">
	
	<div class="body">
		<div class="wrap">
			<div class="wrapper">
				<div class="header">

			<div class="logo">
				<a href="#"><img src="images/logo4.png" alt=""></a>
			</div>
				<div class="cssmenu">
			<ul>
				<!-- <li><a href="index.jsp">Home</a></li -->
				<% if(session.getAttribute("employeeId") == null){%>
				<li class="active"><a href="login.jsp">Login</a></li>
				<% }if(session.getAttribute("employeeId") != null){%>
				<li><a href="time_sheet.jsp">Time&nbsp;Sheet</a></li>
				<li><a href="time_expanses.jsp">Time&nbsp;Expenses</a></li>
				<li><a href="#">ProjectCode&nbsp;Request</a></li>
				<li><a href="log_out.jsp">Log&nbsp;Out</a></li>
				<%} %>
				<div class="clear"></div>
			</ul>
		</div>	
		<div class="clear"></div>
			<div class="top-nav">
				<nav class="clearfix">
					<a href="#" id="pull"><img src="images/nav-icon.png" id="menu" alt="" /></a>
					<ul id="navigationMenu">
					</ul>
				</nav>
			</div>
		</div>
		<!-- start content -->
		<div class="main1">
			<div class="contact">
				<div class="contact-form">
					<div class="content"></div>
					<form method="post" action="login_action.jsp">
						<div>
							<span><label>User Id :</label></span> 
							<span><input name="uname" type="text" class="textbox" autofocus></span>
						</div>
						<div>
							<span><label>Password :</label></span> 
							<span><input name="password" type="password" class="textbox"></span>
						</div>
						<font size="3" color="red"><b><%=request.getAttribute("msg") != null ? request.getAttribute("msg") : ""%></b></font>
						<br>
						<div align="center">
							<span><input type="submit" value="LogIn"></span>
						</div>
					</form>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	</div>
	</div>
</body>
</html>