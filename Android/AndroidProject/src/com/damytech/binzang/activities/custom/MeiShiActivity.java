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
 * Time : 21:28
 * File Name : MeiShiActivity
 */
public class MeiShiActivity extends SuperActivity {
	private WebContentView webvMeishi = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_meishi);
	}

	@Override
	protected void initializeActivity() {
		webvMeishi = (WebContentView)findViewById(R.id.webview_meishi);
		loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getFoodPageUrl(food_url_delegate);
	}

	private CommDelegate food_url_delegate = new CommDelegate() {
		@Override
		public void getFoodPageUrlResult(int retcode, String retmsg, String page_url) {
			super.getFoodPageUrlResult(retcode, retmsg, page_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setFoodData(page_url);
			} else {
				ToastUtility.showToast(MeiShiActivity.this, retmsg);
			}
		}
	};

	private void setFoodData(String url) {
		webvMeishi.loadURL(url);
	}

}
