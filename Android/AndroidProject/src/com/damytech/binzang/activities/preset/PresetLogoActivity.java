package com.damytech.binzang.activities.preset;

import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.widget.ImageButton;
import cn.jpush.android.api.JPushInterface;
import com.baidu.lbsapi.auth.LBSAuthManagerListener;
import com.baidu.navisdk.BNaviEngineManager;
import com.baidu.navisdk.BaiduNaviManager;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.custom.FangKeShouYeActivity;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-07
 * Time : 14:56
 * File Name : PresetLogoActivity
 */
public class PresetLogoActivity extends SuperActivity {
	private ImageButton btn_login = null;
	private ImageButton btn_skip = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.preset_activity_logo);
	}

	private void registerJPush()
	{
		JPushInterface.resumePush(this.getApplicationContext());
		JPushInterface.init(getApplicationContext());
	}

	@Override
	protected void onResume() {
		super.onResume();
		JPushInterface.onResume(this);
	}

	@Override
	protected void onPause() {
		super.onPause();
		JPushInterface.onPause(this);
	}

	@Override
	public void initializeActivity() {
		btn_login = (ImageButton)findViewById(R.id.btn_login);
		btn_skip = (ImageButton)findViewById(R.id.btn_skip);

		btn_login.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				//video_view.stopPlayback();
				pushNewActivityAnimated(PresetLoginActivity.class);
				popOverCurActivityNonAnimated();
			}
		});

		btn_skip.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				//video_view.pause();
				//video_view.stopPlayback();
				pushNewActivityAnimated(FangKeShouYeActivity.class);
				popOverCurActivityNonAnimated();
			}
		});

		registerJPush();

		BaiduNaviManager.getInstance().initEngine(this, getSdcardDir(),
				mNaviEngineInitListener, new LBSAuthManagerListener() {
					@Override
					public void onAuthResult(int status, String msg) {
					}
				});
	}

	private String getSdcardDir() {
		if (Environment.getExternalStorageState().equalsIgnoreCase(
				Environment.MEDIA_MOUNTED)) {
			return Environment.getExternalStorageDirectory().toString();
		}
		return null;
	}

	private BNaviEngineManager.NaviEngineInitListener mNaviEngineInitListener = new BNaviEngineManager.NaviEngineInitListener() {
		public void engineInitSuccess() {
		}

		public void engineInitStart() {
		}

		public void engineInitFail() {
		}
	};
}
