package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.PresetVideoPlayerActivity;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STAfterService;
import com.damytech.structure.custom.STBuryService;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 10:19
 * File Name : LuoZangYiShiYuYueActivity_TabFrame2
 */
public class YiShiYuYueActivity_TabFrame2 extends SuperTabActivity.TabFrame {
	private ListView list_view = null;
	private Button btnNext = null, btnPrev = null;

	private DataAdapter adapter = null;

	private ArrayList<STBuryService> arrServices = new ArrayList<STBuryService>();
	private ArrayList<Boolean> arrSelectFlags = new ArrayList<Boolean>();

	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_yishiyuyue_tab2, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		adapter = new DataAdapter(parentActivity, arrServices);
		list_view = (ListView)parentView.findViewById(R.id.list_view);
		list_view.setAdapter(adapter);

		btnNext = (Button)parentView.findViewById(R.id.btn_next);
		btnNext.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedNext();
			}
		});
		btnPrev = (Button)parentView.findViewById(R.id.btn_prev);
		btnPrev.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPrev();
			}
		});

		startProgress();
		CommManager.getAfterService(after_service_delegate);
	}


	public class STViewHolder {
		public TextView txtTitle = null;
		public TextView txtContents = null;
		public ImageView imgCheck = null;
		public ImageView imgSplash = null;
		public ImageButton btnSelect = null;
		public ImageButton btnVideo = null;
		public TextView txtPrice = null;
	}


	public class DataAdapter extends ArrayAdapter<STBuryService> {
		public DataAdapter(Context context, List<STBuryService> objects) {
			super(context, 0, objects);
		}


		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STBuryService item_info = arrServices.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = parentActivity.getLayoutInflater().inflate(R.layout.item_luozangfuwu_checkable_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, parentActivity.screen_size.x, parentActivity.screen_size.y);

				holder = new STViewHolder();

				holder.txtTitle = (TextView)item_view.findViewById(R.id.txt_title);
				holder.txtPrice = (TextView)item_view.findViewById(R.id.txt_date);
				holder.txtContents = (TextView)item_view.findViewById(R.id.txt_contents);
				holder.imgCheck = (ImageView)item_view.findViewById(R.id.img_check);
				holder.imgSplash = (ImageView)item_view.findViewById(R.id.img_splash);
				holder.btnSelect = (ImageButton)item_view.findViewById(R.id.btn_select);
				holder.btnSelect.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemSelected((STBuryService)v.getTag());
					}
				});
				holder.btnVideo = (ImageButton)item_view.findViewById(R.id.btn_play);
				holder.btnVideo.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemPlay((STBuryService)v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtTitle.setText(item_info.title);
			holder.txtPrice.setText(item_info.price_desc);
			holder.txtContents.setText(item_info.contents);
			BitmapUtility.setImageWithImageLoader(holder.imgSplash, item_info.splash_image_url, parentActivity.loader_options);

			if (arrSelectFlags.get(position) == true) {
				holder.imgCheck.setImageResource(R.drawable.preset_check_on);
			} else {
				holder.imgCheck.setImageResource(R.drawable.preset_check_off);
			}
			holder.btnVideo.setTag(item_info);
			holder.btnSelect.setTag(item_info);

			return convertView;
		}
	};


	private CommDelegate after_service_delegate = new CommDelegate() {
		@Override
		public void getAfterServiceResult(int retcode, String retmsg, STAfterService service) {
			super.getAfterServiceResult(retcode, retmsg, service);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrServices.clear();
				arrSelectFlags.clear();

				arrServices.addAll(service.bury_services);
				for (int i = 0; i < arrServices.size(); i++) {
					arrSelectFlags.add(false);
				}

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};


	private void onItemSelected(STBuryService buryService) {
		YiShiYuYueActivity luozangActivity = (YiShiYuYueActivity)parentActivity;
		luozangActivity.buryService = buryService;

		for (int i = 0; i < arrServices.size(); i++) {
			if (arrServices.get(i).uid == buryService.uid) {
				if (arrSelectFlags.get(i))
					arrSelectFlags.set(i, false);
				else
					arrSelectFlags.set(i, true);
			} else {
				arrSelectFlags.set(i, false);
			}
		}

		adapter.notifyDataSetChanged();
	}

	private void onItemPlay(STBuryService buryService) {
		PresetVideoPlayerActivity.startVideoActivity(parentActivity, buryService.video_url);
	}


	private void onClickedNext() {
		YiShiYuYueActivity luozangActivity = (YiShiYuYueActivity)parentActivity;
		if (luozangActivity.buryService == null) {
			CommonAlertDialog dialog = new CommonAlertDialog.Builder(parentActivity)
					.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
					.message("您没有选择仪式，确定下一步吗？")
					.positiveListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							parentActivity.tab_adapter.changeTab(2);
						}
					})
					.build();
			dialog.show();
		} else {
			parentActivity.tab_adapter.changeTab(2);
		}
	}


	private void onClickedPrev() {
		parentActivity.tab_adapter.changeTab(0);
	}

}
