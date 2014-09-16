package com.pms;

import com.applix.tm1.TM1Bean;
import com.applix.tm1.TM1Server;

public class ConnectionManager {
/*	TM1Server fieldServer = null;
	TM1Bean fieldAdminServer = null; */
	

	public static TM1Server getConnection(String employeeId, String password) {

		TM1Server fieldServer = null;
		TM1Bean fieldAdminServer = null;
		try {

			fieldAdminServer = new TM1Bean();
			fieldAdminServer.setAdminHost("localhost");

			fieldServer = fieldAdminServer.openConnection("veracitiz",	employeeId, password);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return fieldServer;
	}
	
	public void   closeConnection(TM1Server fieldServer){
		
		
	/*	fieldAdminServer.closeConnection(fieldServer);
		return fieldServer; */
		
	}

}
