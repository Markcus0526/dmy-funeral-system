package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by Personal on 2015/4/12.
 */
public class KaoShi_ZhengZhaoTabFrame   extends SuperTabActivity.TabFrame {
	private ImageView imgZhengZhao = null;

	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_kaoshi_zhengzhao_tab, container, false);
		initResolution(contentView);
		initControls(contentView);
		return contentView;
	}

	private void initControls(View parentView) {
		imgZhengZhao = (ImageView)parentView.findViewById(R.id.img_zhengzhao);
		loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getExamTimeTableImageUrl(kaoshi_url_delegate);
	}

	private CommDelegate kaoshi_url_delegate = new CommDelegate() {
		@Override
		public void getExamTimeTableImageUrlResult(int retcode, String retmsg, String worker_url, String school_url, String photo_url) {
			super.getExamTimeTableImageUrlResult(retcode, retmsg, worker_url, school_url, photo_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setXueXiaoUrl(photo_url);
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};

	private void setXueXiaoUrl(String url) {
		BitmapUtility.setImageWithImageLoader(imgZhengZhao, url, parentActivity.loader_options);
	}}