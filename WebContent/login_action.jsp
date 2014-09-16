<%@page import="java.sql.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="com.applix.tm1.*"%>
<%@ page import="java.lang.String.*"%>
<%@ page import="com.pms.*"%>

<%
	try {
		String uname = request.getParameter("uname");
		String pass = request.getParameter("password");
		/* ConnectionManager.getConnection(uname, password); */
		TM1Server fieldServer = null;
		TM1Bean fieldAdminServer = null;

		/* TM1Bean fieldAdminServer; */
		
	 	fieldAdminServer = new TM1Bean();
		fieldAdminServer.setAdminHost("localhost");
		fieldServer = fieldAdminServer.openConnection("veracitiz",uname, pass); 
 
		if (fieldServer.isError()) {
			RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			request.setAttribute("msg",	"User name or password is incorrect.");
			rd.forward(request, response);
		} else {
			TM1Cube oCube;
			TM1Val elemTitles;

			TM1Val ret;
			TM1Dimension s1;
			TM1Dimension s2;
			oCube = fieldServer.getCube("}ElementAttributes_Resources");
			s1 = fieldServer.getDimension("Resources");
			s2 = fieldServer.getDimension("}ElementAttributes_Resources");

			if (oCube.isError()) {
				System.out.println(oCube.getErrorMessage());
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				request.setAttribute("msg","User name or password is incorrect.");
				rd.forward(request, response);
			} else {
				//get elementTitles
				elemTitles = TM1Val.makeArrayVal(oCube.getDimensionCount().getInt());
				//for each oDimension
				elemTitles.addToArray(s1.getElement(uname));
				elemTitles.addToArray(s2.getElement("Name"));

				ret = oCube.getCellValue(elemTitles);
				if (ret.isError()) {
					RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
					request.setAttribute("msg","User name or password is incorrect.");
					rd.forward(request, response);
				} else {
					String name = ret.getString();
					System.out.println("The employee Name is : "+ ret.getString());
			    	fieldAdminServer.closeConnection(fieldServer); 
					RequestDispatcher rd = request.getRequestDispatcher("time_sheet.jsp");
					 session.setAttribute("name", name);
					session.setAttribute("employeeId", uname);
					session.setAttribute("password", pass); 
					rd.forward(request, response);

				}
			}
		}

	} catch (Exception e) {

	}
%>


