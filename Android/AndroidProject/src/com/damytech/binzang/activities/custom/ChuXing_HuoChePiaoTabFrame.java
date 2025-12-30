package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.utils.ToastUtility;


/**
 * Created by Personal on 2015/4/11.
 */
public class ChuXing_HuoChePiaoTabFrame extends SuperTabActivity.TabFrame {

	private WebContentView webvHuoChePiao = null;

	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_chuxing_huochepiao_tab, container, false);
		initResolution(contentView);
		initControls(contentView);
		return contentView;
	}

	private void initControls(View parentView) {
		webvHuoChePiao = (WebContentView)parentView.findViewById(R.id.webview_huochepiao);
		loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getJournalPageUrl(chuxing_url_delegate);
	}

	private CommDelegate chuxing_url_delegate = new CommDelegate() {
		@Override
		public void getJournalPageUrlResult(int retcode, String retmsg, String plane_url, String train_url) {
			super.getJournalPageUrlResult(retcode, retmsg, plane_url, train_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setHuoChePiaoUrl(train_url);
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};

	private void setHuoChePiaoUrl(String url) {
		webvHuoChePiao.loadURL(url);
	}}
