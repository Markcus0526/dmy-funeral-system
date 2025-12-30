package com.damytech.binzang.activities.preset;


import android.app.ActivityManager;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Point;
import android.graphics.Rect;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.NotificationCompat;
import android.view.*;
import android.widget.FrameLayout;
import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.damytech.binzang.R;
import com.damytech.binzang.application.MainApplication;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.binzang.dialogs.preset.CommonProgressDialog;
import com.damytech.misc.AppCommon;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;
import com.damytech.utils.UIUtility;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.display.FadeInBitmapDisplayer;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;


/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-7-29
 * Time: 上午8:43
 * To change this template use File | Settings | File Templates.
 */
public abstract class SuperActivity extends FragmentActivity
{
	/**
	 * Class for the activity transition animation constants
	 */
	public class AnimConst {
		public static final int ANIMDIR_NONE			= -1;
		public static final int ANIMDIR_FROM_LEFT		= 0;
		public static final int ANIMDIR_FROM_RIGHT		= 1;

		public static final String EXTRA_ANIMDIR		= "anim_direction";
	}



	/**
	 * Image loader display options variable
	 */
	public DisplayImageOptions loader_options;


	/**
	 * Keyboard shown variable
	 */
	private boolean isKeyboardShown = false;


	/**
	 * Used for the progress dialog
	 */
	public CommonProgressDialog dlg_prog	= null;


	/**
	 * Variables to show progress in notification area
	 */
	public NotificationManager def_notify_manager = null;
	protected static int cur_notify_id = 1;
	protected ArrayList<NotificationCompat.Builder> arrNotifyBuilders = new ArrayList<NotificationCompat.Builder>();


	/**
	 * If current activity is the last activity in activity stack,
	 * and the user wants to finish the app,
	 * it is requested to click system back button twice in 3 seconds(3000 milliseconds).
	 */
	private final int PRESS_BACK_INTERVAL_LIMIT			= 3000;
	private long backPressedTime						= 0;
	////////////////////////////////////////////////////////////////////////////////////////////


	/**
	 * Variables for the baidu location updating.
	 */
	public LocationClient location_client = null;
	public MyLocationListener location_listener = new MyLocationListener();


	/**
	 * Method to initialize location client of the baidu.
	 */
	public void initLocMgr() {
		if (location_client != null) {
			location_client.stop();
			location_client = null;
		}

		location_client = new LocationClient(SuperActivity.this.getApplicationContext());
		location_client.registerLocationListener(location_listener);

		LocationClientOption option = new LocationClientOption();
		{
			option.setLocationMode(LocationClientOption.LocationMode.Hight_Accuracy);
			option.setAddrType("all");
			option.setCoorType("bd09ll");
			option.setScanSpan(1000);
			option.setIsNeedAddress(true);
			option.setNeedDeviceDirect(true);
			option.setOpenGps(true);
		}

		location_client.setLocOption(option);
	}


	public void startLocationUpdate() {
		if (location_client == null)
			initLocMgr();

		location_client.start();
	}


	public void stopLocationUpdate() {
		if (location_client == null)
			return;

		location_client.stop();
	}


	// When update the app, at first download the new apk file.
	// The temporary file path for the apk.
	private String download_app_path					= "";


	// Variable to save the top activity instance
	public static SuperActivity top_instance = null;


	/**
	 * Normally this method is for the creation of the activity and setting the content view.
	 * If you extends the SuperActivity class, it is requested to override initializeActivity() method.
	 * In this method, you can initialize the controls in the activity.
	 *
	 * @param savedInstanceState
	 * @param layout_id
	 */
	protected void onCreate(Bundle savedInstanceState, int layout_id) {
		super.onCreate(savedInstanceState);
		setContentView(layout_id);

		initializeSuperActivity();
	}


