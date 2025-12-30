package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.structure.custom.ST36View;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-12
 * Time : 01:48
 * File Name : SanLiuJingJieShaoActivity
 */
public class SanLiuJingJieShaoActivity extends SuperActivity {
	public static final String EXTRA_VIEW_ID = "fengjing_id";

	private long view_id = 0;

	private ST36View view_info = null;

	private ImageView imgMain = null;
	private TextView txtTitle = null;
	private WebContentView txtContents = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_36birdseyeviewxiangxi);
	}

	@Override
	protected void initializeActivity() {
		view_id = getIntent().getLongExtra(EXTRA_VIEW_ID, 0);

		imgMain = (ImageView)findViewById(R.id.img_main);
		txtTitle = (TextView)findViewById(R.id.txt_view_title);
		txtContents = (WebContentView)findViewById(R.id.contents_view);

		startProgress();
		CommManager.get36ViewDetail(view_id, detail_delegate);
	}


	private CommDelegate detail_delegate = new CommDelegate() {
		@Override
		public void get36ViewDetailResult(int retcode, String retmsg, ST36View view_info) {
			super.get36ViewDetailResult(retcode, retmsg, view_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				SanLiuJingJieShaoActivity.this.view_info = view_info;
				updateData();
			} else {
				ToastUtility.showToast(SanLiuJingJieShaoActivity.this, retmsg);
			}
		}
	};

	private void updateData() {
		txtTitle.setText(view_info.title);
		txtContents.loadHTMLString(view_info.contents);
		BitmapUtility.setImageWithImageLoader(imgMain, view_info.image_url, loader_options);
	}

}
