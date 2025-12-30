package com.damytech.utils;

import android.app.ActivityManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.Uri;

import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:49
 * File Name : AppUtility
 */
public class AppUtility {
	/**
	 * Method to open dial activity
	 *
	 * @param phoneNum
	 * @param activityContext
	 * @return
	 */
	public static boolean openDialPad(String phoneNum, Context activityContext) {
		boolean bResult = true;

		try {
			Intent intent = new Intent();
			intent.setAction("android.intent.action.DIAL");
			intent.setData(Uri.parse("tel:" + phoneNum));
			activityContext.startActivity(intent);
		} catch (Exception ex) {
			ex.printStackTrace();
			bResult = false;
		}

		return bResult;
	}


	/**
	 * Method to call phone
	 *
	 * @param phoneNum
	 * @param appContext
	 * @return
	 */
	public static boolean callPhone(String phoneNum, Context appContext) {
		boolean bResult = true;

		try {
			Intent intent = new Intent(Intent.ACTION_CALL);
			intent.setData(Uri.parse("tel:" + phoneNum));
			intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
			appContext.startActivity(intent);
		} catch (Exception ex) {
			ex.printStackTrace();
			bResult = false;
		}

		return bResult;
	}


	/**
	 * Method to open SMS activity
	 * @param msg
	 * @param appContext
	 * @return
	 */
	public static boolean openSMSApp(String msg, Context appContext) {
		boolean bResult = true;

		try {
			Intent smsIntent = new Intent(Intent.ACTION_VIEW);

			smsIntent.setData(Uri.parse("sms:"));
			smsIntent.putExtra("sms_body", msg == null ? "" : msg);

			appContext.startActivity(smsIntent);
		} catch (Exception ex) {
			ex.printStackTrace();
			bResult = false;
		}

		return bResult;
	}


	/**
	 * Method to detect if QQ is installed
	 *
	 * @param appContext
	 * @return
	 */
	public static boolean IsQQInstalled(Context appContext) {
		return IsAppInstalled(appContext, "com.tencent.mobileqq");
	}


	/**
	 * Method to open other application
	 *
	 * @param context
	 * @param pack_name
	 */
	public static void openApp(Context context, String pack_name) {
		PackageManager pm = context.getPackageManager();
		Intent intent = pm.getLaunchIntentForPackage(pack_name);
		context.startActivity(intent);
	}


	/**
	 * Method to check if app is installed
	 *
	 * @param appContext
	 * @param packname
	 * @return
	 */
	public static boolean IsAppInstalled(Context appContext, String packname) {
		return getAppVersionName(appContext, packname) != null;
	}


	/**
	 * Method to get application version name from package name
	 *
	 * @param appContext
	 * @param packname
	 * @return
	 */
	public static String getAppVersionName(Context appContext, String packname) {
		PackageManager pm = appContext.getPackageManager();
		String versionName = null;

		try {
			PackageInfo packageInfo = pm.getPackageInfo(packname, PackageManager.GET_ACTIVITIES);
			versionName = packageInfo.versionName;
		} catch (PackageManager.NameNotFoundException ex) {
			versionName = null;
		}


		return versionName;
	}


	public static boolean isAppBackgroundMode(Context appContext)
	{
		ActivityManager am = (ActivityManager) appContext.getSystemService(Context.ACTIVITY_SERVICE);
		List<ActivityManager.RunningTaskInfo> tasks = am.getRunningTasks(1);
		if (!tasks.isEmpty())
		{
			ComponentName topActivity = tasks.get(0).topActivity;
			if (!topActivity.getPackageName().equals(appContext.getPackageName()))
				return true;
		}

		return false;
	}

}
