package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STDeputyDetailImage;
import com.damytech.structure.custom.STDeputyLog;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 01:52
 * File Name : DaiJiBaiXiangQingActivity
 */
public class DaiJiBaiXiangQingActivity extends SuperActivity {
	public static final String EXTRA_LOG_ID = "daijibai_id";

	private TextView txtTime = null;
	private TextView txtService = null;
	private LinearLayout images_layout = null;

	private STDeputyLog log_info = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_daijibaixiangqing);
	}


	@Override
	protected void initializeActivity() {
		long log_id = getIntent().getLongExtra(EXTRA_LOG_ID, 0);

		txtTime = (TextView)findViewById(R.id.txt_date);
		txtService = (TextView)findViewById(R.id.txt_service);
		images_layout = (LinearLayout)findViewById(R.id.images_layout);

		if (log_id > 0) {
			startProgress();
			CommManager.getDeputyLogDetail(AppCommon.loadUserIDLong(getApplicationContext()),
					log_id, detail_delegate);
		}
	}



	private CommDelegate detail_delegate = new CommDelegate() {
		@Override
		public void getDeputyLogDetailResult(int retcode, String retmsg, STDeputyLog deputy_log) {
			super.getDeputyLogDetailResult(retcode, retmsg, deputy_log);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				log_info = deputy_log;
				updateUI();
			} else {
				ToastUtility.showToast(DaiJiBaiXiangQingActivity.this, retmsg);
			}
		}
	};


	private void updateUI() {
		txtTime.setText(log_info.time);
		txtService.setText(log_info.service_people);

		for (int i = 0; i < log_info.detail_images.size(); i++) {
			STDeputyDetailImage image = log_info.detail_images.get(i);

			View item_view = getLayoutInflater().inflate(R.layout.item_daijibaihuihan_xiangxitu_layout, null);
			ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

			ImageView imgMain = (ImageView)item_view.findViewById(R.id.img_main);
			BitmapUtility.setImageWithImageLoader(imgMain, image.image_url, loader_options);

			images_layout.addView(item_view);
		}
	}


}
