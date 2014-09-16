package com.pms;
import com.applix.tm1.TM1Bean;
import com.applix.tm1.TM1Process;
import com.applix.tm1.TM1Server;
import com.applix.tm1.TM1Val;

public class ProjectCodeRequest {
	
	public static void projectCode(String pPcode, String pRoleDesc, String sDate,
			String eDate,String employeeId, String password) {

		TM1Bean fieldAdminServer = null;
		TM1Server fieldServer = null;
		try {
             
			fieldAdminServer = new TM1Bean();
			fieldAdminServer.setAdminHost("localhost");
			fieldServer = fieldAdminServer.openConnection("veracitiz", employeeId, password);
			if (fieldServer.isError()) {
				System.out.println("Couldn't connect to Admin Host: "
						+ fieldServer.getErrorMessage());
			} else {
			TM1Process ProCode = fieldServer.getProcess("API_SendNewPCRNotification");
			TM1Val Param = TM1Val.makeArrayVal(4);
			Param.addToArray(0, new TM1Val(pPcode));
			Param.addToArray(1, new TM1Val(pRoleDesc));
			Param.addToArray(2, new TM1Val(sDate));
			Param.addToArray(3, new TM1Val(eDate));
			ProCode.executeEx(Param);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			fieldAdminServer.closeConnection(fieldServer);
		}

	}

}
