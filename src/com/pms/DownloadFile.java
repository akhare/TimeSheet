package com.pms;

import com.applix.tm1.TM1Bean;
import com.applix.tm1.TM1Server;
import com.applix.tm1.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DownloadFile extends javax.servlet.http.HttpServlet implements	javax.servlet.Servlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		performTask(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		performTask(request, response);
	}

	private void performTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		TM1Bean fieldAdminServer = null;
		TM1Server fieldServer = null;
		FileInputStream fileInputStream = null;
		try {
			String filePath = null;
			String eDate = request.getParameter("eDate");
			String srNo = request.getParameter("srNo");

			HttpSession session = request.getSession();

			String employeeId = (String) session.getAttribute("employeeId");
			String password = (String) session.getAttribute("password");

			if ((employeeId == null || employeeId.equals(""))
					&& (password == null || password.equals(""))) {
				response.sendRedirect("index.jsp");
			}

			fieldAdminServer = new TM1Bean();
			fieldAdminServer.setAdminHost("localhost");

			fieldServer = fieldAdminServer.openConnection("veracitiz",
					employeeId, password);

			if (fieldServer.isError()) {

			} else {

				TM1Cube oCube;
				TM1Val elemTitles = null;				
				
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
					elemTitles = TM1Val.makeArrayVal(oCube.getDimensionCount().getInt());					

					elemTitles.addToArray(s1.getElement("Actual"));
					elemTitles.addToArray(s2.getElement(srNo));
					elemTitles.addToArray(s3.getElement("Expense"));
					elemTitles.addToArray(s4.getElement(eDate));
					elemTitles.addToArray(s5.getElement(employeeId));
					elemTitles.addToArray(s6.getElement("File Path"));					

					filePath = oCube.getCellValue(elemTitles).getString();
				}
			}
		
			if (filePath != null) {
				File file = new File(filePath);

				String extension = getFileExtension(filePath);
				DocumentType type = DocumentType.getDocumentType(extension);

				if (type != null) {
					response.setContentType(type.getContentType());
				}

				response.addHeader("Content-Disposition",
						"pms/pmsupload; filename=" + filePath);
				response.setContentLength((int) file.length());

				fileInputStream = new FileInputStream(file);
				OutputStream responseOutputStream = response.getOutputStream();
				int bytes;
				while ((bytes = fileInputStream.read()) != -1) {
					responseOutputStream.write(bytes);
				}
			}
		} catch (Exception e) {

		} finally {
			if (fileInputStream != null)
				fileInputStream.close();
		}

	}

	public static String getFileExtension(String filePath) {

		String extension = null;
		if (filePath != null) {
			int length = filePath.length();
			int i = filePath.lastIndexOf('.');
			i = i + 1;
			extension = filePath.substring(i, length);
		}
		return extension;
	}

}
