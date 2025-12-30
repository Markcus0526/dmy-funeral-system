package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.TDScrollView;
import com.damytech.structure.custom.STEmpScore_Manager;
import com.damytech.structure.custom.STScore_Manager;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.StringUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 16:20
 * File Name : GeRenYeJiZhuRenActivity
 */
public class GeRenYeJiZhuRenActivity extends SuperActivity {
	private TDScrollView scroll_view = null;

	private ArrayList<STEmpScore_Manager> arrEmpScores = new ArrayList<STEmpScore_Manager>();
	private ArrayList<ViewItem> arrViewItems = new ArrayList<ViewItem>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_gerenyeji_zhuren);
	}


	@Override
	protected void initializeActivity() {
		scroll_view = (TDScrollView)findViewById(R.id.scroll_view);

		startProgress();
		CommManager.getEmployeePersonalScoreMgr(AppCommon.loadUserIDLong(getApplicationContext()),
				comm_delegate);
	}



	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getEmployeePersonalScoreMgrResult(int retcode, String retmsg, ArrayList<STEmpScore_Manager> arrScores) {
			super.getEmployeePersonalScoreMgrResult(retcode, retmsg, arrScores);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrEmpScores.clear();
				arrViewItems.clear();

				arrEmpScores.addAll(arrScores);
				updateUI();
			} else {
				ToastUtility.showToast(GeRenYeJiZhuRenActivity.this, retmsg);
			}
		}
	};


	public class ViewItem
	{
		public String emp_name = "";
		public String month = "";
		public String agent = "";
		public String employee = "";
		public String self_rate = "";
		public String response = "";
		public String month_total = "";
		public String success_rate = "";
	}


	private void updateUI() {
		ViewGroup content_layout = (ViewGroup)scroll_view.getContentLayout();
		content_layout.removeAllViews();

		LinearLayout itemsLayout = new LinearLayout(scroll_view.getContentLayout().getContext());
		itemsLayout.setOrientation(LinearLayout.VERTICAL);

		// Add item for title
		ViewItem title_item = new ViewItem();
		title_item.emp_name = "员工名称";
		title_item.month = "区分";
		title_item.agent = "代销商本月业绩累计";
		title_item.employee = "员工本月业绩累计";
		title_item.self_rate = "自营比例";
		title_item.response = "责任额";
		title_item.month_total = "本月总业绩";
		title_item.success_rate = "达成比例";
		arrViewItems.add(title_item);


		for (int i = 0; i < arrEmpScores.size(); i++) {
			STEmpScore_Manager emp_score = arrEmpScores.get(i);

			ViewItem sub_total = new ViewItem();
			sub_total.month = "总合计";

			double agent = 0, employee = 0, response = 0, month_total = 0;

			for (int j = 0; j < emp_score.scores.size(); j++) {
				STScore_Manager score_info = emp_score.scores.get(j);

				ViewItem view_item = new ViewItem();
				if (j == 0) {
					view_item.emp_name = emp_score.user_name;
				}

				view_item.month = "" + score_info.month + "月";
				view_item.agent = StringUtility.formatDouble(score_info.agent);
				view_item.employee = StringUtility.formatDouble(score_info.employee);
				view_item.self_rate = StringUtility.formatDouble(score_info.self_rate) + "%";
				view_item.response = StringUtility.formatDouble(score_info.response_value);
				view_item.month_total = StringUtility.formatDouble(score_info.monthly_total);
				view_item.success_rate = StringUtility.formatDouble(score_info.success_rate) + "%";

				agent += score_info.agent;
				employee += score_info.employee;
				response += score_info.response_value;
				month_total += score_info.monthly_total;

				arrViewItems.add(view_item);
			}

			sub_total.agent = StringUtility.formatDouble(agent);
			sub_total.employee = StringUtility.formatDouble(employee);
			sub_total.response = StringUtility.formatDouble(response);
			sub_total.month_total = StringUtility.formatDouble(month_total);
			sub_total.self_rate = StringUtility.formatDouble((int)(employee * 100 / (agent + employee))) + "%";
			sub_total.success_rate = StringUtility.formatDouble((int)((agent + employee) * 100 / response)) + "%";

			arrViewItems.add(sub_total);
		}


		for (int i = 0; i < arrViewItems.size(); i++) {
			ViewItem view_item = arrViewItems.get(i);

			View itemView = getLayoutInflater().inflate(R.layout.item_gerenyeji_zhuren_layout, null);
			ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, 60);
			itemView.setLayoutParams(params);

			TextView txtItem1 = (TextView)itemView.findViewById(R.id.lbl_item1);
			TextView txtItem2 = (TextView)itemView.findViewById(R.id.lbl_item2);
			TextView txtItem3 = (TextView)itemView.findViewById(R.id.lbl_item3);
			TextView txtItem4 = (TextView)itemView.findViewById(R.id.lbl_item4);
			TextView txtItem5 = (TextView)itemView.findViewById(R.id.lbl_item5);
			TextView txtItem6 = (TextView)itemView.findViewById(R.id.lbl_item6);
			TextView txtItem7 = (TextView)itemView.findViewById(R.id.lbl_item7);
			TextView txtItem8 = (TextView)itemView.findViewById(R.id.lbl_item8);

			txtItem1.setText(view_item.emp_name);
			txtItem2.setText(view_item.month);
			txtItem3.setText(view_item.agent);
			txtItem4.setText(view_item.employee);
			txtItem5.setText(view_item.self_rate);
			txtItem6.setText(view_item.response);
			txtItem7.setText(view_item.month_total);
			txtItem8.setText(view_item.success_rate);

			itemsLayout.addView(itemView);
		}

		ResolutionUtility.instance.iterateChild(itemsLayout, screen_size.x, screen_size.y);

		scroll_view.addView(itemsLayout);
	}

}
