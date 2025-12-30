package com.damytech.misc;

import android.app.ActivityManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Environment;

import java.util.Iterator;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-2-4
 * Time: 上午11:27
 * To change this template use File | Settings | File Templates.
 */
public class AppCommon
{
	public static final boolean ISDEBUG() { return true; }
	public static final String getBaiduServiceKey() { return "H2YXYkU5a4lnM9EGM7W3GKKw"; }
	public static final String getBaiduMapSDKKey() { return "aB2N7R9buFVvLNPXapPtOBkY"; }
	public static final String getPreferenceName() { return "binzang_shared_pref"; }
	public static final int getPageItemCount() { return 10; }


	public static boolean isLoggedIn(Context appContext)
	{
		return loadUserIDLong(appContext) > 0;
	}


	public static void clearUserInfo(Context appContext)
	{
		saveUserName(appContext, "");
		saveUserType(appContext, -1);
		saveAccessToken(appContext, "");
		saveUserID(appContext, 0);
		saveUserType(appContext, -1);
		saveOfficeID(appContext, -1);
		saveOfficeName(appContext, "");
		saveUserPwd(appContext, "");
		saveUserPhone(appContext, "");
		saveAutoLoginFlag(appContext, false);
		saveRememberFlag(appContext, false);
		saveUserCityName(appContext, "");
		saveCoordinates(appContext, -1, -1);
	}


	public static boolean saveAutoLoginFlag(Context appContext, boolean bFlag)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putBoolean("autologinflag", bFlag);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}

	public static boolean loadAutoLoginFlag(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getBoolean("autologinflag", false);
	}


	public static boolean saveRememberFlag(Context appContext, boolean bFlag)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putInt("remember_pwd_flag", bFlag ? 1 : 0);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}

	public static boolean loadRememberFlag(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getInt("remember_pwd_flag", 0) == 1;
	}


	public static boolean saveUserName(Context appContext, String username)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("username", username);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}

	public static boolean saveUserRealName(Context appContext, String username)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("user_realname", username);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}


	public static String loadUserName(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("username", "");
	}

	public static String loadUserRealName(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("user_realname", "");
	}

	public static boolean saveAccessToken(Context appContext, String token)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("access_token", token);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}


	public static String loadAccessToken(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("access_token", "");
	}


	public static boolean saveUserID(Context appContext, long userid)
	{
		return saveUserID(appContext, "" + userid);
	}

	public static boolean saveUserID(Context appContext, String userid)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("userid", userid);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}


	public static long loadUserIDLong(Context appContext)
	{
		String szId = loadUserIDString(appContext);
		long result = 0;

		try {
			result = Long.parseLong(szId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}

	public static String loadUserIDString(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("userid", "");
	}


	public static boolean saveUserType(Context appContext, int user_type)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putInt("user_type", user_type);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}

	public static int loadUserType(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getInt("user_type", -1);
	}

	public static boolean saveOfficeID(Context appContext, long office_id)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putLong("office_id", office_id);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}

	public static long loadOfficeID(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getLong("office_id", -1);
	}


	public static boolean saveOfficeName(Context appContext, String office_name)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("office_name", office_name);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}

	public static String loadOfficeName(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("office_name", "");
	}



	public static boolean saveUserPwd(Context appContext, String pwd)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("password", pwd);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}


	public static String loadUserPwd(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("password", "");
	}


	public static boolean saveUserPhone(Context appContext, String phone)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("phone", phone);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}


	public static String loadUserPhone(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("phone", "");
	}


	public static boolean saveUserCityName(Context appContext, String cityname)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("city_name", cityname);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}


	public static String loadUserCityName(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("city_name", "");
	}


	public static boolean saveIDImageUrl(Context appContext, String imageUrl)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("id_image_url", imageUrl);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}


	public static String loadIDImageUrl(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		return prefs.getString("id_image_url", "");
	}


	public static String getDirPathForApplication()
	{
		return Environment.getExternalStorageDirectory() + "/" + getPreferenceName() + "/";
	}


	public static boolean saveCoordinates(Context appContext, double lat, double lng)
	{
		boolean bSuccess = true;
		SharedPreferences prefs = null;

		try
		{
			prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor edit = prefs.edit();
			edit.putString("latitude", "" + lat);
			edit.putString("longitude", "" + lng);
			edit.commit();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			bSuccess = false;
		}

		return bSuccess;
	}

	public static double loadLatitude(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		String szLat = prefs.getString("latitude", "0");
		if (szLat.equals(""))
			return 0;

		return Double.parseDouble(szLat);
	}


	public static double loadLongitude(Context appContext)
	{
		SharedPreferences prefs = appContext.getSharedPreferences(getPreferenceName(), Context.MODE_PRIVATE);
		String szLng = prefs.getString("longitude", "0");
		if (szLng.equals(""))
			return 0;

		return Double.parseDouble(szLng);
	}

}
