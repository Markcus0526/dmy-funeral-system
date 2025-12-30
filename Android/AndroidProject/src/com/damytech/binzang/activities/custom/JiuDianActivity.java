package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 21:48
 * File Name : JiuDianActivity
 */
public class JiuDianActivity extends SuperActivity {
	private WebContentView webvJiuDian = null;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_jiudian);
	}

	@Override
	protected void initializeActivity() {
		webvJiuDian = (WebContentView)findViewById(R.id.webview_jiudian);
		loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getHotelPageUrl(hotel_url_delegate);
	}

	private CommDelegate hotel_url_delegate = new CommDelegate() {
		@Override
		public void getHotelPageUrlResult(int retcode, String retmsg, String page_url) {
			super.getHotelPageUrlResult(retcode, retmsg, page_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setHotelData(page_url);
			} else {
				ToastUtility.showToast(JiuDianActivity.this, retmsg);
			}
		}
	};

	private void setHotelData(String url) {
		webvJiuDian.loadURL(url);
	}
}
