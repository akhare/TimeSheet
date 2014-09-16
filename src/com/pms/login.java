package com.pms;

import com.applix.tm1.*;

public class login {

	public static void main(String[] args) {
		TM1Bean fieldAdminServer;
		TM1Server fieldServer;
		TM1Val oCube;
		fieldAdminServer = new TM1Bean();
		fieldAdminServer.setAdminHost("192.168.0.101");
		fieldServer = fieldAdminServer.openConnection("veracitiz", "Admin", "apple");
		if (fieldServer.isError())
		{
			System.out.println ("Couldn't connect to Admin Host: " + fieldServer.getErrorMessage());
		}
		else
		{
			System.out.println ("Connection Successful");
			oCube = fieldServer.getCubeCount();
			System.out.println ("The Total Cube count is "+oCube.getInt());
			TM1Val oDim = fieldServer.getDimensionCount();
			System.out.println ("The Total Dimension count is "+oDim.getInt());
			TM1Val oProcess = fieldServer.getProcessCount();
			System.out.println ("The Total Process count is "+oProcess.getInt());
			TM1Val oChores = fieldServer.getChoreCount();
			System.out.println ("The Total Chores count is "+oChores.getInt());
		
		}	
		
	}
}
