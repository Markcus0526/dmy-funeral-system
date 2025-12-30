package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.PresetVideoPlayerActivity;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.structure.custom.STAfterService;
import com.damytech.structure.custom.STBuryService;
import com.damytech.structure.custom.STDeputyService;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 15:09
 * File Name : ShouHouFuWu_FuWuLeiTabFrame
 */
public class ShouHouFuWu_FuWuLeiTabFrame extends SuperTabActivity.TabFrame {
	private LinearLayout bery_services_layout = null;

	private STAfterService afterService = null;

	private boolean isInit = false;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_shouhoufuwu_fuwulei_tab, container, false);

		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		bery_services_layout = (LinearLayout)parentView.findViewById(R.id.bery_services_layout);
	}


	@Override
	public void onResume() {
		super.onResume();

		if (!isInit) {
			startProgress();
			CommManager.getAfterService(after_service_delegate);
		}
	}


	private CommDelegate after_service_delegate = new CommDelegate() {
		@Override
		public void getAfterServiceResult(int retcode, String retmsg, STAfterService afterService) {
			super.getAfterServiceResult(retcode, retmsg, afterService);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				ShouHouFuWu_FuWuLeiTabFrame.this.afterService = afterService;
				updateData();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};


	private void updateData() {
		// Bery contents
		bery_services_layout.removeAllViews();

		for (int i = 0; i < afterService.bury_services.size(); i++) {
			STBuryService beryService = afterService.bury_services.get(i);

			RelativeLayout item_layout = (RelativeLayout)parentActivity.getLayoutInflater().inflate(R.layout.item_luozangfuwu_layout, null);
			ResolutionUtility.instance.iterateChild(item_layout, parentActivity.screen_size.x, parentActivity.screen_size.y);

			TextView txtTitle = (TextView)item_layout.findViewById(R.id.txt_title);
			txtTitle.setText(beryService.title);

			ImageView imgSplash = (ImageView)item_layout.findViewById(R.id.img_splash);
			BitmapUtility.setImageWithImageLoader(imgSplash, beryService.splash_image_url, parentActivity.loader_options);

			TextView txtContents = (TextView)item_layout.findViewById(R.id.txt_contents);
			txtContents.setText(beryService.contents);

			ImageButton btnPlay = (ImageButton)item_layout.findViewById(R.id.btn_play);
			btnPlay.setTag(beryService);
			btnPlay.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					onPlayItem((STBuryService) v.getTag());
				}
			});

			bery_services_layout.addView(item_layout);
		}

		// Deputy contents
		for (int i = 0; i < afterService.deputy_services.size(); i++) {
			STDeputyService deputyService = afterService.deputy_services.get(i);

			RelativeLayout item_layout = (RelativeLayout)parentActivity.getLayoutInflater().inflate(R.layout.item_daijibaifuwu_layout, null);
			ResolutionUtility.instance.iterateChild(item_layout, parentActivity.screen_size.x, parentActivity.screen_size.y);

			TextView txtTitle = (TextView)item_layout.findViewById(R.id.txt_title);
			txtTitle.setText(deputyService.title);

			WebContentView wvContents = (WebContentView)item_layout.findViewById(R.id.wv_contents);
			wvContents.loadHTMLString(deputyService.contents);

			bery_services_layout.addView(item_layout);
		}

		// Deputy contents
		//BitmapUtility.setImageWithImageLoader(img_deputy_service, afterService.deputy_service.image_url, parentActivity.loader_options);
		//txt_deputy_contents.setText(afterService.deputy_service.contents);

		isInit = true;
	}

	private void onPlayItem(STBuryService beryService) {
		PresetVideoPlayerActivity.startVideoActivity(parentActivity, beryService.video_url);
	}

}
