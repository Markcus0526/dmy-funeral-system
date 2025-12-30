package com.damytech.binzang.activities.custom;

import android.graphics.Color;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.custom.TombDetailDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.TDScrollView;
import com.damytech.structure.custom.STTomb;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-20
 * Time : 10:02
 * File Name : LingYuanYuLiuActivity_TabFrame3
 */
public class LingYuanYuLiuActivity_TabFrame3 extends SuperTabActivity.TabFrame {
	private TDScrollView mainScrollView = null;
	private Button btnPrev = null;

	private ArrayList<STTomb> arrTombItems = new ArrayList<STTomb>();

	private int ITEM_WIDTH = 100;
	private int ITEM_HEIGHT = 100;

	private int ROW_HEADER_HEIGHT = 40;
	private int COL_HEADER_WIDTH = 40;


	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_lingyuanyuliu_tab3, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}

	@Override
	public void onResume() {
		super.onResume();

		loadTombList();
	}

	private void initControls(View parentView) {
		final LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.setTitle("墓地预留");

		mainScrollView = (TDScrollView)parentView.findViewById(R.id.tomb_scrollview);
		btnPrev = (Button)parentView.findViewById(R.id.btn_prev);
		btnPrev.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPrev();
			}
		});
		loadTombList();
	}

	/*
	@Override
	public void onHiddenChanged(boolean hidden) {
		loadTombList();
	}
	*/

	public void loadTombList() {
		mainScrollView.removeAllViews();
		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		startProgress();
		CommManager.getTombList(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
				yuliuActivity.area_id,
				comm_delegate);
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getTombListResult(int retcode, String retmsg, ArrayList<STTomb> arrTombs) {
			super.getTombListResult(retcode, retmsg, arrTombs);

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrTombItems.clear();
				arrTombItems.addAll(arrTombs);

				updateUI();
				stopProgress();
			} else {
				stopProgress();
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}


		@Override
		public void getTombDetailResult(int retcode, String retmsg, STTomb tomb_detail) {
			super.getTombDetailResult(retcode, retmsg, tomb_detail);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				TombDetailDialog dialog = new TombDetailDialog(parentActivity);
				dialog.init(parentActivity,
						tomb_detail,
						new TombDetailDialog.DialogResultListener() {
							@Override
							public void onConfirmed(long uid) {
								LingYuanYuLiuActivity yuLiuActivity = (LingYuanYuLiuActivity) parentActivity;
								yuLiuActivity.tomb_site_id = uid;

								startProgress();
								CommManager.reserveTombPlace(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
										yuLiuActivity.customer_name,
										yuLiuActivity.customer_phone,
										yuLiuActivity.death1,
										yuLiuActivity.comfort1,
										yuLiuActivity.death2,
										yuLiuActivity.comfort2,
										yuLiuActivity.area_id,
										yuLiuActivity.tomb_site_id,
										yuLiuActivity.tomb_tablet_id,
										comm_delegate);
							}
						});
				dialog.show();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}

		@Override
		public void reserveTombPlaceResult(int retcode, String retmsg) {
			super.reserveTombPlaceResult(retcode, retmsg);
			stopProgress();

			if (retcode == 0) {
				ToastUtility.showToast(parentActivity, "保留成功");
				parentActivity.popOverCurActivityAnimated();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}

	};


	private void updateUI() {
		int nRowCount = 0;
		int nColCount = 0;

		for (STTomb tombInfo : arrTombItems) {
			if (tombInfo.row > nRowCount)
				nRowCount = tombInfo.row;
			if (tombInfo.col > nColCount)
				nColCount = tombInfo.col;
		}

		nRowCount++;
		nColCount++;

		// Add column header
		for (int i = 0; i < nRowCount; i++) {
			TextView txtHeaderItem = new TextView(mainScrollView.getContext());
			RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(COL_HEADER_WIDTH, ITEM_HEIGHT);
			params.setMargins(0, i * ITEM_HEIGHT + ROW_HEADER_HEIGHT, 0, 0);
			txtHeaderItem.setLayoutParams(params);
			txtHeaderItem.setTextSize(TypedValue.COMPLEX_UNIT_PX, 22);
			txtHeaderItem.setTextColor(Color.rgb(0x30, 0x30, 0x30));
			txtHeaderItem.setGravity(Gravity.CENTER);
			txtHeaderItem.setText("" + (i + 1));

			ResolutionUtility.instance.iterateChild(txtHeaderItem, parentActivity.screen_size.x, parentActivity.screen_size.y);

			mainScrollView.addView(txtHeaderItem);
		}


		// Add row header
		for (int i = 0; i < nColCount; i++) {
			TextView txtHeaderItem = new TextView(mainScrollView.getContext());
			RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(ITEM_WIDTH, ROW_HEADER_HEIGHT);
			params.setMargins(i * ITEM_WIDTH + COL_HEADER_WIDTH, 0, 0, 0);
			txtHeaderItem.setLayoutParams(params);
			txtHeaderItem.setTextSize(TypedValue.COMPLEX_UNIT_PX, 22);
			txtHeaderItem.setTextColor(Color.rgb(0x30, 0x30, 0x30));
			txtHeaderItem.setGravity(Gravity.CENTER);
			txtHeaderItem.setText("" + (i + 1));

			ResolutionUtility.instance.iterateChild(txtHeaderItem, parentActivity.screen_size.x, parentActivity.screen_size.y);

			mainScrollView.addView(txtHeaderItem);
		}


		for (STTomb tombInfo : arrTombItems) {
			addViewToScrollView(tombInfo);
		}
	}


	private void addViewToScrollView(final STTomb tombInfo) {
		Runnable runnable = new Runnable() {
			@Override
			public void run() {
				View item_layout = parentActivity.getLayoutInflater().inflate(R.layout.item_muwei_layout, null);
				final View item_view = item_layout.findViewById(R.id.parent_layout);

				RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams)item_view.getLayoutParams();
				if (params == null) {
					params = new RelativeLayout.LayoutParams(ITEM_WIDTH, ITEM_HEIGHT);
				} else if (ITEM_HEIGHT == 0 || ITEM_WIDTH == 0) {
					ITEM_HEIGHT = params.height;
					ITEM_WIDTH = params.width;
				}

				params.setMargins(ITEM_WIDTH * tombInfo.col + COL_HEADER_WIDTH, ITEM_HEIGHT * tombInfo.row + ROW_HEADER_HEIGHT, 0, 0);
				item_view.setLayoutParams(params);

				ResolutionUtility.instance.iterateChild(item_view, parentActivity.screen_size.x, parentActivity.screen_size.y);

				ImageView imgMain = (ImageView)item_view.findViewById(R.id.img_main);
				if (tombInfo.state == 0) {
					imgMain.setImageResource(R.drawable.bk_tomb_kong);
				} else if (tombInfo.state == 1) {
					imgMain.setImageResource(R.drawable.bk_tomb_yibaoliu);
				} else if (tombInfo.state == 2) {
					imgMain.setImageResource(R.drawable.bk_tomb_yifuding);
				} else if (tombInfo.state == 3) {
					imgMain.setImageResource(R.drawable.bk_tomb_yigoumai);
				}

				ImageButton btnItem = (ImageButton)item_view.findViewById(R.id.btn_item);
				btnItem.setTag(tombInfo);
				btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onTombClicked((STTomb) v.getTag());
					}
				});

				if (tombInfo.state == 0) {
					btnItem.setEnabled(true);
				} else {
					btnItem.setEnabled(false);
				}

				parentActivity.runOnUiThread(new Runnable() {
					@Override
					public void run() {
						mainScrollView.addView(item_view);
					}
				});
			}
		};

		Thread thread = new Thread(runnable);
		thread.start();
	}



	private void onTombClicked(STTomb tombInfo) {
		startProgress();
		CommManager.getTombDetail(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
				tombInfo.uid,
				comm_delegate);
	}


	private void onClickedPrev() {
		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.tab_adapter.changeTab(0);
	}


}
