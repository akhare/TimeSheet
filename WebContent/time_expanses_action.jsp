<%@page import="java.util.Date"%>
<%@page import="sun.org.mozilla.javascript.internal.regexp.SubString"%>
<%@page import="java.sql.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="com.applix.tm1.*"%>
<%@ page import="java.lang.String.*"%>
<%@ page import="com.pms.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File"%>
<%@ page import="java.util.*" %>

<%
	TM1Bean fieldAdminServer = null;
	TM1Server fieldServer = null;
	try {
	    /* MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);  */
	    /* MultipartRequest mrequest = new MultipartRequest( request, ""); */
	    
	    /* 
	     String rtempfile = File.createTempFile("d:/temp","1").getParent();   
	    MultipartRequest mrequest = new MultipartRequest(request, rtempfile, 900000 * 1024);  */      
	  
/* 
		String projectCode = request.getParameter("projectCode");
		String billCategory = request.getParameter("billCategory");
		String expCategory = request.getParameter("expCategory");
		String expense = request.getParameter("expense");
		String remark = request.getParameter("remark");
		String receipt = request.getParameter("receipt");
		String action = request.getParameter("action");
		String eDate = request.getParameter("eDate");  */

		String employeeId = (String) session.getAttribute("employeeId");
		String password = (String) session.getAttribute("password");
		
		
		try {
			System.out.println("In file upload");

			FileUpload.uploadFile(request, employeeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    String projectCode = FileUpload.projectCode;
		String billCategory = FileUpload.billCategory;
		String expCategory = FileUpload.expCategory;
		String expense = FileUpload.expense;
		String remark = FileUpload.remark;
		String receipt = FileUpload.receipt;
		String action = FileUpload.action;
		String eDate = FileUpload.eDate; 
		String filePath = FileUpload.fullFilePath;
		
		System.out.println("filePath >>"+filePath);

		String values[] = null;
		int sectioncount = 0;

		if (action == null) {
			action = "view";
		}

		fieldAdminServer = new TM1Bean();
		fieldAdminServer.setAdminHost("localhost");

		fieldServer = fieldAdminServer.openConnection("veracitiz",
				employeeId, password);

		if (fieldServer.isError()) {

		} else {

			TM1Cube oCube;
			TM1Val tabCount;
			TM1Val elemTitles = null;
			int count = 0;
			TM1Val ret = null;

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

				//for each oDimension

				elemTitles.addToArray(s1.getElement("Actual"));
				elemTitles.addToArray(s2.getElement("Total"));
				elemTitles.addToArray(s3.getElement("Expense"));
				elemTitles.addToArray(s4.getElement(eDate));
				elemTitles.addToArray(s5.getElement(employeeId));
				elemTitles.addToArray(s6.getElement("SRCOUNT"));

				tabCount = oCube.getCellValue(elemTitles);
				count = tabCount.getInt();
				count = count + 2;
				System.out.println(count); 

				String fields[] = { "Project Code", "Bill Category",
						"Expense Category", "Expense (Rs)", "Remark",
						"Receipt","File Path", "SRCOUNT"};

				if (action.equals("add")) {

					System.out.println("In Add action");

					/* 	  	  try{
							 System.out.println("In file upload");
						
						FileUpload.uploadFile(req, employeeId);
						} catch(Exception e){
							e.printStackTrace();
						}  */

					elemTitles.setArrayVal(1, s2.getElement(count));
					String values1[] = { projectCode, billCategory,
							expCategory, expense, remark, receipt, filePath, "1" };

					for (int i = 0; i < fields.length; i++) {

						elemTitles.setArrayVal(5,
								s6.getElement(fields[i]));

						if (fields[i].equals("Expense (Rs)")
								|| fields[i].equals("SRCOUNT")) {
							double doubleVal = new Double(values1[i]);
							ret = oCube.setCellValue(elemTitles,
									new TM1Val(doubleVal));
						} else {
							ret = oCube.setCellValue(elemTitles,
									new TM1Val(values1[i]));
						}
					}

					response.sendRedirect("time_expanses.jsp?action=view&eDate="+ eDate);
				}

				if (action.equals("modify")) {

					System.out.println("In modify action");
					/* String tm = request.getParameter("tm"); */
					String tm = FileUpload.tm;

					elemTitles.setArrayVal(1, s2.getElement(tm));
					String values1[] = { projectCode, billCategory,
							expCategory, expense, remark, receipt, filePath, "1" };

					for (int i = 0; i < fields.length; i++) {

						elemTitles.setArrayVal(5,
								s6.getElement(fields[i]));

						if (fields[i].equals("Time (Hrs)")
								|| fields[i].equals("SRCOUNT")) {
							double doubleVal = new Double(values1[i]);
							ret = oCube.setCellValue(elemTitles,
									new TM1Val(doubleVal));
						} else {
							ret = oCube.setCellValue(elemTitles,
									new TM1Val(values1[i]));
						}
					}

					response.sendRedirect("time_expanses.jsp?action=view&eDate="
							+ eDate);

				}
			}
		}
	} catch (Exception e) {

	} finally {
		fieldAdminServer.closeConnection(fieldServer);
	}
%>
