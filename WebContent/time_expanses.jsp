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

   
		String action = request.getParameter("action");
		String eDate = request.getParameter("eDate");
		String tm = request.getParameter("tm"); 
		
		java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");
		String currentDate = df.format(new java.util.Date());
		
		if (eDate == null) {
			eDate = currentDate;
		}

		String employeeId = (String) session.getAttribute("employeeId");
		String password = (String) session.getAttribute("password");

		if ((employeeId == null || employeeId.equals(""))
				&& (password == null || password.equals(""))) {
			response.sendRedirect("index.jsp");
		}

		List<String> projectCodeList = new ArrayList<String>();

		String values[] = null;
		String modifyValues[] = null;
		List<String[]> finalVal = new ArrayList<String[]>(2);
		int count = 0;
		int countForDelete = 0;

		if (action == null) {
			action = "view";
		}
		if (action.equals("add") || action.equals("modify")) {
			projectCodeList = ProjectCodeList.getProjectList(employeeId, password, eDate);
		}
		fieldAdminServer = new TM1Bean();
		fieldAdminServer.setAdminHost("localhost");

		fieldServer = fieldAdminServer.openConnection("veracitiz", employeeId, password);

		if (fieldServer.isError()) {

		} else {

			TM1Cube oCube;
			TM1Val elemTitles = null;

			TM1Val ret;
			TM1Val TabCount;
			TM1Dimension s1;
			TM1Dimension s2;
			TM1Dimension s3;
			TM1Dimension s4;
			TM1Dimension s5;
			TM1Dimension s6;

			oCube = fieldServer.getCube("Time_Expenses");
			s1 = fieldServer.getDimension("Version");
			s2 = fieldServer.getDimension("SrNo");
			s3 = fieldServer.getDimension("Time_Expense");
			s4 = fieldServer.getDimension("t_Days");
			s5 = fieldServer.getDimension("Resources");
			s6 = fieldServer.getDimension("m_TimeExpense");

			if (oCube.isError()) {
			} else {
				elemTitles = TM1Val.makeArrayVal(oCube
						.getDimensionCount().getInt());

				System.out.println(">>>>>>>"
						+ oCube.getDimensionCount().getInt());

				elemTitles.addToArray(s1.getElement("Actual"));
				elemTitles.addToArray(s2.getElement("Total"));
				elemTitles.addToArray(s3.getElement("Expense"));
				elemTitles.addToArray(s4.getElement(eDate));
				elemTitles.addToArray(s5.getElement(employeeId));
				elemTitles.addToArray(s6.getElement("SRCOUNT"));
				TabCount = oCube.getCellValue(elemTitles);

				count = TabCount.getInt();
				countForDelete = count;
				count = count + 1;

				if (action.equalsIgnoreCase("view")) {

					for (int j = 2; j <= count; j++) {
						String fields[] = { "Project Code",
								"Bill Category", "Expense Category",
								"Expense (Rs)", "Remark", "Receipt",
								"File Path", "Approved" };
						values = new String[fields.length];
						elemTitles.setArrayVal(1, s2.getElement(j));
						for (int i = 0; i < fields.length; i++) {

							elemTitles.setArrayVal(5,
									s6.getElement(fields[i]));
							ret = oCube.getCellValue(elemTitles);
							if (ret.isError()) {
								values[i] = "";
							} else {
								String val = ret.getString();
								values[i] = val;
							}
						}
						finalVal.add(values);
					}
				}

				if (action.equalsIgnoreCase("modify")) {

					elemTitles.setArrayVal(1, s2.getElement(tm));

					String fields[] = { "Project Code",
							"Bill Category", "Expense Category",
							"Expense (Rs)", "Remark", "Receipt",
							"File Path" };
					modifyValues = new String[fields.length];

					for (int i = 0; i < fields.length; i++) {

						elemTitles.setArrayVal(5,
								s6.getElement(fields[i]));
						ret = oCube.getCellValue(elemTitles);

						if (ret.isError()) {
							modifyValues[i] = "";
						} else {
							String val = ret.getString();
							modifyValues[i] = val;
						}
						System.out.println("Modify Value: "
								+ modifyValues[i]);
					}

				}

				if (action.equals("delete")) {

					System.out.println("In delete action");

					TM1Process DelRecord = fieldServer
							.getProcess("Delet_Expenses_Record");
					TM1Val Param = TM1Val.makeArrayVal(4);
					double Val = new Double(tm);
					double countVal = new Double(countForDelete);
					Param.addToArray(0, new TM1Val(employeeId));
					Param.addToArray(1, new TM1Val(eDate));
					Param.addToArray(2, new TM1Val(Val));
					Param.addToArray(3, new TM1Val(countVal));
					DelRecord.executeEx(Param);

					action = "view";
					response.sendRedirect("time_expanses.jsp?action=view&eDate="
							+ eDate);

				}
			}
		}
