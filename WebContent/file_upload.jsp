<%@ page import="com.pms.*"%>
<%
	try {

		String employeeId = (String) session.getAttribute("employeeId");
		String password = (String) session.getAttribute("password");
		System.out.println("In file upload");

		FileUpload.uploadFile(request, employeeId);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>