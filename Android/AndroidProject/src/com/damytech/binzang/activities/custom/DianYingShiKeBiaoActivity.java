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
 * Time : 21:49
 * File Name : DianYingShiKeBiaoActivity
 */
public class DianYingShiKeBiaoActivity extends SuperActivity {
	private WebContentView webvDianYing = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_dianyingshikebiao);
	}

	@Override
	protected void initializeActivity() {
		webvDianYing = (WebContentView)findViewById(R.id.webview_dianying);
		loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getCinemaPageUrl(dianying_url_delegate);
	}

	private CommDelegate dianying_url_delegate = new CommDelegate() {
		@Override
		public void getCinemaPageUrlResult(int retcode, String retmsg, String page_url) {
			super.getCinemaPageUrlResult(retcode, retmsg, page_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setFoodData(page_url);
			} else {
				ToastUtility.showToast(DianYingShiKeBiaoActivity.this, retmsg);
			}
		}
	};


	private void setFoodData(String url) {
		webvDianYing.loadURL(url);
	}

}

