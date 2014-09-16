package com.pms;
import com.applix.tm1.*;
public class List {
            public static void main(String[] args) {
			TM1Bean fieldAdminServer;
			TM1Server fieldServer;
			fieldAdminServer = new TM1Bean();
			fieldAdminServer.setAdminHost("localhost");
			fieldServer = fieldAdminServer.openConnection("veracitiz", "admin", "apple");
		

			if (fieldServer.isError())
			{
				System.out.println ("Couldn't connect to Admin Host: " + fieldServer.getErrorMessage());
			}
			else
			{
				System.out.println ("Connection Successful");

				String ListValue;
				String PList = "7077"+GetAttribute(fieldServer.getCube("}ElementAttributes_t_Days"),"01/03/2014","startdate").substring(0,5);
				System.out.println ("The List Element is: "+ PList);
				
				
				TM1Subset TM1Sub = fieldServer.getDimension("Projects").getSubset(PList);
				
				
				for (int iCTR = 1; iCTR<=TM1Sub.getElementCount(); iCTR++){
					ListValue = TM1Sub.getElement(iCTR).getName().getString();
					
					ListValue = GetAttribute(fieldServer.getCube("}ElementAttributes_Projects"),ListValue,TM1Sub.getAlias().getString());
					
					System.out.println ("The List Element is: "+ ListValue);
					
				}
				
			}	
			
		}

		public static String GetAttribute(TM1Cube oCube, String ELName, String ATTRName) {
			
			TM1Val elemTitles = null;
			
			elemTitles = TM1Val.makeArrayVal(oCube.getDimensionCount().getInt());
			
			elemTitles.addToArray(oCube.getDimension(1).getElement(ELName));
			elemTitles.addToArray(oCube.getDimension(2).getElement(ATTRName));	
		
			return oCube.getCellValue(elemTitles).getString();
		}
	}

