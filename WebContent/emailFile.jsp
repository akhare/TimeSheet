<%@page import="sun.org.mozilla.javascript.internal.regexp.SubString"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="com.applix.tm1.*"%>
<%@ page import="java.lang.String.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pms.*"%>
<% 
String pcrNo = request.getParameter("pcrNo");
String name = request.getParameter("name");
String pName = request.getParameter("pName");
String roleDes = request.getParameter("roleDes");
String sDate = request.getParameter("sDate");
String eDate = request.getParameter("eDate");
String pCode = request.getParameter("pCode");


%>
<!DOCTYPE HTML>
<html>
<head>
<title>Veracitiz Solutions Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="The free Minima Iphone web template, Andriod web template, Smartphone web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(
hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
<script src="js/jquery.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery.datetimepicker.js"></script>
<script type="text/javascript">


	$(function() {		
		$('#sdatepicker').datetimepicker({format: 'd/m/Y'}).datetimepicker({step:10});
		$('#edatepicker').datetimepicker({format: 'd/m/Y'}).datetimepicker({step:10});
	});	

</script>
</head>
<body>
	<!-- <div class="body"> -->
		<!-- <div class="wrap"> -->

	<div class="logo">
		<a href="#"><img src="images/logo4.png" alt=""></a>
	</div><br>
	 <div class="top-nav">
		  <nav class="clearfix">
			<a href="#" id="pull"></a>
			<!-- <ul id="navigationMenu">
				<li><a class="home" href="index.jsp"> <span>Home</span></a></li>
			</ul> -->
		</nav>
	</div>
<!-- 		</div> -->
		<!-- start content -->
		<div class="main1">
	<div class="contact">
		<div class="contact-form">			
			
				<div>
					<span><label>PCR No.</label></span> 
					<span><input name="pcrNo" type="text" value="<%= pcrNo != null ? pcrNo : ""%>" class="textbox" disabled="disabled"></span>
					
				</div>
				<div>
					<span><label>Name</label></span> 
					<span><input name="name" value="<%= name != null ? name : ""%>" type="text" class="textbox" disabled="disabled"></span>
					 </div>
				<div>
					<span><label>Project Name</label></span> 
					<span><input name="pName" type="text" value="<%= pName != null ? pName : "" %>" class="textbox" disabled="disabled"></span>
				</div>
				<div>
					<span><label>Role Description</label></span> 
					<span><input name="rDes" type="text" value="<%= roleDes != null ? roleDes : "" %>" class="textbox" disabled="disabled"></span>
				</div>
			
				<div>
					<span><label> Start Date</label></span>	
					<span><input type="text" id="sdatepicker" name="sDate" value="<%= sDate != null ? sDate : "" %>"	></span>
				</div>
				<div>
					<span><label>End Date</label></span> 
					<span><input type="text" id="edatepicker" name="eDate" value="<%= eDate != null ? eDate : "" %>"	></span>
				</div>
				<div>
					<span><label>Project Code</label></span> 
					<select name="pCode"id="select">
						<%	for (String pcode : ProjectCodeListFile.getProjectList()) {	%>
						<option value="<%=pcode%>"><%=pcode%></option>
						<% } %>
					</select>
				</div>
				<div align="center">
					<span><input type="submit" value="Approved"></span>
				</div>
			<!-- </form> -->
		</div>
		<div class="clear"></div>
	</div>
		</div>
	</div>
</body>
</html>
