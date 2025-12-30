package com.damytech.utils;

import android.util.Log;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:59
 * File Name : MapUtility
 */
public class ZZZ_MiscUtility {
	/**
	 * Method to calculate the distance between two coordinates
	 *
	 * @param lat1
	 * @param lng1
	 * @param lat2
	 * @param lng2
	 * @return
	 */
	public static double calcDistanceKM(double lat1, double lng1, double lat2, double lng2) {
		double EARTH_RADIUS_KM = 6378.137;

		double radLat1 = Math.toRadians(lat1);
		double radLat2 = Math.toRadians(lat2);
		double radLng1 = Math.toRadians(lng1);
		double radLng2 = Math.toRadians(lng2);
		double deltaLat = radLat1 - radLat2;
		double deltaLng = radLng1 - radLng2;

		double distance = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(deltaLng / 2), 2)));

		distance = distance * EARTH_RADIUS_KM;

		return (int) (distance * 10) / 10;		// unit : km
	}


	/**
	 * Method to skip input stream. Android API method is not working correctly.
	 *
	 * @param stream
	 * @param nBytes
	 */
	public static void skipInputStream(InputStream stream, long nBytes) {
		long skippedTotal = 0;

		while (skippedTotal != nBytes) {
			try {
				long skipped = stream.skip(nBytes - skippedTotal);

				assert (skipped >= 0);

				skippedTotal += skipped;

				if (skippedTotal == nBytes)
					break;
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}


	/**
	 * Method to convert string array to list
	 *
	 * @param arrObjects
	 * @return
	 */
	public static List<String> stringArray2List(String[] arrObjects) {
		if (arrObjects == null)
			return null;

		List<String> listObjects = new ArrayList<String>();
		for (int i = 0; i < arrObjects.length; i++) {
			listObjects.add(arrObjects[i]);
		}

		return listObjects;
	}


	/**
	 * Method to convert object array to object list
	 *
	 * @param arrObjects
	 * @return
	 */
	public static List<Object> array2List(Object[] arrObjects) {
		if (arrObjects == null)
			return null;

		List<Object> listObjects = new ArrayList<Object>();
		for (int i = 0; i < arrObjects.length; i++) {
			listObjects.add(arrObjects[i]);
		}

		return listObjects;
	}

}

