package com.damytech.binzang.activities.custom;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperScrollActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.WebContentView;
import com.damytech.structure.custom.STActivity;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 22:23
 * File Name : YuanQuHuoDongXiangQingActivity
 */
public class YuanQuHuoDongXiangQingActivity extends SuperScrollActivity {
	public static final String EXTRA_ACTIVITY_ID = "activity_id";
	public static final String EXTRA_SHOPCART = "shop_cart";

	private long activity_id = 0;
	private boolean shop_cart = true;

	private TextView txt_title = null;
	private ImageView imgMain = null;
	private TextView txt_upload_time = null;
	private TextView txt_act_time = null;
	private WebContentView wv_contents = null;

	private TextView lbl_act_time = null;

	private ImageButton btnShopCart = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yuanquhuodongxiangqing);
	}

	@Override
	protected void initializeActivity() {
		activity_id = getIntent().getLongExtra(EXTRA_ACTIVITY_ID, 0);
		shop_cart = getIntent().getBooleanExtra(EXTRA_SHOPCART, false);

		txt_title = (TextView)findViewById(R.id.txt_activity_title);
		txt_upload_time = (TextView)findViewById(R.id.txt_time);
		txt_act_time = (TextView)findViewById(R.id.txt_act_time);
		lbl_act_time = (TextView)findViewById(R.id.txt_act_time);
		wv_contents = (WebContentView)findViewById(R.id.wv_act_contents);
		imgMain = (ImageView)findViewById(R.id.imgMain);

		btnShopCart = (ImageButton)findViewById(R.id.btn_shopcart);
		btnShopCart.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedShopCart();
			}
		});

		if (activity_id > 0) {
			startProgress();
			CommManager.getActivityDetail(AppCommon.loadUserIDLong(getApplicationContext()),
					activity_id,
					comm_delegate);
		}
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getActivityDetailResult(int retcode, String retmsg, STActivity activity_info) {
			super.getActivityDetailResult(retcode, retmsg, activity_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				txt_title.setText(activity_info.title);
				txt_upload_time.setText(activity_info.add_time);
				if(activity_info.act_time == null || activity_info.act_time.length() <= 0) {
					lbl_act_time.setVisibility(View.INVISIBLE);
					txt_act_time.setVisibility(View.INVISIBLE);
				} else {
					lbl_act_time.setVisibility(View.VISIBLE);
					txt_act_time.setVisibility(View.VISIBLE);
					txt_act_time.setText(activity_info.act_time);
				}
				wv_contents.loadHTMLString(activity_info.act_contents);
				BitmapUtility.setImageWithImageLoader(imgMain, activity_info.image_url, loader_options);

				if (activity_info.is_read == 0) {
					CommManager.readActivity(AppCommon.loadUserIDLong(getApplicationContext()),
							activity_info.uid,
							comm_delegate);
				}

				if (shop_cart && activity_info.is_oblation == 1) {
					btnShopCart.setVisibility(View.VISIBLE);
				} else {
					btnShopCart.setVisibility(View.GONE);
				}
			} else {
				ToastUtility.showToast(YuanQuHuoDongXiangQingActivity.this, retmsg);
			}
		}

		@Override
		public void readActivityResult(int retcode, String retmsg) {
			super.readActivityResult(retcode, retmsg);

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				Intent data = new Intent();
				data.putExtra(EXTRA_ACTIVITY_ID, activity_id);

				setResult(RESULT_OK, data);
			}
		}
	};


	private void onClickedShopCart() {
		pushNewActivityAnimated(HuoDongJiPinGouMaiActivity.class);
	}

}





















