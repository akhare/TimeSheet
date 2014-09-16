package com.pms;

import com.applix.tm1.TM1Bean;
import com.applix.tm1.TM1Cube;
import com.applix.tm1.TM1Dimension;
import com.applix.tm1.TM1Process;
import com.applix.tm1.TM1Server;
import com.applix.tm1.TM1Val;

public class ApproveValidation {

	
	public static boolean isValid(String pcrNo) {
		boolean result = false;
		TM1Bean fieldAdminServer = null;
		TM1Server fieldServer = null;
		try {

			fieldAdminServer = new TM1Bean();
			fieldAdminServer.setAdminHost("localhost");
			fieldServer = fieldAdminServer.openConnection("veracitiz", "admin",	"Yahoo@123");

			if (fieldServer.isError()) {
				System.out.println("Couldn't connect to Admin Host: "
						+ fieldServer.getErrorMessage());
			} else {
				System.out.println("Connection Successful");

				TM1Cube oCube;
				TM1Dimension D1;
				TM1Dimension D2;
				TM1Val elemTitles = null;
				TM1Val ret;
				String val;

				oCube = fieldServer.getCube("ProjectCodeActivation");
				D1 = fieldServer.getDimension("Request ID");
				D2 = fieldServer.getDimension("m_ProjectCode");
				if (oCube.isError()) {
				} else {
					elemTitles = TM1Val.makeArrayVal(oCube.getDimensionCount().getInt());
					elemTitles.addToArray(D1.getElement(pcrNo));
					elemTitles.addToArray(D2.getElement("Approved"));
					ret = oCube.getCellValue(elemTitles);
					val = ret.getString();
					if ("yes".equalsIgnoreCase(val)) {
						result = true;
					}
				}
			}
		} catch (Exception e) {
		} finally {
			fieldAdminServer.closeConnection(fieldServer);
		}
		return result;

	}

	public static void process(String pcrNo, String sDate, String eDate,
			String pCode) {

		TM1Bean fieldAdminServer = null;
		TM1Server fieldServer = null;
		try {

			fieldAdminServer = new TM1Bean();
			fieldAdminServer.setAdminHost("localhost");
			fieldServer = fieldAdminServer.openConnection("veracitiz", "admin",	"Yahoo@123");
			TM1Process ProCode = fieldServer.getProcess("API_AssignProjectCode");
			TM1Val Param = TM1Val.makeArrayVal(4);
			Param.addToArray(0, new TM1Val(pcrNo));
			Param.addToArray(1, new TM1Val(sDate));
			Param.addToArray(2, new TM1Val(eDate));
			Param.addToArray(3, new TM1Val(pCode));
			ProCode.executeEx(Param);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			fieldAdminServer.closeConnection(fieldServer);
		}

	}
}
