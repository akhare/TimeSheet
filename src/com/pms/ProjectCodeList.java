package com.pms;

import com.applix.tm1.TM1Bean;
import com.applix.tm1.TM1Cube;
import com.applix.tm1.TM1Server;
import com.applix.tm1.TM1Subset;
import com.applix.tm1.TM1Val;
import java.util.*;
import java.util.List;

public class ProjectCodeList {

	public static void main(String[] args) {
		System.out.println("Hello Anamika");
		List<String> a = getProjectList("7032", "8080977495","30/03/2014");
		for (String ans : a) {
			System.out.println(ans);
		}

	}

	public static List<String> getProjectList(String userName, String password, String eDate) {
		
		List<String> list = new ArrayList<String>();
		
		try{
		TM1Bean fieldAdminServer;
		TM1Server fieldServer;
		fieldAdminServer = new TM1Bean();
		fieldAdminServer.setAdminHost("localhost");
		fieldServer = fieldAdminServer.openConnection("veracitiz", userName, password);

		if (fieldServer.isError()) {
			System.out.println("Couldn't connect to Admin Host: "+ fieldServer.getErrorMessage());
		} else {
			System.out.println("Connection Successful");

			String listValue;
			String PList = userName + getAttribute(fieldServer.getCube("}ElementAttributes_t_Days"),eDate, "startdate").substring(0, 5);
			System.out.println("The List Element is: " + PList);

			TM1Subset TM1Sub = fieldServer.getDimension("Projects").getSubset(PList);

			for (int iCTR = 1; iCTR <= TM1Sub.getElementCount(); iCTR++) {
				listValue = TM1Sub.getElement(iCTR).getName().getString();

				listValue = getAttribute(fieldServer.getCube("}ElementAttributes_Projects"),listValue, TM1Sub.getAlias().getString());

				System.out.println("The List Element is: " + listValue);
				list.add(listValue);

			}

		}
		}catch(Exception e){
			
		}

		return list;
	}
	
	public static String getAttribute(TM1Cube oCube, String ELName,
			String ATTRName) {

		TM1Val elemTitles = null;

		elemTitles = TM1Val.makeArrayVal(oCube.getDimensionCount().getInt());

		elemTitles.addToArray(oCube.getDimension(1).getElement(ELName));
		elemTitles.addToArray(oCube.getDimension(2).getElement(ATTRName));

		return oCube.getCellValue(elemTitles).getString();
	}

}
