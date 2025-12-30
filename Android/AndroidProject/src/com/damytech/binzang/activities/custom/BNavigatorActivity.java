package com.damytech.binzang.activities.custom;

import android.content.res.Configuration;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import com.baidu.navisdk.BNaviPoint;
import com.baidu.navisdk.BaiduNaviManager;
import com.baidu.navisdk.comapi.mapcontrol.BNMapController;
import com.baidu.navisdk.comapi.routeplan.BNRoutePlaner;
import com.baidu.navisdk.comapi.routeplan.RoutePlanParams;
import com.baidu.navisdk.comapi.tts.BNTTSPlayer;
import com.baidu.navisdk.comapi.tts.BNavigatorTTSPlayer;
import com.baidu.navisdk.comapi.tts.IBNTTSPlayerListener;
import com.baidu.navisdk.model.datastruct.LocData;
import com.baidu.navisdk.model.datastruct.SensorData;
import com.baidu.navisdk.ui.routeguide.BNavigator;
import com.baidu.navisdk.ui.routeguide.IBNavigatorListener;
import com.baidu.navisdk.ui.widget.RoutePlanObserver;
import com.baidu.nplatform.comapi.map.MapGLSurfaceView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.misc.AppCommon;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:01
 * File Name : DiTuDaoHangActivity
 */
public class BNavigatorActivity extends SuperActivity {
	private MapGLSurfaceView mapView = null;
	private RelativeLayout contentView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_ditudaohang);
	}

	@Override
	protected void initializeActivity() {
		contentView = (RelativeLayout) findViewById(R.id.content_layout);


		if (Build.VERSION.SDK_INT < 14) {
			BaiduNaviManager.getInstance().destroyNMapView();
		}

		mapView = BaiduNaviManager.getInstance().createNMapView(this);
		View navigatorView = BNavigator.getInstance().init(BNavigatorActivity.this, getIntent().getExtras(), mapView);
		RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
		navigatorView.setLayoutParams(params);
		contentView.addView(navigatorView);



		// Initializing baidu navigation
		BNavigator.getInstance().setListener(bNavigatorListener);
		BNavigator.getInstance().startNav();

		BNTTSPlayer.initPlayer();

		BNavigatorTTSPlayer.setTTSPlayerListener(new IBNTTSPlayerListener() {
			@Override
			public int playTTSText(String arg0, int arg1) {
				return BNTTSPlayer.playTTSText(arg0, arg1);
			}

			@Override
			public void phoneHangUp() {
			}

			@Override
			public void phoneCalling() {
			}

			@Override
			public int getTTSState() {
				return BNTTSPlayer.getTTSState();
			}
		});

		BNRoutePlaner.getInstance().setObserver(new RoutePlanObserver(this, new RoutePlanObserver.IJumpToDownloadListener() {
			@Override
			public void onJumpToDownloadOfflineData() {
			}
		}));
	}


	@Override
	protected void onResume() {
		BNavigator.getInstance().resume();
		super.onResume();
		BNMapController.getInstance().onResume();
	}

	@Override
	protected void onPause() {
		BNavigator.getInstance().pause();
		super.onPause();
		BNMapController.getInstance().onPause();
	}

	@Override
	public void onConfigurationChanged(Configuration newConfig) {
		BNavigator.getInstance().onConfigurationChanged(newConfig);
		super.onConfigurationChanged(newConfig);
	}

	@Override
	public void onClickedBack() {
		if (isLastActivity()) {
			super.onClickedBack();
		} else {
			onBackPressed();
		}
	}

	@Override
	public void onBackPressed(){
		BNavigator.getInstance().onBackPressed();
	}


	@Override
	public void onDestroy(){
		BNavigator.destory();
		BNRoutePlaner.getInstance().setObserver(null);
		super.onDestroy();
	}


	private IBNavigatorListener bNavigatorListener = new IBNavigatorListener() {
		@Override
		public void onYawingRequestSuccess() {}

		@Override
		public void onYawingRequestStart() {}

		@Override
		public void onPageJump(int jumpTiming, Object arg) {
			if (IBNavigatorListener.PAGE_JUMP_WHEN_GUIDE_END == jumpTiming) {
				finish();
			} else if(IBNavigatorListener.PAGE_JUMP_WHEN_ROUTE_PLAN_FAIL == jumpTiming) {
				finish();
			}
		}

		@Override
		public void notifyGPSStatusData(int arg0) {}

		@Override
		public void notifyLoacteData(LocData arg0) {}

		@Override
		public void notifyNmeaData(String arg0) {}

		@Override
		public void notifySensorData(SensorData arg0) {}

		@Override
		public void notifyStartNav() {
			BaiduNaviManager.getInstance().dismissWaitProgressDialog();
		}

		@Override
		public void notifyViewModeChanged(int arg0) {}
	};


	public static void startNavigationActivity(final SuperActivity srcActivity,
											   double endlat,
											   double endlng)
	{
		startNavigationActivity(srcActivity,
				AppCommon.loadLatitude(srcActivity.getApplicationContext()),
				AppCommon.loadLongitude(srcActivity.getApplicationContext()),
				endlat,
				endlng);
	}


	public static void startNavigationActivity(final SuperActivity srcActivity,
											   double startlat,
											   double startlng,
											   double endlat,
											   double endlng)
	{
		BNaviPoint startPoint = new BNaviPoint(startlng,startlat, "当前位置", BNaviPoint.CoordinateType.BD09_MC);
		BNaviPoint endPoint = new BNaviPoint(endlng,endlat, "目的地点", BNaviPoint.CoordinateType.BD09_MC);

		BaiduNaviManager.getInstance().launchNavigator(srcActivity,
				startPoint,
				endPoint,
				RoutePlanParams.NE_RoutePlan_Mode.ROUTE_PLAN_MOD_MIN_TIME,			//算路方式
				true,																//真实导航
				BaiduNaviManager.STRATEGY_FORCE_ONLINE_PRIORITY,					//在离线策略
				new BaiduNaviManager.OnStartNavigationListener() {					//跳转监听
					@Override
					public void onJumpToNavigator(Bundle configParams) {
						srcActivity.pushNewActivityAnimated(BNavigatorActivity.class, configParams);
					}
					@Override
					public void onJumpToDownloader() {}
				});

		/*
		BaiduNaviManager.getInstance().launchNavigator(srcActivity,
				startlat,
				startlng,
				"当前位置",
				endlat,
				endlng,
				"目的地点",
				RoutePlanParams.NE_RoutePlan_Mode.ROUTE_PLAN_MOD_MIN_TIME,			//算路方式
				true,																//真实导航
				BaiduNaviManager.STRATEGY_FORCE_ONLINE_PRIORITY,					//在离线策略
				new BaiduNaviManager.OnStartNavigationListener() {					//跳转监听
					@Override
					public void onJumpToNavigator(Bundle configParams) {
						srcActivity.pushNewActivityAnimated(BNavigatorActivity.class, configParams);
					}
					@Override
					public void onJumpToDownloader() {}
				});
				*/
	}

}
