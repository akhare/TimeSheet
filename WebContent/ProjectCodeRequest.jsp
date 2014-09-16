 <%@page import="sun.org.mozilla.javascript.internal.regexp.SubString"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="com.applix.tm1.*"%>
<%@ page import="java.lang.String.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pms.*"%>
<%

TM1Bean fieldAdminServer = null;
TM1Server fieldServer = null;
try {
	
	String sDate = request.getParameter("sDate");
	String eDate = request.getParameter("eDate");
	
	
	String employeeId = (String) session.getAttribute("employeeId");
	String password = (String) session.getAttribute("password");
	
	if ((employeeId == null || employeeId.equals(""))
			&& (password == null || password.equals(""))) {
		response.sendRedirect("index.jsp");
	}
	
	fieldAdminServer = new TM1Bean();
	fieldAdminServer.setAdminHost("localhost");

	fieldServer = fieldAdminServer.openConnection("veracitiz", employeeId, password);

	if (fieldServer.isError()) {

	} else {
		
		TM1Process Cnp = fieldServer.getProcess("CreateNewPCR");
		TM1Val Param = TM1Val.makeArrayVal(0);
		Cnp.executeEx(Param);
		
		
	}

	

%>

<!DOCTYPE HTML>
<html>
<head>
<title>LogIn - Veracitiz Solutions Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="The free Minima Iphone web template, Andriod web template, Smartphone web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href='http://fonts.googleapis.com/css?family=Josefin+Slab:400,700' rel='stylesheet' type='text/css' />
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(
hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<!-- google fonts -->
<!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Pontano+Sans' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'> -->
<!-- end google fonts -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />



   <!-- <link rel="stylesheet" href="css/datepicker.css"> -->
   <link rel="stylesheet" href="css/bootstrap.css">	
   <script src="js/jquery.min.js"></script>
    <script src="js/jquery-ui.js"></script> 
   <!-- <script src="js/bootstrap-datepicker.js"></script>  -->
 
<script type="text/javascript">

    function preventBack(){window.history.forward();}
    $(document).ready(function () {
        
        $('#fromDate').datepicker({
            format: "dd/mm/yyyy"
        });  
        
        $('#toDate').datepicker({
            format: "dd/mm/yyyy"
        });  
    
    });
    
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
	/* 
	$(function() {		
		$('#datepicker').datetimepicker({format: 'd/m/Y'}).datetimepicker({step:10});
	});	 */
	
	function DateCheck()
	{		
	  var StartDate= document.getElementById('fromDate').value;
	  var EndDate= document.getElementById('toDate').value;	  
	  var eDate = new Date(EndDate);
	  var sDate = new Date(StartDate);
	  if(StartDate == '' && StartDate == '' || sDate> eDate)
	    {
	    alert("Please ensure that the End Date is greater than or equal to the Start Date.");
	    return false;
	    }
	}
	
 
 	 
</script>
</head>
<body onload="preventBack(); onSubmit();">
	
	<div class="body">
		<div class="wrap">
			<div class="wrapper">
				<div class="header">

			<div class="logo">
				<a href="#"><img src="images/logo4.png" alt=""></a>
			</div>
				<div class="cssmenu">
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<% if(session.getAttribute("employeeId") == null){%>
				<li class="active"><a href="login.jsp">Login</a></li>
				<% }if(session.getAttribute("employeeId") != null){%>
				<li><a href="time_sheet.jsp">Time&nbsp;Sheet</a></li>
				<li><a href="time_expanses.jsp">Time&nbsp;Expenses</a></li>
				<li><a href="log_out.jsp">Log&nbsp;Out</a></li>
				<%} %>
				<div class="clear"></div>
			</ul>
		</div>	
		
			<div class="top-nav">
				<nav class="clearfix">
					<a href="#" id="pull"><img src="images/nav-icon.png" id="menu" alt="" /></a>
					<ul id="navigationMenu" >
								<!-- <li><a class="home" href="index.jsp"> <span>Home</span></a></li> -->
								<% if (session.getAttribute("employeeId") == null) { %>
								<li><a class="about" href="#"> <span>Login</span></a></li>
								<% } if (session.getAttribute("employeeId") != null) { %>
								<li><a class="services" href="time_sheet.jsp"> <span>Time&nbsp;Sheet</span></a></li>
								<li><a class="portfolio" href="time_expanses.jsp"> <span>Time&nbsp;Expenses</span></a></li>
								<li><a class="contact" href="log_out.jsp"> <span>Log&nbsp;Out</span></a></li>
								<% } %>
							</ul>
				</nav>
			</div>
		</div><br><br>
		<!-- start content -->
		<div class="main1">
			<div class="contact">
				<div class="contact-form">
					<div class="content"></div>
					<form method="post" action="ProjectCodeRequest_action.jsp">
						
						<div>
							<span><label>Project Name:</label></span> 
							<span><input name="pCode" id="pCode" type="text" class="textbox" autocomplete="off"></span>
						</div>
						<div>
							<span><label>Role Description:</label></span> 
							<span><input name="roleDes" id="roleDes" type="text" class="textbox" autocomplete="off"></span>
						</div>
						<div>
							<span><label>From Date:</label></span> 
							<span><input name="sDate" id="fromDate" type="date" class="textbox"></span>
						</div>
						<div>
							<span><label>To Date:</label></span> 
							<span><input name="eDate" id="toDate" type="date" class="textbox"></span>
						</div>
						<div align="center">
							<span><input type="submit" value="Submit" onclick="return DateCheck(); onSubmit();"></span>
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

<%	} catch (Exception e) {

	} finally {
		fieldAdminServer.closeConnection(fieldServer);
	}
%>