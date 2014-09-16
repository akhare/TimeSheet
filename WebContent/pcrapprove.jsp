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
String msg = request.getParameter("msg");
String alertmsg = request.getParameter("alertmsg");
String action = request.getParameter("action");

boolean isValid = ApproveValidation.isValid(pcrNo);

%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Veracitiz Solutions Pvt. Ltd.</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap-theme.min.css">


<script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/jquery.ui.draggable.js" type="text/javascript"></script>    
    <script src="js/jquery.alerts.js" type="text/javascript"></script>
    <link href="css/jquery.alerts.css" rel="stylesheet" type="text/css" media="screen" /> 
    
    
   <!--  <script src="js/bootstrap.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <link href="css/bootstrap-responsive.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" media="screen" />
 -->

<style type="text/css">
 body {
	background-color: #eee;
} 

input:invalid {
	border-color: #b94a48;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
}

input:valid {
	border-color: #468847;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
}
</style>



<script type="text/javascript">

$(document).ready( function() {

	 <%if(msg != null){%>		
        jAlert('success', 'PCR processed successfully', 'Success');
        myWindow.close();
	<%}%>  
	
	<%if(isValid){%>		
       jAlert('info', 'PCR has already been approved', 'Info'); 
       /* BootstrapDialog.show({
            message: 'Hi Apple!'
        }); */
         
     myWindow.close();
	<%}%>  
	 
});  
 

</script>  


</head>
<body>


	<div class="container">
		<div class="logo">
			<a href="#"><img src="images/logo4.png" alt=""></a>
		</div>
		<br>


		<form class="form-bridge" action="pcrapprove_action.jsp" method="POST">            
			<div class="form-group">
				<label for="pcrno">PCR No.</label> 
				<input type="text" class="form-control" id="pcrNo"	value="<%= pcrNo != null ? pcrNo : ""%>" disabled="disabled">
				<input type="hidden" name="pcrNo" value="<%= pcrNo != null ? pcrNo : ""%>" />
			</div>

			<div class="form-group">
				<label for="name">Name</label> 
				<input type="text" class="form-control" id="name"	value="<%= name != null ? name : ""%>" disabled="disabled">
				<input type="hidden" name="name" value="<%= name != null ? name : ""%>" />
				<span class="help-block"></span>
			</div>

			<div class="form-group">
				<label for="pname">Project Name</label>
				 <input type="text"	class="form-control" id="pname"	value="<%= pName != null ? pName : "" %>" disabled="disabled">
				 <input type="hidden" name="pName" value="<%= pName != null ? pName : "" %>" />
				<span class="help-block"></span>
			</div>

			<div class="form-group">
				<label for="pcrno">Role Description</label> <input type="text"
					class="form-control" id="roleDes"
					value="<%= roleDes != null ? roleDes : "" %>" disabled="disabled">
					<input type="hidden" name="roleDes" value="<%= roleDes != null ? roleDes : "" %>" />
				<span class="help-block"></span>
			</div>
           <div class="form-group">
				<label for="pcrno">Start Date</label> <input type="date"
					class="form-control" id="roleDes"
					value="<%= sDate != null ? sDate : "" %>" <%if(isValid){%> disabled="disabled"> <%}%>
					
					<input type="hidden" name="sDate" value="<%= sDate != null ? sDate : "" %>" />
				<span class="help-block"></span>
			</div>			
			
			
			
            <div class="form-group">
				<label for="edate">End Date</label> <input type="date"
					class="form-control" id="eDate" name="eDate"
					value="<%= eDate != null ? eDate : "" %>" required autofocus
					autocomplete="on" <%if(isValid){%>
				 disabled="disabled">
				<%}%>
					

					 <span class="help-block"></span>
 					<input type="hidden" name="eDate" value="<%= eDate != null ? eDate : "" %>" />
			</div>
			<%if(isValid){%>				
					
			<%}else{ %>
			<div class="form-group">
				<label for="pCode">Project Code</label> <input type="text"
					class="form-control" id="pCode" name="pCode" list="SelectCode" autocomplete="off"> <span
					class="help-block"></span>
				<datalist id="SelectCode">
					<%	for (String pcode : ProjectCodeListFile.getProjectList()) {	%>
					<option value="<%=pcode%>"><%=pcode%></option>
					<% } %>
				</datalist>
			</div>
         <% } %>
	
	
	     <%if(isValid){%>
				<%}else{ %>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Assign
				Project</button>
				<% } %>
		</form>

	</div>
	<!-- /container -->
</body>
</html>
