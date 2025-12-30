package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.provider.Settings;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.binzang.dialogs.preset.CommonSelectSingleDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.CheckButton;
import com.damytech.preset_controls.WheelPicker.OnWheelChangedListener;
import com.damytech.preset_controls.WheelPicker.WheelAdapter;
import com.damytech.preset_controls.WheelPicker.WheelView;
import com.damytech.structure.custom.STCustomer;
import com.damytech.structure.custom.STTomb;
import com.damytech.utils.ToastUtility;
import com.damytech.utils.UIUtility;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 10:19
 * File Name : LuoZangYiShiYuYueActivity_TabFrame1
 */
public class YiShiYuYueActivity_TabFrame1 extends SuperTabActivity.TabFrame {
	private RelativeLayout user_layout = null;
	private RelativeLayout daijibai_layout = null;
	private EditText txt_username = null;
	private EditText txt_userphone = null;

	// Only for agent or employee
	private ArrayList<STCustomer> arrCustomerList = new ArrayList<STCustomer>();

	// Only for customer
	private ArrayList<STTomb> arrCustomerTombs = new ArrayList<STTomb>();


	private WheelView yearWheelView = null;
	private WheelView monthWheelView = null;
	private WheelView dayWheelView = null;
	private WheelView hourWheelView = null;
	private CheckButton btnDaijibai = null;

	private Button btnCancel = null, btnNext = null;

	private WheelAdapter yearWheelAdapter = null;
	private WheelAdapter monthWheelAdapter = null;
	private WheelAdapter dayWheelAdapter = null;
	private WheelAdapter hourWheelAdapter = null;

	private ArrayList<Integer> arrYears = new ArrayList<Integer>();
	private ArrayList<Integer> arrMonths = new ArrayList<Integer>();
	private ArrayList<Integer> arrDays = new ArrayList<Integer>();
	private ArrayList<Integer> arrHours = new ArrayList<Integer>();

	private static final int YEAR_START = 1900;
	private static final int YEAR_END   = 2050;


	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_yishiyuyue_tab1, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		YiShiYuYueActivity luozangActivity = (YiShiYuYueActivity)parentActivity;

		user_layout = (RelativeLayout)parentView.findViewById(R.id.user_layout);
		txt_username = (EditText)parentView.findViewById(R.id.edt_name);
		txt_userphone = (EditText)parentView.findViewById(R.id.edt_phone);

		daijibai_layout = (RelativeLayout)parentView.findViewById(R.id.daijibai_layout);

		if (luozangActivity.is_agent) {
			user_layout.setVisibility(View.VISIBLE);
			daijibai_layout.setVisibility(View.GONE);
		} else {
			user_layout.setVisibility(View.GONE);
			if(luozangActivity.need_bury_service)
				daijibai_layout.setVisibility(View.GONE);
			else
				daijibai_layout.setVisibility(View.VISIBLE);
		}

		yearWheelView = (WheelView)parentView.findViewById(R.id.year_view);
		monthWheelView = (WheelView)parentView.findViewById(R.id.month_view);
		dayWheelView = (WheelView)parentView.findViewById(R.id.day_view);
		hourWheelView = (WheelView)parentView.findViewById(R.id.time_view);

		yearWheelView.setCyclic(true);
		monthWheelView.setCyclic(true);
		dayWheelView.setCyclic(true);
		hourWheelView.setCyclic(true);

		btnDaijibai = (CheckButton)parentView.findViewById(R.id.btn_daijibai);

