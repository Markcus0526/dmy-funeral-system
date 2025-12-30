package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.preset_controls.TDScrollView;
import com.damytech.structure.custom.STDailyScore;
import com.damytech.structure.custom.STMonthlyScore;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.StringUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 10:41
 * File Name : BanShiChuDanRiYeJiActivity
 */
public class BanShiChuDanRiYeJiActivity extends SuperActivity {
	private final int TITLE_ITEM = -2;
	private final int TOTAL_ITEM = -3;

	private TDScrollView scroll_view = null;
	private boolean isBoss = false;

	private ArrayList<STDailyScore> arrDailyScores = new ArrayList<STDailyScore>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_banshichudanriyeji);
	}


	@Override
	protected void initializeActivity() {
		isBoss = AppCommon.loadUserType(getApplicationContext()) <= ConstMgr.USER_TYPE_VICE_GENERALMANAGER;

		scroll_view = (TDScrollView)findViewById(R.id.main_scrollview);

		getDataFromService();
	}


	private void getDataFromService() {
		startProgress();

		if (isBoss) {
			CommManager.getOfficesDailyScore(AppCommon.loadUserIDLong(getApplicationContext()),
					comm_delegate);
		} else {
			CommManager.getEmployeesDailyScore(AppCommon.loadUserIDLong(getApplicationContext()),
					AppCommon.loadOfficeID(getApplicationContext()),
					comm_delegate);
		}
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getOfficesDailyScoreResult(int retcode, String retmsg, ArrayList<STDailyScore> arrScores) {
			super.getOfficesDailyScoreResult(retcode, retmsg, arrScores);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrDailyScores.clear();

				// Add a empty data for the list title item
				STDailyScore titleItem = new STDailyScore();

				arrDailyScores.add(titleItem);
				arrDailyScores.addAll(arrScores);

				updateUI();
			} else {
				ToastUtility.showToast(BanShiChuDanRiYeJiActivity.this, retmsg);
			}
		}

		@Override
		public void getEmployeesDailyScoreResult(int retcode, String retmsg, ArrayList<STDailyScore> arrScores) {
			super.getEmployeesDailyScoreResult(retcode, retmsg, arrScores);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrDailyScores.clear();

				// Add a empty data for the list title item
				STDailyScore titleItem = new STDailyScore();
				arrDailyScores.add(titleItem);
				arrDailyScores.addAll(arrScores);

				// If user is manager, the bottom row of the list is the total score.
				// Artificially add one more item for this.
				STDailyScore totalItem = new STDailyScore();

				for (STDailyScore item : arrDailyScores) {
					totalItem.name = "总计";
					totalItem.price += item.price;
					totalItem.actual += item.actual;
				}

				arrDailyScores.add(totalItem);

				updateUI();
			} else {
				ToastUtility.showToast(BanShiChuDanRiYeJiActivity.this, retmsg);
			}
		}
	};



	private void updateUI() {
		RelativeLayout content_layout = (RelativeLayout)scroll_view.getContentLayout();
		content_layout.removeAllViews();

		LinearLayout items_layout = new LinearLayout(content_layout.getContext());
		ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
		items_layout.setLayoutParams(params);
		items_layout.setPadding(0, 10, 0, 10);
		items_layout.setOrientation(LinearLayout.VERTICAL);

		final int itemHeight = 60;
		for (int i = 0; i < arrDailyScores.size(); i++) {
			View itemView = getLayoutInflater().inflate(R.layout.item_danriyeji_layout, null);
			RelativeLayout.LayoutParams layout_params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, itemHeight);
			layout_params.setMargins(0, itemHeight * i, 0, 0);
			itemView.setLayoutParams(layout_params);

			TextView txtItem1 = (TextView)itemView.findViewById(R.id.lbl_item1);
			TextView txtItem2 = (TextView)itemView.findViewById(R.id.lbl_item2);
			TextView txtItem3 = (TextView)itemView.findViewById(R.id.lbl_item3);
			TextView txtItem4 = (TextView)itemView.findViewById(R.id.lbl_item4);

			STDailyScore score = arrDailyScores.get(i);
			if (!isBoss) {
				if (i == 0) {
					// Create title view
					txtItem1.setText("名称");
					txtItem2.setText("代销商");
					txtItem3.setText("员工");
					txtItem4.setText("成交价");
				} else {
					txtItem1.setText(score.name);
					txtItem2.setText(score.agent);
					txtItem3.setText(StringUtility.formatDouble(score.price));
					txtItem4.setText(StringUtility.formatDouble(score.actual));
				}
			} else {
				if (i == 0) {
					// Create title view
					txtItem1.setText("名称");
					txtItem2.setText("自营业绩");
					txtItem3.setText("代销商业绩");
					txtItem4.setText("合计");
				} else {
					txtItem1.setText(score.name);
					txtItem2.setText(StringUtility.formatDouble(score.employee_score));
					txtItem3.setText(StringUtility.formatDouble(score.agent_score));
					txtItem4.setText(StringUtility.formatDouble(score.daily_total));
				}
			}

			items_layout.addView(itemView);
		}

		ResolutionUtility.instance.iterateChild(items_layout, screen_size.x, screen_size.y);

		content_layout.addView(items_layout);
	}

}
