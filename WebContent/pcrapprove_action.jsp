<%@ page import="com.pms.*"%>
<%
	
	
	try {
		String pcrNo = request.getParameter("pcrNo");
		String sDate = request.getParameter("sDate");
		String eDate = request.getParameter("eDate");
		String pCode = request.getParameter("pCode");
		String name = request.getParameter("name");
		String pName = request.getParameter("pName");
		String roleDes = request.getParameter("roleDes");
	
		boolean isValid = ApproveValidation.isValid(pcrNo);
		if (isValid) {
			response.sendRedirect("pcrapprove.jsp?pcrNo="
					+ pcrNo
					+ "&name="
					+ name
					+ "&pName="
					+ pName
					+ "&roleDes="
					+ roleDes
					+ "&sDate="
					+ sDate
					+ "&eDate="
					+ eDate
					+ "&pCode="
					+ pCode
					+ "&alertmsg=PCR has already been approved &action=view");

		} else {

			ApproveValidation.process(pcrNo, sDate, eDate, pCode);

			response.sendRedirect("pcrapprove.jsp?pcrNo="
					+ pcrNo
					+ "&name="
					+ name
					+ "&pName="
					+ pName
					+ "&roleDes="
					+ roleDes
					+ "&sDate="
					+ sDate
					+ "&eDate="
					+ eDate
					+ "&pCode="
					+ pCode
					+ "&msg=PCR processed successfully &action=view");

		}
	} catch (Exception e) {

	} 
%>