		btnCancel = (Button)parentView.findViewById(R.id.btn_cancel);
		btnCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCancel();
			}
		});
		btnNext = (Button)parentView.findViewById(R.id.btn_next);
		btnNext.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedNext();
			}
		});

		// Initialize time spans
		for (int i = YEAR_START; i <= YEAR_END; i++) {
			arrYears.add(i);
		}

		for (int i = Calendar.JANUARY; i <= Calendar.DECEMBER; i++) {
			arrMonths.add(i + 1);
		}

		for (int i = 1; i <= 31; i++) {
			arrDays.add(i);
		}

		for (int i = 0; i < 24; i++) {
			arrHours.add(i);
		}

		yearWheelAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() {
				return arrYears.size();
			}
			@Override
			public String getItem(int index) {
				return "" + arrYears.get(index) + "年";
			}
			@Override
			public int getMaximumLength() {
				return arrYears.size();
			}
		};

		monthWheelAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() {
				return arrMonths.size();
			}
			@Override
			public String getItem(int index) {
				return "" + arrMonths.get(index) + "月";
			}
			@Override
			public int getMaximumLength() {
				return arrMonths.size();
			}
		};

		dayWheelAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() {
				return arrDays.size();
			}
			@Override
			public String getItem(int index) {
				return "" + arrDays.get(index) + "日";
			}
			@Override
			public int getMaximumLength() {
				return arrDays.size();
			}
		};

		hourWheelAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() {
				return arrHours.size();
			}
			@Override
			public String getItem(int index) {
				return "" + arrHours.get(index) + "时";
			}
			@Override
			public int getMaximumLength() {
				return arrHours.size();
			}
		};

		yearWheelView.setAdapter(yearWheelAdapter);
		monthWheelView.setAdapter(monthWheelAdapter);
		dayWheelView.setAdapter(dayWheelAdapter);
		hourWheelView.setAdapter(hourWheelAdapter);

		// Initialize wheel selector
		Calendar cal = Calendar.getInstance();
		yearWheelView.setCurrentItem(cal.get(Calendar.YEAR) - YEAR_START);
		monthWheelView.setCurrentItem(cal.get(Calendar.MONTH));
		dayWheelView.setCurrentItem(cal.get(Calendar.DAY_OF_MONTH) - 1);
		hourWheelView.setCurrentItem(cal.get(Calendar.HOUR_OF_DAY));

		yearWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				onYearUpdated();
			}
		});

		monthWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				onMonthUpdated();
			}
		});

		onYearUpdated();
		onMonthUpdated();


		if (luozangActivity.is_agent) {
			startProgress();
			CommManager.getCustomerList(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
					comm_delegate);
		} else {
			startProgress();
			CommManager.getTombListForCustomer(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
					comm_delegate);
		}
	}



	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getCustomerListResult(int retcode, String retmsg, ArrayList<STCustomer> arrCustomers) {
			super.getCustomerListResult(retcode, retmsg, arrCustomers);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrCustomerList.clear();
				arrCustomerList.addAll(arrCustomers);
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}


		@Override
		public void getTombListForCustomerResult(int retcode, String retmsg, ArrayList<STTomb> arrTombs) {
			super.getTombListForCustomerResult(retcode, retmsg, arrTombs);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrCustomerTombs.clear();
				arrCustomerTombs.addAll(arrTombs);
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};


	private int getCurYear() {
		return YEAR_START + yearWheelView.getCurrentItem();
	}

	private int getCurMonth() {
		return 1 + monthWheelView.getCurrentItem();
	}

	private int getCurDay() {
		return 1 + dayWheelView.getCurrentItem();
	}

	private int getCurHour() {
		return hourWheelView.getCurrentItem();
	}

	protected void onYearUpdated() {
		int curYear = getCurYear();
		int curMonth = getCurMonth();

		if (curMonth == 2 ) {
			arrDays.clear();

			if (curYear % 4 == 0 ) {
				for (int i = 1; i <= 29; i++ )
					arrDays.add(i);
			} else {
				for (int i = 1; i <= 28; i++ )
					arrDays.add(i);
			}
		}

		if (dayWheelView != null)
			dayWheelView.invalidate();
	}


	protected void onMonthUpdated() {
		int curYear = getCurYear();
		int curMonth = getCurMonth();

		switch(curMonth) {
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				arrDays.clear();
				for (int i = 1; i <= 31; i++ )
					arrDays.add(i);
				break;

			case 2:
				arrDays.clear();

				if (curYear % 4 == 0) {
					for (int i = 1; i <= 29; i++)
						arrDays.add(i);
				} else {
					for (int i = 1; i <= 28; i++)
						arrDays.add(i);
				}

				if (dayWheelView != null && dayWheelView.getCurrentItem() + 1 >= 29 )
					dayWheelView.setCurrentItem(28 - 1);
				break;

			case 4:
			case 6:
			case 9:
			case 11:
				arrDays.clear();

				for (int i = 1; i <= 30; i++ )
					arrDays.add(i);

				if (dayWheelView != null && dayWheelView.getCurrentItem() + 1 >= 31 )
					dayWheelView.setCurrentItem(30 - 1);
				break;
		}

		if (dayWheelView != null)
			dayWheelView.invalidate();
	}





	private void onClickedCancel() {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(parentActivity)
				.message("确定要取消吗？")
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						parentActivity.popOverCurActivityAnimated();
					}
				})
				.build();
		dialog.show();
	}



	private void onClickedNext() {
		final YiShiYuYueActivity luozangActivity = (YiShiYuYueActivity)parentActivity;
		luozangActivity.sel_time = String.format("%04d-%02d-%02d %02d:00:00", getCurYear(), getCurMonth(), getCurDay(), getCurHour());
		if(btnDaijibai.getState() == CheckButton.CHECKSTATE_OFF) {
			luozangActivity.is_deputyservice = 0;
		}
		else {
			luozangActivity.is_deputyservice = 1;
		}


		STCustomer customer = null;
		if (luozangActivity.is_agent) {
			if (arrCustomerList.isEmpty()) {
				ToastUtility.showToast(parentActivity, "抱歉，现在没有用户信息，暂时不能预约");
				return;
			}

			if (txt_username.getText().toString().equals("")) {
				ToastUtility.showToast(parentActivity, "请输入用户名");
				UIUtility.selectAllText(txt_username);
				return;
			} else if (txt_userphone.getText().toString().equals("")) {
				ToastUtility.showToast(parentActivity, "请输入用户手机号码");
				UIUtility.selectAllText(txt_userphone);
				return;
			}

			for (int i = 0; i < arrCustomerList.size(); i++) {
				STCustomer item = arrCustomerList.get(i);
				if (item.name.equals(txt_username.getText().toString()) &&
						item.phone.equals(txt_userphone.getText().toString()))
				{
					customer = item;
					break;
				}
			}

			if (customer == null) {
				ToastUtility.showToast(parentActivity, "用户信息不符合, 请查看！");
				return;
			}

			luozangActivity.customer_id = customer.uid;

			arrCustomerTombs = customer.tombs;
		}
		else {
			luozangActivity.customer_id = AppCommon.loadUserIDLong(parentActivity.getApplicationContext());
		}



		if (luozangActivity.tomb_id <= 0) {
			ArrayList<String> tomb_names = new ArrayList<String>();
			for (int i = 0; i < arrCustomerTombs.size(); i++) {
				tomb_names.add(arrCustomerTombs.get(i).tomb_no);
			}

			if (tomb_names.isEmpty()) {
				//luozangActivity.tab_adapter.changeTab(2);
				ToastUtility.showToast(parentActivity, "这位客户还没购买墓地，无法预订祭品...");
				return;
			} else {
				CommonSelectSingleDialog dialog = new CommonSelectSingleDialog(parentActivity);
				dialog.initItemData(tomb_names);
				dialog.setDialogTitle("请选择祭拜墓地");
				dialog.delegate = new CommonSelectSingleDialog.SelectItemListener() {
					@Override
					public void onItemClicked(String item_data, int index) {
						STTomb tombInfo = arrCustomerTombs.get(index);
						luozangActivity.tomb_id = tombInfo.uid;
						if (luozangActivity.need_bury_service)
							luozangActivity.tab_adapter.changeTab(1);
						else
							luozangActivity.tab_adapter.changeTab(2);
					}
				};
				dialog.show();
			}
		} else {
			if (luozangActivity.need_bury_service)
				luozangActivity.tab_adapter.changeTab(1);
			else
				luozangActivity.tab_adapter.changeTab(2);
		}
	}

}
