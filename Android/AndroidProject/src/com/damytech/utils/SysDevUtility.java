package com.damytech.utils;

import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.os.Build;
import android.os.Environment;
import android.provider.Settings;
import android.telephony.TelephonyManager;

import java.io.File;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:39
 * File Name : SystemUtility
 */
public class SysDevUtility {
	/**
	 * Method to get current android system version
	 *
	 * @param appContext
	 * @return
	 */
	public static int getSystemVersion(Context appContext) {
		int nVersion = 0;

		try {
			nVersion = Build.VERSION.SDK_INT;
		} catch (Exception ex) {
			ex.printStackTrace();
			nVersion = -1;
		}

		return nVersion;
	}


	/**
	 * Method to get current app version code
	 *
	 * @param appContext
	 * @return
	 */
	public static int getCurAppVersionCode(Context appContext) {
		int nVersion = 0;

		try {
			PackageInfo pInfo = appContext.getPackageManager().getPackageInfo(appContext.getPackageName(), 0);
			nVersion = pInfo.versionCode;
		} catch (Exception ex) {
			ex.printStackTrace();
			nVersion = -1;
		}

		return nVersion;
	}


	/**
	 * Method to get currrent app version name
	 *
	 * @param appContext
	 * @return
	 */
	public static String getCurAppVersionName(Context appContext) {
		String szPack = "";

		try {
			PackageInfo pInfo = appContext.getPackageManager().getPackageInfo(appContext.getPackageName(), 0);
			szPack = pInfo.versionName;
		} catch (Exception ex) {
			ex.printStackTrace();
			szPack = "";
		}

		return szPack;
	}


	/**
	 * Method to check if external storage is removable
	 *
	 * @return
	 */
	public static boolean isExternalStorageRemovable() {
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD)
			return Environment.isExternalStorageRemovable();

		return true;
	}


	/**
	 * Method to get external cache directory path
	 *
	 * @param context
	 * @return
	 */
	public static File getExternalCacheDir(Context context) {
		File retFile = null;
		if (hasExternalCacheDir()) {
			retFile = context.getExternalCacheDir();
		}

		if (retFile == null) {
			// Before "Froyo" we need to construct the external cache dir ourselves
			String cacheDir = "/Android/data/" + context.getPackageName() + "/cache/";
			retFile = new File(Environment.getExternalStorageDirectory().getPath() + cacheDir);
		}

		return retFile;
	}


	/**
	 * Method to check if current system supports external cache directory
	 *
	 * @return
	 */
	public static boolean hasExternalCacheDir() {
		return Build.VERSION.SDK_INT >= Build.VERSION_CODES.FROYO;
	}


	/**
	 * Method to get device IMEI number
	 *
	 * @param context
	 * @return
	 */
	public static String getDeviceIMEI(Context context) {
		TelephonyManager tm = (TelephonyManager) context.getSystemService(context.TELEPHONY_SERVICE);
		return tm.getDeviceId();
	}


	/**
	 * Method to get the total size of the directory
	 *
	 * @param directory
	 * @return
	 */
	public static long getFolderSize(File directory) {
		long length = 0;

		for (File file : directory.listFiles()) {
			if (file.isFile())
				length += file.length();
			else
				length += getFolderSize(file);
		}

		return length;
	}



	public static long getCurAvailableMemory(Context appContext)
	{
		ActivityManager.MemoryInfo mi = new ActivityManager.MemoryInfo();
		ActivityManager activityManager = (ActivityManager)appContext.getSystemService(appContext.ACTIVITY_SERVICE);
		activityManager.getMemoryInfo(mi);

		return mi.availMem;
	}


	public static String getAndroidID(Context context) {
		String id = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ANDROID_ID);

		if (id == null)
			id = "";

		return id;
	}
}