	/**
	 * Method to progress super activity initialize
	 */
	protected void initializeSuperActivity() {
		// Initialize for the image loader
		ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(this)
				.build();
		ImageLoader.getInstance().init(config);

		loader_options = new DisplayImageOptions.Builder()
				.showImageForEmptyUri(R.drawable.preset_def_image)
				.showImageOnFail(R.drawable.preset_def_image)
				.showImageOnLoading(R.drawable.preset_def_image)
				//.resetViewBeforeLoading()
				.cacheOnDisk(true)
				//.imageScaleType(ImageView.ScaleType.CENTER_INSIDE)
				.bitmapConfig(Bitmap.Config.RGB_565)
				.displayer(new FadeInBitmapDisplayer(300))
				.build();


		/**
		 "http://site.com/image.png"					// from Web
		 "file:///mnt/sdcard/image.png"					// from SD card
		 "file:///mnt/sdcard/video.mp4"					// from SD card (video thumbnail)
		 "content://media/external/images/media/13"		// from content provider
		 "content://media/external/video/media/13"		// from content provider (video thumbnail)
		 "assets://image.png"							// from assets
		 "drawable://" + R.drawable.img					// from drawables (non-9patch images)
		 */


		// To catch unhandled exceptions and log messages.
		Thread.setDefaultUncaughtExceptionHandler(new MyUnhandledExceptionHandler());

		// Initialize resolution
		initResolution();

		// Initialize common handler
		initControls();

		// Initialize animation
		int nDir = getIntent().getIntExtra(AnimConst.EXTRA_ANIMDIR, -1);
		if (nDir == AnimConst.ANIMDIR_FROM_LEFT)
			overridePendingTransition(R.anim.left_in, R.anim.right_out);
		else if (nDir == AnimConst.ANIMDIR_FROM_RIGHT)
			overridePendingTransition(R.anim.right_in, R.anim.left_out);
		else
			overridePendingTransition(0, 0);

		// Initialize activity
		initializeActivity();
	}



