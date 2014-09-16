<%@ page import="com.pms.*"%>
<%@ page import="com.pms.ProjectCodeRequest"%>
<%


	try {
		String pCode = request.getParameter("pCode");
		String roleDes = request.getParameter("roleDes");
		String sDate = request.getParameter("sDate");
		String eDate = request.getParameter("eDate");
		
		String employeeId = (String) session.getAttribute("employeeId");
		String password = (String) session.getAttribute("password");
		
		

		ProjectCodeRequest.projectCode(pCode, roleDes, sDate, eDate, employeeId, password);
		
		response.sendRedirect("time_sheet.jsp?pCode="+pCode);
		
	} catch (Exception e) {

	} 
%>
	
	