%>

<!DOCTYPE HTML>
<html>
<head>
<title>Time Expanses - Veracitiz Solutions Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="The free Minima Iphone web template, Andriod web template, Smartphone web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href='http://fonts.googleapis.com/css?family=Josefin+Slab:400,700' rel='stylesheet' type='text/css' />
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(
hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- google fonts -->
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Pontano+Sans' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'>
<!-- end google fonts -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>

<script src="js/jquery.min.js"></script>
<script src="js/jquery-ui.js"></script> 
<script src="js/jquery.ui.accordion.js"></script>
<script type="text/javascript" src="js/jquery.datetimepicker.js"></script>




<script>

    function preventBack(){
        $( "#filePane" ).hide(); 
    	window.history.forward();
    	}

	$(function() {
		var pull = $('#menu');
		menu = $('nav ul');
		menuHeight = menu.height();
		
		jQuery( "#accordion" ).accordion( {
			<%if(action.equalsIgnoreCase("view")){%>	
			active: false, 
			<%}%>	
			autoheight:false,
			collapsible: true,
			alwaysOpen: false
	 });
		 var dv = document.getElementById("datepicker").value;
		 var action = document.getElementById("action").value;
		// alert(action);
		
	 	if((dv == null || dv == '') && action == 'view'){
		$( "#accordion" ).hide();	
		}else{
			$( "#accordion" ).show();	
		} 

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
		/* $( "#datepicker" ).datepicker({dateFormat: 'dd/mm/yy'}); */
		$('#datepicker').datetimepicker({format: 'd/m/Y'}).datetimepicker({step:10});
	});	 
	
	function formSubmit(){
	document.getElementById("mainForm").submit();
	} 
	
	function submit_form(tm) {
         try { 
        	 var result=confirm("Are you sure, Do you want to delete this record");
              	 if (result==true)
        	   {
             document.getElementById("tm").value = tm;
             document.getElementById("action").value = "delete";
             document.getElementById("mainForm").submit();
        	   }
         } catch(e) {
             alert(e);
         }
     }
	
	function validateForm() {
	    var inputDate = document.getElementById("datepicker").value;
	    
	    if (inputDate == null || inputDate == "") {
	        alert("Please select the date.");
	        return false;
	        
	    }
	}

	function add(){		
		window.location.href="time_expanses.jsp?action=add&eDate=<%= eDate != null ? eDate : currentDate %>";
		 return false;
	}
	
	function cancel() {		   
		window.location.href="time_expanses.jsp?action=view&eDate=<%= eDate%>"; 
		 return false;
	}
	
	function modify(srNo){		
		window.location.href="time_expanses.jsp?action=modify&eDate=<%=eDate%>&tm="+srNo; 
		 return false;
	}
	
	function showAttachment(){
		var receipt = document.getElementById("receipt").value;
		if(receipt == 'Yes'){
	      $( "#filePane" ).show();
		} else {
		  $( "#filePane" ).hide();	
		}
	}
	/* function show(){
		var a = document.getElementById("receipt").value;
		if (a == 'yes'){
			$("#filePane").show();
		}
	}
	
 */
 
 function download(srNo){
	
	 window.open ("DownloadFile?eDate=<%=eDate%>&srNo="+srNo) ;
 }
</script>
</head>
<body onload="preventBack(); showAttachment();">

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
				<li><a href="login.jsp">Login</a></li>
				<% }if(session.getAttribute("employeeId") != null){%>
				
				<li><a href="time_sheet.jsp">Time&nbsp;Sheet</a></li>
				<li class="active"><a href="time_expanses.jsp">Time&nbsp;Expenses</a></li>
				<li><a href="ProjectCodeRequest.jsp">PCR</a></li>
				<li><a href="log_out.jsp">Log&nbsp;Out</a></li>
				<%} %>
				<div class="clear"></div>
			</ul>
		</div>
			<div class="top-nav">
				<nav class="clearfix">
				
					<a href="#" id="pull"><img src="images/nav-icon.png" id="menu"	alt="" /></a>
					<ul id="navigationMenu">
						<!-- <li><a class="home" href="index.jsp"> <span>Home</span></a></li> -->
						<% if (session.getAttribute("employeeId") == null) { %>
						<li><a class="about" href="#"> <span>Login</span></a></li>
						<% } if (session.getAttribute("employeeId") != null) { %>
						<li><a class="about" href="ProjectCodeRequest.jsp"> <span>PCR</span></a>
					    <li><a class="services" href="time_sheet.jsp"> <span>Time&nbsp;Sheet</span></a></li>						
						<li><a class="contact" href="log_out.jsp"> <span>Log&nbsp;Out</span></a></li>
						<%} %>
					</ul>
				</nav>
			</div>
		</div>
		<!-- start content -->
		<div class="main1">
			<div class="contact">
				<div class="contact-form"><br><br>
					<div class="content"> 
						<h2>Time Expenses</h2>
					 </div> 
					<%	if (action.equalsIgnoreCase("view")) {	%>
					   <form action="time_expanses.jsp" id="mainForm" class="register" method="POST" >
					<% } else {	%>
						<form action="time_expanses_action.jsp" id="mainForm" class="register"	method="POST" enctype="multipart/form-data">
					<%	}%>
							<input type="hidden" name="action" id="action"	value="<%=action%>" />
							<input type="hidden" name="tm" id="tm"	value="<%=tm%>" /> 
							<input type="hidden" name="aDate" id="tm"	value="<%=eDate%>" /> 
							<input type="hidden" name="name" value="<%=session.getAttribute("name") != null ? session.getAttribute("name") : ""%>">
							<input type="hidden" name="userId" value="<%=session.getAttribute("employeeId") != null ? session.getAttribute("employeeId") : ""%>">

							<div>
								<span><label>Date :</label></span>	
								<% if (action.equalsIgnoreCase("view")) {%>							
								<span><input type="text" id="datepicker" name="eDate" value="<%=eDate != null ? eDate : currentDate %>"	<%if (action.equals("view")) {%> onchange="formSubmit();"<%}%>></span>
								<% } else {	%>
								<span><input type="text" id="datepicker" name="eDate" value="<%=eDate != null ? eDate : ""%>" disabled="disabled"></span>
								<input type="hidden" name="eDate" 	value="<%=eDate != null ? eDate : ""%>" /> 
								<%	} %>
							</div>

							<div id="accordion" class="st-accordion">

								<% if (action.equalsIgnoreCase("view") || (action.equalsIgnoreCase("add"))) {%>
								<% int j = 1;
								   for (Iterator iterator = finalVal.iterator(); iterator.hasNext();) {
										String ab[] = (String[]) iterator.next();
								%>
								<h3>
									<a href="#">Expense <%=j%><span class="st-arrow"></span></a>
								</h3>

								<div>								

									<span><label>Project Code</label></span> <label><input type="text" class="textbox" value="<%=ab[0] != null ? ab[0] : ""%>" disabled> </label>
									
									<span><label>Bill Categories</label></span><label><input type="text" class="textbox" value="<%=ab[1] != null ? ab[1] : ""%>" disabled></label>
									
									<span><label>Expense Category</label></span><label><input type="text" class="textbox" value="<%=ab[2] != null ? ab[2] : ""%>" disabled></label> 
									
									<span><label for="name">Expense(Rs)</label></span><label><input type="text" class="textbox" value="<%=ab[3] != null ? ab[3] : ""%>" disabled></label>
									
									<span><label for="name">Remark</label></span><label><input type="text" class="textbox" value="<%=ab[4] != null ? ab[4] : ""%>" disabled></label>
									
									<span><label for="name">Receipt</label></span><label><input type="text" class="textbox" value="<%=ab[5] != null ? ab[5] : ""%>" disabled></label>
									<% if(ab[5] != null && ab[5].equalsIgnoreCase("Yes")) {%>
									<span><label for="name">Attachment</label></span><label><img src="images/download.png" title="Download..." alt="Download" onclick="download(<%=j%>);"/></label>									
									<% } %>
									<%-- <a href="DownloadFile?eDate=<%= eDate%>&srNo=<%=j%>"> --%>
									<% if(ab[7] != null && (ab[7].equalsIgnoreCase("No") || ab[7].equalsIgnoreCase(""))) {%>
									<div style="text-align: center">
										<input type="submit" value="Modify" onclick="return modify(<%=j%>);" /> 
										<input type="submit" value="Delete" onclick="return submit_form(<%=j%>);" />
										<%-- <img src="images/buttons/deleteButton.png"	onclick="submit_form(<%=j%>)" /> --%>
									</div>
                                    <% } %>
								</div>
								<%	if (iterator.hasNext()) {j++;	} } }	%>
							</div>
							<%	if ((action.equalsIgnoreCase("add")) || (action.equalsIgnoreCase("modify"))) {	%>

				 				
							<div class="content">
								<h2>Expense <%=tm != null ? tm : count%></h2>
							</div>


							<div>
								<h4>Project Code</h4>

								<% if (action.equalsIgnoreCase("add")) {%>
								<select name="projectCode" id="select">
								<option> </option>
									<%	for (String pcode : projectCodeList) { %>
									<option value="<%=pcode%>"><%=pcode%></option>
									<% } %>
								</select>
								<% } else {  %>
								<select name="projectCode">
								<option> </option>
									<% for (String pcode : projectCodeList) { %>
									<option value="<%=pcode%>"
										<% if (pcode.equalsIgnoreCase(modifyValues[0])) { %>
										selected="selected" <%	} %>><%=pcode%>
									</option>
									<% } %>
								</select>
								<%	} %>
							</div>
							<div>
								<h4>Bill Categries</h4>

								<% if (action.equalsIgnoreCase("add")) {	%>
								<select name="billCategory">
									<option></option>
									<option value="Billable">Billable</option>
									<option value="Non-Billable">Non-Billable</option>
								</select>
								<% } else { %>
								<select name="billCategory">
									<option></option>
									<option value="Billable"
										<% if ("Billable".equalsIgnoreCase(modifyValues[1])) { %> selected="selected" <%	} %>>Billable
									</option>
									<option value="Non-Billable"
										<% if ("Non-Billable".equalsIgnoreCase(modifyValues[1])) { %> selected="selected" <%	} %>>Non-Billable
									</option>
								</select>
								<%	} %>
							</div>
							<div>
								<h4>Expense Category</h4>

								<% if (action.equalsIgnoreCase("add")) { %>
								<select name="expCategory">
								<option></option>
								<%	for (ExpenseCategoryList expenseCategory : ExpenseCategoryList.getList()) { %>
									<option value="<%=expenseCategory.getValue()%>"><%=expenseCategory.getDescription()%></option>
								<% } %>																
								</select>
								
								<% } else {  %>
								<select name="expCategory">
								    <option></option>
									<% for (ExpenseCategoryList expenseCategory : ExpenseCategoryList.getList()) { %>
									<option value="<%=expenseCategory.getValue()%>"
										<% if (expenseCategory.getValue().equalsIgnoreCase(modifyValues[2])) { %>
										selected="selected" <%	} %>><%=expenseCategory.getDescription()%>
									</option>
									<% } %>								
								</select>								
								<%	} %>
							</div>
							<div>
								<h4>Expense(Rs)</h4>

								<% if (action.equalsIgnoreCase("add")) { %>
								<input type="number" name="expense">
								<% } else { %>
								<input type="number" name="expense" value="<%=modifyValues[3]%>">
								<% 	} %>
							</div>
								<div>
								<h4>Remark</h4>

								<% if (action.equalsIgnoreCase("add")) { %>
								<input type="text" name="remark">
								<% } else { %>
								<input type="text" name="remark" value="<%=modifyValues[4]%>">
								<% 	} %>
							</div>
								<div>
								<h4>Receipt</h4>
							
								<%	if ((action.equalsIgnoreCase("add"))) {	%>
								<select name="receipt" id="receipt" onchange="showAttachment();">
									<option></option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>
								</select>
								<% } else { %>
								
								<select name="receipt" id="receipt" onchange="showAttachment();">								
									<option></option>
									<option value="Yes"
										<% if ("Yes".equalsIgnoreCase(modifyValues[5])) { %> selected="selected" <%	} %>>Yes
									</option>
									<option value="No"
										<% if ("No".equalsIgnoreCase(modifyValues[5])) { %> selected="selected" <%	} %>>No
									</option>
								</select>
								<%	} %>
								
								
							</div>						
							<div id="filePane">
								<h4>Attach Receipt</h4>
							
								<%	if ((action.equalsIgnoreCase("add")) ) {	%>
								<input type="file" name="filepath" value="Browes">							
								<% } else { %>
					           	<input type="file" name="filepath" value="Browes">	
					           	<input type="hidden" name="oldPath" id="oldPath"	value="<%=modifyValues[6]%>" /> 		
								<%	} %>
								
							</div>						

							<%	if (action.equals("modify")) {	%>
							<div style="text-align: center"><input type="submit" value="Update" />
							<input type="submit" value="Cancel" onclick="return cancel();" />
							</div>
							<%	} %>
							<% } %>
							<br> <br> 
							<div style="text-align: center">

								<%	if (action.equals("view")) {%>
								<input type="submit" value="Add" onclick="return add();" />
								<% } else if (!action.equals("modify")) { %>
								<input type="submit" value="Add"/>
							    <input type="submit" value="Cancel" onclick="return cancel();" />
								<% } %>

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
	e.printStackTrace();

	} finally {
		if(fieldAdminServer != null)
		fieldAdminServer.closeConnection(fieldServer); 
	}
%>