package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonSelectSingleDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.preset_controls.TDScrollView;
import com.damytech.structure.custom.STMonthlyScore;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.StringUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 10:41
 * File Name : BanShiChuDanYueYeJiActivity
 */
public class BanShiChuDanYueYeJiActivity extends SuperActivity {
	private final int TITLE_ITEM = -2;
	private final int TOTAL_ITEM = -3;

	private RelativeLayout month_layout = null;
	private TextView txtMonth = null;
	private ImageButton btnMonth = null;

	private TDScrollView scroll_view = null;

	private int curMonth = 0;

	private boolean isBoss = false;

	private ArrayList<STMonthlyScore> arrMonthlyScores = new ArrayList<STMonthlyScore>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_banshichudanyueyeji);
	}


	@Override
	protected void initializeActivity() {
		curMonth = Calendar.getInstance().get(Calendar.MONTH);

		isBoss = AppCommon.loadUserType(getApplicationContext()) <= ConstMgr.USER_TYPE_VICE_GENERALMANAGER;

		month_layout = (RelativeLayout)findViewById(R.id.month_layout);
		if (isBoss) {
			month_layout.setVisibility(View.VISIBLE);
		} else {
			month_layout.setVisibility(View.GONE);
		}

		txtMonth = (TextView) findViewById(R.id.txt_month);
		txtMonth.setText("" + (curMonth + 1));

		btnMonth = (ImageButton) findViewById(R.id.btn_month);
		btnMonth.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedMonth();
			}
		});

		scroll_view = (TDScrollView)findViewById(R.id.main_scrollview);

		getDataFromService();
	}


	private void onClickedMonth() {
		ArrayList<String> arrMonths = new ArrayList<String>();
		for (int i = 0; i < 12; i++) {
			arrMonths.add("" + (i + 1) + "月");
		}

		CommonSelectSingleDialog dialog = new CommonSelectSingleDialog(BanShiChuDanYueYeJiActivity.this);
		dialog.initItemData(arrMonths);
		dialog.setDialogTitle("请选择月份");
		dialog.delegate = new CommonSelectSingleDialog.SelectItemListener() {
			@Override
			public void onItemClicked(String item_data, int index) {
				curMonth = index;
				txtMonth.setText("" + (curMonth + 1));

				getDataFromService();
			}
		};
		dialog.show();
	}


	private void getDataFromService() {
		startProgress();

		if (isBoss) {
			CommManager.getOfficesCurMonthScore(AppCommon.loadUserIDLong(getApplicationContext()),
					curMonth + 1,
					comm_delegate);
		} else {
			CommManager.getOfficeMonthlyScore(AppCommon.loadUserIDLong(getApplicationContext()),
					AppCommon.loadOfficeID(getApplicationContext()),
					comm_delegate);
		}
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getOfficeMonthlyScoreResult(int retcode, String retmsg, ArrayList<STMonthlyScore> arrScores) {
			super.getOfficeMonthlyScoreResult(retcode, retmsg, arrScores);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrMonthlyScores.clear();

				// Add a empty data for the list title item
				STMonthlyScore titleItem = new STMonthlyScore();
				titleItem.office_id = TITLE_ITEM;

				arrMonthlyScores.add(titleItem);
				arrMonthlyScores.addAll(arrScores);

				// If user is manager, the bottom row of the list is the total score.
				// Artificially add one more item for this.
				STMonthlyScore totalItem = new STMonthlyScore();
				totalItem.office_id = TOTAL_ITEM;

				for (STMonthlyScore item : arrMonthlyScores) {
					totalItem.order = "总计";
					totalItem.agent += item.agent;
					totalItem.employee += item.employee;
					totalItem.response_value += item.response_value;
					totalItem.total += item.total;
					totalItem.office_income += item.office_income;
				}

				totalItem.self_rate = (int)(totalItem.employee * 100 / (totalItem.employee + totalItem.agent));
				totalItem.success_rate = (int)((totalItem.employee + totalItem.agent) * 100 / totalItem.response_value);

				arrMonthlyScores.add(totalItem);

				updateUI();
			} else {
				ToastUtility.showToast(BanShiChuDanYueYeJiActivity.this, retmsg);
			}
		}

		@Override
		public void getOfficesCurMonthScoreResult(int retcode, String retmsg, ArrayList<STMonthlyScore> arrScores) {
			super.getOfficesCurMonthScoreResult(retcode, retmsg, arrScores);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrMonthlyScores.clear();

				// Add a empty data for the list title item
				STMonthlyScore titleItem = new STMonthlyScore();
				titleItem.office_id = TITLE_ITEM;

				arrMonthlyScores.add(titleItem);
				arrMonthlyScores.addAll(arrScores);

				updateUI();
			} else {
				ToastUtility.showToast(BanShiChuDanYueYeJiActivity.this, retmsg);
			}
		}
	};



	private void updateUI() {
		RelativeLayout content_layout = (RelativeLayout)scroll_view.getContentLayout();
		content_layout.removeAllViews();

		LinearLayout items_layout = new LinearLayout(content_layout.getContext());
		ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
		items_layout.setLayoutParams(params);
		items_layout.setPadding(0, 0, 0, 10);
		items_layout.setOrientation(LinearLayout.VERTICAL);

		final int itemHeight = 60;
		for (int i = 0; i < arrMonthlyScores.size(); i++) {
			View itemView = getLayoutInflater().inflate(R.layout.item_danyueyeji_layout, null);
			RelativeLayout.LayoutParams layout_params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, itemHeight);
			layout_params.setMargins(0, itemHeight * i, 0, 0);
			itemView.setLayoutParams(layout_params);

			TextView txtItem1 = (TextView)itemView.findViewById(R.id.lbl_item1);
			TextView txtItem2 = (TextView)itemView.findViewById(R.id.lbl_item2);
			TextView txtItem3 = (TextView)itemView.findViewById(R.id.lbl_item3);
			TextView txtItem4 = (TextView)itemView.findViewById(R.id.lbl_item4);
			TextView txtItem5 = (TextView)itemView.findViewById(R.id.lbl_item5);
			TextView txtItem6 = (TextView)itemView.findViewById(R.id.lbl_item6);
			TextView txtItem7 = (TextView)itemView.findViewById(R.id.lbl_item7);
			TextView txtItem8 = (TextView)itemView.findViewById(R.id.lbl_item8);

			STMonthlyScore score = arrMonthlyScores.get(i);
			if (score.office_id == TITLE_ITEM) {
				// Create title view
				txtItem1.setText("区分");
				txtItem2.setText("代销商业绩累计");
				txtItem3.setText("员工业绩累计");
				txtItem4.setText("自营比率");
				txtItem5.setText("责任额");
				txtItem6.setText("总业绩");
				txtItem7.setText("达成比率");
				txtItem8.setText("办事处营余累计");
			} else {
				txtItem1.setText(score.order);
				txtItem2.setText(StringUtility.formatDouble(score.agent));
				txtItem3.setText(StringUtility.formatDouble(score.employee));
				txtItem4.setText(StringUtility.formatDouble(score.self_rate) + "%");
				txtItem5.setText(StringUtility.formatDouble(score.response_value));
				txtItem6.setText(StringUtility.formatDouble(score.total));
				txtItem7.setText(StringUtility.formatDouble(score.success_rate) + "%");
				txtItem8.setText(StringUtility.formatDouble(score.office_income));
			}

			items_layout.addView(itemView);
		}

		ResolutionUtility.instance.iterateChild(items_layout, screen_size.x, screen_size.y);

		content_layout.addView(items_layout);
	}

}
