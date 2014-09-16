package com.pms;
import java.util.*;
import java.util.List;

public class ExpenseCategoryList {

	public String value;
	public String description;

	public ExpenseCategoryList(String value, String description) {
		this.value = value;
		this.description = description;

	}

	public static ExpenseCategoryList AIR_TRAVEL = new ExpenseCategoryList("Air Travel", "Air Travel");
	public static ExpenseCategoryList CONSULTING_FEES = new ExpenseCategoryList("Consulting Fees", "Consulting Fees");
	public static ExpenseCategoryList ELECTRICITY_EXPENSES = new ExpenseCategoryList("Electricity Expenses", "Electricity Expenses");
	public static ExpenseCategoryList HOTEL_GUEST_HOUSE_EXP = new ExpenseCategoryList("Hotel & Guest House Exp", "Hotel & Guest House Exp");
	public static ExpenseCategoryList IT_EXPENSES = new ExpenseCategoryList("IT Expenses", "IT Expenses");
	public static ExpenseCategoryList LOCAL_CONVEYANCE = new ExpenseCategoryList("Local Conveyance", "Local Conveyance");
	public static ExpenseCategoryList MISCELLANEOUS_EXPENSES = new ExpenseCategoryList("Miscellaneous Expenses", "Miscellaneous Expenses");
	public static ExpenseCategoryList NEWSPAPER_AND_PERIODICALS = new ExpenseCategoryList("Newspaper & Periodicals", "Newspaper & Periodicals");
	public static ExpenseCategoryList OFFICE_EXPENSES = new ExpenseCategoryList("Office Expenses", "Office Expenses");
	public static ExpenseCategoryList PER_DIEM = new ExpenseCategoryList("Per Diem", "Per Diem");
	public static ExpenseCategoryList POSTAGE_AND_COURIER_EXP = new ExpenseCategoryList("Postage & Courier Exp", "Postage & Courier Exp");
	public static ExpenseCategoryList PRINTING_AND_STATIONARY = new ExpenseCategoryList("Printing & Stationary", "Printing & Stationary");
	public static ExpenseCategoryList STAFF_WELFARE_EXP = new ExpenseCategoryList("Staff Welfare Exp", "Staff Welfare Exp");
	public static ExpenseCategoryList TEA_EXPENSES = new ExpenseCategoryList("Tea Expenses", "Tea Expenses");
	public static ExpenseCategoryList TELEPHONE_AND_COMMUNICATION_EXP = new ExpenseCategoryList("Telephone & Communication Exp", "Telephone & Communication Exp");
	public static ExpenseCategoryList WATER_EXPENSES = new ExpenseCategoryList("Water Expenses", "Water Expenses");
	public static ExpenseCategoryList SUBSCRIPTION_FEES = new ExpenseCategoryList("Subscription Fees", "Subscription Fees");
	
	public String getValue() {
		return value;
	}

	public String getDescription() {
		return description;
	}	
	
	public static List<ExpenseCategoryList> getList() {

		List<ExpenseCategoryList> list = new ArrayList<ExpenseCategoryList>();
		
		list.add(AIR_TRAVEL);
		list.add(CONSULTING_FEES);
		list.add(ELECTRICITY_EXPENSES);
		list.add(HOTEL_GUEST_HOUSE_EXP);
		list.add(IT_EXPENSES);
		list.add(LOCAL_CONVEYANCE);
		list.add(MISCELLANEOUS_EXPENSES);
		list.add(NEWSPAPER_AND_PERIODICALS);
		list.add(OFFICE_EXPENSES);
		list.add(PER_DIEM);
		list.add(POSTAGE_AND_COURIER_EXP);
		list.add(PRINTING_AND_STATIONARY);
		list.add(STAFF_WELFARE_EXP);
		list.add(TEA_EXPENSES);
		list.add(TELEPHONE_AND_COMMUNICATION_EXP);
		list.add(WATER_EXPENSES);
		list.add(SUBSCRIPTION_FEES);

		return list;

	}

}
