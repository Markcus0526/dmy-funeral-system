package com.damytech.utils;

import android.content.Context;
import android.graphics.Point;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;
import com.damytech.binzang.R;
import com.damytech.misc.AppCommon;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:38
 * File Name : ToastUtility
 */
public class ToastUtility {
	public static Toast gToast = null;


	/**
	 * Show toast in the center of the screen
	 *
	 * @param context The context to show the toast
	 * @param msg The message to show
	 */
	public static void showToast(Context context, String msg)
	{
		showToast(context, msg, Gravity.CENTER);
	}


	/**
	 * Show toast in the center of the screen
	 *
	 * @param context The context to show the toast
	 * @param strid The message resource id
	 */
	public static void showToast(Context context, int strid)
	{
		showToast(context, strid, Gravity.CENTER);
	}


	/**
	 * Show toast with the gravity in the screen
	 *
	 * @param context The context to show the toast
	 * @param strid The message resource id
	 * @param gravity The position to show the toast
	 * @see android.view.Gravity
	 */
	public static void showToast(Context context, int strid, int gravity)
	{
		String msg = context.getResources().getString(strid);
		showToast(context, msg, gravity);
	}


	/**
	 * Show the toast when app is in debug mode
	 *
	 * @param context The context to show the toast
	 * @param szMsg The message to show
	 * @see android.view.Gravity
	 */
	public static void showDebugToast(Context context, String szMsg) {
		if (!AppCommon.ISDEBUG())
			return;

		showToast(context, szMsg, Gravity.CENTER);
	}


	/**
	 * Show toast with the gravity in the screen
	 *
	 * @param context The context to show the toast
	 * @param msg The message to show
	 * @param gravity The position to show the toast
	 * @see android.view.Gravity
	 */
	public static void showToast(Context context, String msg, int gravity)
	{
		if (gToast != null)
			gToast.cancel();

		LayoutInflater inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		View view = inflater.inflate(R.layout.preset_custom_toast, null);

		TextView txtView = (TextView)view.findViewById(R.id.txt_message);
		txtView.setText(msg);

		gToast = new Toast(context);
		gToast.setView(view);

		Point ptSize = ResolutionUtility.getScreenSize(context);
		ResolutionUtility.instance.iterateChild(view, ptSize.x, ptSize.y);

		gToast.setDuration(Toast.LENGTH_LONG);
		if ((gravity & Gravity.BOTTOM) == Gravity.BOTTOM)
			gToast.setGravity(gravity, 0, ptSize.y * 1 / 5);
		else
			gToast.setGravity(gravity, 0, 0);
		gToast.show();
	}


	/**
	 * Show the system default text toast
	 *
	 * @param context
	 * @param toastStr
	 */
	public static void showTextToast(Context context, String toastStr) {
		if (gToast == null || gToast.getView().getWindowVisibility() != View.VISIBLE) {
			gToast = Toast.makeText(context, toastStr, Toast.LENGTH_LONG);
			gToast.show();
		}
	}


	/**
	 * Show custom toast with view
	 *
	 * @param context
	 * @param view
	 * @param gravity
	 */
	public static void showToastWithView(Context context, View view, int gravity) {
		if (gToast != null)
			gToast.cancel();

		gToast = new Toast(context);
		gToast.setView(view);

		Point ptSize = ResolutionUtility.getScreenSize(context);
		ResolutionUtility.instance.iterateChild(view, ptSize.x, ptSize.y);

		gToast.setDuration(Toast.LENGTH_LONG);
		if ((gravity & Gravity.BOTTOM) == Gravity.BOTTOM)
			gToast.setGravity(gravity, 0, ptSize.y * 1 / 5);
		else
			gToast.setGravity(gravity, 0, 0);
		gToast.show();
	}


}