	@Override
	protected void onResume() {
		super.onResume();

		top_instance = this;

		// Check availability of the activity. If activity contains any logical errors, it throws exception
		try {
			checkAvailability();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		// Hide keyboard when the activity is shown
		UIUtility.hideKeyboardsInView(SuperActivity.this, getRootView());
		startLocationUpdate();
	}


	@Override
	protected void onPause() {
		super.onPause();

		// Hide keyboard when the activity is paused
		UIUtility.hideKeyboardsInView(SuperActivity.this, getRootView());
		stopLocationUpdate();
	}


	public void initControls() {
		/**
		 * Initialize back button and click event.
		 * If you have back button on the activity, it is recommended to set the id of the control as 'btn_back'
		 */
		View btn_back = findViewById(R.id.btn_back);
		if (btn_back != null) {
			btn_back.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					onClickedBack();
				}
			});
		}
	}


	/**
	 * Default method of the click back button(id : 'btn_back')
	 */
	public void onClickedBack() {
		if (isLastActivity()) {
			try {
				if (Calendar.getInstance().getTimeInMillis() - backPressedTime < PRESS_BACK_INTERVAL_LIMIT) {
					popOverCurActivityNonAnimated();
					System.exit(1);
				} else {
					ToastUtility.showToast(SuperActivity.this, R.string.app_confirm_exit, Gravity.BOTTOM);
					backPressedTime = Calendar.getInstance().getTimeInMillis();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else {
			popOverCurActivityAnimated();
		}
	}


	protected void checkKeyboard() {
		View rootView = getRootView();

		int heightDiff = rootView.getRootView().getHeight() - rootView.getHeight();
		// if more than 100 pixels, its probably a keyboard...

		if (heightDiff > 100 && !isKeyboardShown) {
			onKeyboardShown(true);
		} else if (isKeyboardShown) {
			onKeyboardShown(false);
		}
	}


	protected void onKeyboardShown(boolean isShown) {}

	protected abstract void initializeActivity();


	/**
	 * Method to check logical availability of the activity. Reserved for future.
	 *
	 * @throws Exception
	 */
	public void checkAvailability() throws Exception {}



	///////////////////////// Activity transition methods begin /////////////////////////
	public void pushNewActivityAnimatedWithReqCode(Class dstClass, int req_code) {
		pushNewActivityAnimated(dstClass, AnimConst.ANIMDIR_FROM_RIGHT, 0, null, req_code);
	}

	public void pushNewActivityAnimated(Class dstClass) {
		pushNewActivityAnimated(dstClass, AnimConst.ANIMDIR_FROM_RIGHT, 0, null, -1);
	}

	public void pushNewActivityAnimated(Class dstClass, Bundle bundle) {
		pushNewActivityAnimated(dstClass, AnimConst.ANIMDIR_FROM_RIGHT, 0, bundle, -1);
	}

	public void pushNewActivityAnimated(Class dstClass, Bundle bundle, int req_code) {
		pushNewActivityAnimated(dstClass, AnimConst.ANIMDIR_FROM_RIGHT, 0, bundle, req_code);
	}

	public void pushNewActivityAnimated(Class dstClass, int animation, Bundle bundle) {
		pushNewActivityAnimated(dstClass, animation, 0, bundle, -1);
	}

	public void pushNewActivityAnimated(Class dstClass, int animation) {
		pushNewActivityAnimated(dstClass, animation, 0, null, -1);
	}

	public void pushNewActivityAnimated(Class dstClass, int animation, int req_code) {
		pushNewActivityAnimated(dstClass, animation, 0, null, req_code);
	}

	public void pushNewActivityAnimated(Class dstClass,
										int animation,
										int activity_flags,
										int req_code) {
		pushNewActivityAnimated(dstClass, animation, activity_flags, null, req_code);
	}

	/**
	 * Method to show new activity with animation.
	 * Now animation only supports two types - cover from right and from left.
	 *
	 * @param dstClass			Destination activity class.
	 * @param animation			Push activity animation. See AnimConst class.
	 * @param activity_flags	Used for the startActivityForResult(...) method
	 * @param extras			Used to pass extra parameters to activity
	 * @param req_code			Used to pass activity request code
	 *
	 * @see SuperActivity.AnimConst
	 * @see android.content.Intent
	 * @see android.os.Bundle
	 */
	public void pushNewActivityAnimated(final Class dstClass,
										final int animation,
										final int activity_flags,
										final Bundle extras,
										final int req_code) {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				Intent intent = new Intent(SuperActivity.this, dstClass);
				intent.putExtra(AnimConst.EXTRA_ANIMDIR, animation);

				if (activity_flags != 0)
					intent.addFlags(activity_flags);

				if (extras != null)
					intent.putExtras(extras);

				SuperActivity.this.startActivityForResult(intent, req_code);
			}
		});
	}


	/**
	 * Method to dismiss current activity without animation
	 */
	public void popOverCurActivityNonAnimated() {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				SuperActivity.this.finish();
				overridePendingTransition(0, 0);
			}
		});
	}


	/**
	 * Method to dismiss current activity with animation
	 * Animation is the opposite of the animation which is used to show activity
	 */
	public void popOverCurActivityAnimated() {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				SuperActivity.this.finish();

				int nDir = getIntent().getIntExtra(AnimConst.EXTRA_ANIMDIR, -1);
				if (nDir == AnimConst.ANIMDIR_FROM_LEFT)
					overridePendingTransition(R.anim.right_in, R.anim.left_out);
				else if (nDir == AnimConst.ANIMDIR_FROM_RIGHT)
					overridePendingTransition(R.anim.left_in, R.anim.right_out);
				else
					overridePendingTransition(0, 0);
			}
		});
	}
	///////////////////////// Activity transition methods end /////////////////////////


	/**
	 * Method to get the root view of the activity.
	 *
	 * @return
	 */
	public View getRootView() {
		return ((FrameLayout)getWindow().getDecorView().findViewById(android.R.id.content)).getChildAt(0);
	}


	/**
	 * Method to initialize the size of controls in activity.
	 * Normally this method doesn't need to be called explicitly by developer
	 */
	public void initResolution() {
		// Get the root layout
		final ViewGroup rootView = (ViewGroup)getRootView();
		rootView.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
			@Override
			public void onGlobalLayout() {
				Point ptTemp = getScreenSize();
				boolean bNeedUpdate = false;

				if (screen_size.x == 0 && screen_size.y == 0) {
					screen_size = ptTemp;
					bNeedUpdate = true;
				} else if (screen_size.x != ptTemp.x || screen_size.y != ptTemp.y) {
					screen_size = ptTemp;
					bNeedUpdate = true;
				}


				if (bNeedUpdate) {
					runOnUiThread(new Runnable() {
						@Override
						public void run() {
							ResolutionUtility.instance.iterateChild(rootView, screen_size.x, screen_size.y);
						}
					});
				}

				checkKeyboard();
			}
		});
	}


	// Progress dialog methods
	public void startProgress() {
		startProgress(getResources().getString(R.string.please_wait));
	}


	public void startProgress(final String szMsg) {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				if (dlg_prog != null && dlg_prog.isShowing())
					return;

				if (dlg_prog == null) {
					dlg_prog = new CommonProgressDialog(SuperActivity.this);
					dlg_prog.setMessage(szMsg);
					dlg_prog.setCancelable(true);
				}

				dlg_prog.show();
			}
		});
	}


	public void stopProgress() {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				if (dlg_prog != null) {
					dlg_prog.dismiss();
					dlg_prog = null;
				}
			}
		});
	}
	/////////////////////////////////////////////////////////////////////////////////////////


	/**
	 * Method to customize the click event of the system back key
	 *
	 * @param keyCode
	 * @param event
	 * @return
	 */
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			onClickedBack();
			return true;
		}

		return super.onKeyDown(keyCode, event);
	}


	/**
	 * Method to detect if last activity
	 *
	 * @return
	 */
	public boolean isLastActivity() {
		ActivityManager mngr = (ActivityManager)getSystemService(ACTIVITY_SERVICE);
		List<ActivityManager.RunningTaskInfo> taskList = mngr.getRunningTasks(10);

		if (taskList.get(0).numActivities != 1 || !taskList.get(0).topActivity.getClassName().equals(this.getClass().getName()))
			return false;

		return true;
	}

	// Method to get phone screen size
	public Point screen_size = new Point(0, 0);
	public Point getScreenSize() {
		Point ptTemp = ResolutionUtility.getScreenSize(getApplicationContext());
		ptTemp.y -= statusBarHeight();

		return ptTemp;
	}


	/**
	 * Method to register child (horizontal) scroll views which are belongs to (horizontal) scroll view.
	 * This method is needed when you put scroll view in the scroll view.
	 * Normally android doesn't support the scroll effect of the child scroll view.
	 *
	 * @param parentView
	 * @param childViews
	 *
	 * @Warning If you already customized touch events of parent and child views, they are all ignored.
	 */
	public void registerChildScrollViews(View parentView, final ArrayList<View> childViews) {
		if (parentView == null || childViews == null || childViews.size() == 0)
			return;


		// Register touch event handlers for child views
		for (int i = 0; i < childViews.size(); i++)
		{
			View childView = childViews.get(i);
			childView.setOnTouchListener(new View.OnTouchListener() {
				@Override
				public boolean onTouch(View v, MotionEvent event) {
					v.getParent().requestDisallowInterceptTouchEvent(true);
					return false;
				}
			});
		}



		// Register touch event for parent view
		parentView.setOnTouchListener(new View.OnTouchListener() {
			@Override
			public boolean onTouch(View v, MotionEvent event) {
				for (int i = 0; i < childViews.size(); i++) {
					View childView = childViews.get(i);
					childView.getParent().requestDisallowInterceptTouchEvent(false);
				}

				return false;
			}
		});
	}



	/**
	 * Method to register child (horizontal) scroll view which is belongs to (horizontal) scroll view.
	 *
	 * @param parentView
	 * @param childView
	 *
	 * @Warning If you already customized touch events of parent and child view, they are all ignored.
	 * @Warning If you have several views to register, please do not use this method.
	 *
	 */
	public void registerChildScrollView(View parentView, final View childView) {
		if (parentView == null || childView == null)
			return;

		// Register touch event handlers for child view
		childView.setOnTouchListener(new View.OnTouchListener() {
			@Override
			public boolean onTouch(View v, MotionEvent event) {
				v.getParent().requestDisallowInterceptTouchEvent(true);
				return false;
			}
		});



		// Register touch event for parent view
		parentView.setOnTouchListener(new View.OnTouchListener() {
			@Override
			public boolean onTouch(View v, MotionEvent event) {
				childView.getParent().requestDisallowInterceptTouchEvent(false);
				return false;
			}
		});
	}


	/**
	 * Method to show logout confirm dialog
	 *
	 * @param szMsg : confirm message(Ex : "Sure to logout?")
	 */
	public void showLogoutDlg(String szMsg) {
		CommonAlertDialog logout_dialog = new CommonAlertDialog.Builder(SuperActivity.this)
				.message(szMsg)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.positiveTitle("确定退出")
				.negativeTitle("取消")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						AppCommon.clearUserInfo(getApplicationContext());

						pushNewActivityAnimated(PresetLoginActivity.class,
								AnimConst.ANIMDIR_FROM_LEFT,
								Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK,
								null,
								0);
					}
				})
				.build();
		logout_dialog.show();
	}


	/**
	 * Handler to catch unhandled exceptions
	 */
	private class MyUnhandledExceptionHandler implements Thread.UncaughtExceptionHandler {
		private Thread.UncaughtExceptionHandler defaultUEH;

		public MyUnhandledExceptionHandler() {
			this.defaultUEH = Thread.getDefaultUncaughtExceptionHandler();
		}

		@Override
		public void uncaughtException(Thread thread, Throwable ex) {
			ex.printStackTrace();
			defaultUEH.uncaughtException(thread, ex);
		}

	}


	public int startProgressInNotificationArea(int title_id, int msg_id) {
		return startProgressInNotificationArea(getResources().getString(title_id),
				getResources().getString(msg_id));
	}


	public int startProgressInNotificationArea(String title, String message) {
		if (def_notify_manager == null)
			def_notify_manager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);

		NotificationCompat.Builder notify_builder = new NotificationCompat.Builder(SuperActivity.this);
		notify_builder.setContentTitle(title);
		notify_builder.setContentText(message);
		notify_builder.setSmallIcon(R.drawable.icon_download);
		notify_builder.build();
		notify_builder.setProgress(0, 0, true);

		def_notify_manager.notify(cur_notify_id, notify_builder.build());

		arrNotifyBuilders.add(notify_builder);
		cur_notify_id++;

		return cur_notify_id - 1;
	}


	public void stopProgressInNotificationArea(int notify_id, int msg_id) {
		stopProgressInNotificationArea(notify_id, getResources().getString(msg_id));
	}


	public void stopProgressInNotificationArea(int notify_id, String message) {
		if (def_notify_manager == null)
			def_notify_manager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);

		int nIndex = notify_id - 1;
		if (nIndex < 0 || nIndex >= arrNotifyBuilders.size())
			return;

		NotificationCompat.Builder notify_builder = arrNotifyBuilders.get(nIndex);
		notify_builder.setProgress(100, 100, false);
		notify_builder.setContentText(message);

		def_notify_manager.notify(notify_id, notify_builder.build());
	}


	/**
	 * Clear pressed state of the view specified by the parameter and the child views.
	 *
	 * @param view		View or ViewGroup object to clear the state
	 */
	public void clearPressedState(View view) {
		if (view == null)
			return;

		if (view.isClickable()) {
			view.setPressed(false);
		}

		if (view instanceof ViewGroup) {
			int nCount = ((ViewGroup)view).getChildCount();
			for (int i = 0; i < nCount; i++) {
				clearFocus(((ViewGroup) view).getChildAt(i));
			}
		}
	}



	/**
	 * Clear focus of the view specified by the parameter and the child views.
	 *
	 * @param view		View or ViewGroup object to clear the focus
	 */
	public void clearFocus(View view) {
		if (view == null)
			return;

		view.clearFocus();

		if (view instanceof ViewGroup) {
			int nCount = ((ViewGroup)view).getChildCount();
			for (int i = 0; i < nCount; i++) {
				clearFocus(((ViewGroup) view).getChildAt(i));
			}
		}
	}


	public void deleteNotification(int notify_id) {
		if (def_notify_manager == null)
			def_notify_manager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);

		def_notify_manager.cancel(notify_id);
	}


	public void installNewApp(final String szUrl) {
		final int notify_id = startProgressInNotificationArea(R.string.upgrade_notify_title, R.string.upgrade_notify_message);

		Thread thr = new Thread(new Runnable() {
			@Override
			public void run() {
				try {
					int nBytesRead = 0, nByteWritten = 0;
					byte[] buf = new byte[1024];

					URLConnection urlConn = null;
					URL fileUrl = null;
					InputStream inStream = null;
					OutputStream outStream = null;

					File dir_item = null, file_item = null;

					// Downloading file from address
					fileUrl = new URL(szUrl);
					urlConn = fileUrl.openConnection();
					inStream = urlConn.getInputStream();
					download_app_path = szUrl.substring(szUrl.lastIndexOf("/") + 1);
					dir_item = new File(Environment.getExternalStorageDirectory(), "download");
					dir_item.mkdirs();
					file_item = new File(dir_item, download_app_path);

					outStream = new BufferedOutputStream(new FileOutputStream(file_item));

					while ((nBytesRead = inStream.read(buf)) != -1) {
						outStream.write(buf, 0, nBytesRead);
						nByteWritten += nBytesRead;
					}

					stopProgressInNotificationArea(notify_id, R.string.upgrade_success);

					inStream.close();
					outStream.flush();
					outStream.close();
					/////////////////////////////////////////////////////////////////////////

					// Finish downloading and install
					runOnUiThread(runnable_finish_upgrade);

					deleteNotification(notify_id);
				} catch (Exception ex) {
					ex.printStackTrace();
					runOnUiThread(runnable_upgrade_error);
				}
			}
		});

		thr.start();
	}


	Runnable runnable_finish_upgrade = new Runnable() {
		public void run() {
			// Install update app
			Intent intent_install = new Intent( Intent.ACTION_VIEW);
			intent_install.setDataAndType(Uri.fromFile(new File(Environment.getExternalStorageDirectory().toString() + "/download/" + download_app_path)), "application/vnd.android.package-archive");
			intent_install.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
			startActivity(intent_install);

			// Uninstall current app
			Intent intent_uninstall = new Intent(Intent.ACTION_DELETE, Uri.fromParts("package", SuperActivity.this.getPackageName(), null));
			intent_uninstall.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
			startActivity(intent_uninstall);

			SuperActivity.this.finish();
		}
	};

	Runnable runnable_upgrade_error = new Runnable() {
		@Override
		public void run() {
			ToastUtility.showToast(SuperActivity.this, R.string.upgrade_error);
			stopProgress();
		}
	};


	public class MyLocationListener implements BDLocationListener {
		@Override
		public void onReceiveLocation(BDLocation bdLocation) {
			if (bdLocation == null || bdLocation.getAddrStr() == null)
				return;

			double lat = bdLocation.getLatitude();
			double lng = bdLocation.getLongitude();

			String szCityName = bdLocation.getCity();

			AppCommon.saveCoordinates(SuperActivity.this.getApplicationContext(), lat, lng);
			AppCommon.saveUserCityName(SuperActivity.this.getApplicationContext(), szCityName);
		}
	}



	public int statusBarHeight() {
		int statusBarHeight = 0;

		Rect rectgle = new Rect();
		Window window = SuperActivity.this.getWindow();
		window.getDecorView().getWindowVisibleDisplayFrame(rectgle);

		statusBarHeight = rectgle.top;

		return statusBarHeight;
	}



}
