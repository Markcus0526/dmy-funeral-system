package com.damytech.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:37
 * File Name : CalendarUtility
 */
public class CalendarUtility {
	/**
	 * Method to convert date value to string with format specified with @format
	 *
	 * @param dtvalue
	 * @param format
	 * @return
	 */
	public static String date2String(Date dtvalue, String format) {
		String szResult = "";
		if (dtvalue == null)
			return "";

		try {
			DateFormat df = null;
			df = new SimpleDateFormat(format);
			szResult = df.format(dtvalue);
		} catch (Exception ex) {
			ex.printStackTrace();
			szResult = null;
		}

		return szResult;
	}


	/**
	 * Method to convert string to date value with format specified with @format
	 *
	 * @param szTime
	 * @param format
	 * @return
	 */
	public static Date string2Date(String szTime, String format) {
		if (szTime == null || szTime.equals("") || szTime.contains("0000-00-00"))
			return null;

		DateFormat df = new SimpleDateFormat(format);
		Date dtValue = null;

		try {
			dtValue = df.parse(szTime);
		} catch (Exception ex) {
			ex.printStackTrace();
			dtValue = null;
		}

		return dtValue;
	}



	public static String getCurrentTimeAsString(String format)
	{
		Calendar cal = Calendar.getInstance();
		String szTime = date2String(cal.getTime(), format);
		return szTime;
	}


	public static boolean isSameDates(Date dt1, Date dt2) {
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();

		cal1.setTime(dt1);
		cal2.setTime(dt2);

		return isSameDates(cal1, cal2);
	}


	public static boolean isSameDates(Calendar cal1, Calendar cal2) {
		if (cal1.get(Calendar.YEAR) != cal2.get(Calendar.YEAR))
			return false;

		if (cal1.get(Calendar.MONTH) != cal2.get(Calendar.MONTH))
			return false;

		if (cal1.get(Calendar.DAY_OF_MONTH) != cal2.get(Calendar.DAY_OF_MONTH))
			return false;

		return true;
	}


	public static boolean isSameTime(Calendar cal1, Calendar cal2) {
		if (!isSameDates(cal1, cal2))
			return false;

		if (cal1.get(Calendar.HOUR_OF_DAY) != cal2.get(Calendar.HOUR_OF_DAY))
			return false;

		if (cal1.get(Calendar.MINUTE) != cal2.get(Calendar.MINUTE))
			return false;

		if (cal1.get(Calendar.SECOND) != cal2.get(Calendar.SECOND))
			return false;

		if (cal1.get(Calendar.MILLISECOND) != cal2.get(Calendar.MILLISECOND))
			return false;

		return true;
	}


	public static int comparetTo(String szTime1, String szTime2)
	{
		Date date1 = null, date2 = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			date1 = dateFormat.parse(szTime1);
			date2 = dateFormat.parse(szTime2);
		} catch (ParseException e) {
			return -2;
		}

		return date1.compareTo(date2);
	}

	public static int comparetTo(Date time1, String szTime2)
	{
		Date date2 = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			date2 = dateFormat.parse(szTime2);
		} catch (ParseException e) {
			return -2;
		}

		long nDate1 = time1.getTime();
		nDate1 = nDate1 - nDate1 % 60000;
		time1.setTime(nDate1);

		return time1.compareTo(date2);
	}

}
