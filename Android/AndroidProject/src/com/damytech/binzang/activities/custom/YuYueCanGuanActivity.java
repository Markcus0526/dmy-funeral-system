package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonSelectSingleDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WheelPicker.OnWheelChangedListener;
import com.damytech.preset_controls.WheelPicker.WheelAdapter;
import com.damytech.preset_controls.WheelPicker.WheelView;
import com.damytech.structure.custom.STOffice;
import com.damytech.structure.custom.STOfficeCity;
import com.damytech.utils.ToastUtility;
import com.damytech.utils.UIUtility;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:04
 * File Name : YuYueCanGuanActivity
 */
public class YuYueCanGuanActivity extends SuperActivity {
	private WheelView yearWheelView = null;
	private WheelView monthWheelView = null;
	private WheelView dayWheelView = null;
	private WheelView hourWheelView = null;

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


	private EditText edt_phone = null;
	private EditText edt_nickname = null;
	private TextView txtCity = null;
	private TextView txtOffice = null;
	private ImageButton btnCity = null;
	private ImageButton btnOffice = null;

	private Button btn_confirm = null;

	private ArrayList<STOfficeCity> arrCities = new ArrayList<STOfficeCity>();

	private STOfficeCity office_city = null;
	private STOffice office = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yuyuecanguan);
	}

	@Override
	protected void initializeActivity() {
		edt_phone = (EditText)findViewById(R.id.edt_phone);
		edt_nickname = (EditText)findViewById(R.id.edt_nickname);

		txtCity = (TextView)findViewById(R.id.txt_city_name);
		txtOffice = (TextView)findViewById(R.id.txt_office_name);
		btnCity = (ImageButton)findViewById(R.id.btn_city);
		btnCity.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCity();
			}
		});
		btnOffice = (ImageButton)findViewById(R.id.btn_office);
		btnOffice.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedOffice();
			}
		});

		btn_confirm = (Button)findViewById(R.id.btn_confirm);
		btn_confirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedConfirm();
			}
		});


		yearWheelView = (WheelView)findViewById(R.id.year_view);
		monthWheelView = (WheelView)findViewById(R.id.month_view);
		dayWheelView = (WheelView)findViewById(R.id.day_view);
		hourWheelView = (WheelView)findViewById(R.id.hour_view);

		ArrayList<View> arrViews = new ArrayList<View>();
		arrViews.add(yearWheelView);
		arrViews.add(monthWheelView);
		arrViews.add(dayWheelView);
		arrViews.add(hourWheelView);

		View scroll_view = findViewById(R.id.scrollview);
		registerChildScrollViews(scroll_view, arrViews);

		yearWheelView.setCyclic(true);
		monthWheelView.setCyclic(true);
		dayWheelView.setCyclic(true);
		hourWheelView.setCyclic(true);

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



		startProgress();
		CommManager.getOfficeIntros(comm_delegate);
	}



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




	private void onClickedConfirm() {
		if (edt_phone.getText().toString().equals("")) {
			ToastUtility.showToast(YuYueCanGuanActivity.this, "请输入电话号码");
			UIUtility.selectAllText(edt_phone);
			return;
		}


		if (edt_phone.getText().toString().length() < 11) {
			ToastUtility.showToast(YuYueCanGuanActivity.this, "电话号码必须为11位数字");
			UIUtility.selectAllText(edt_phone);
			return;
		}


		if (edt_nickname.getText().toString().equals("")) {
			ToastUtility.showToast(YuYueCanGuanActivity.this, "请输入称呼");
			UIUtility.selectAllText(edt_nickname);
			return;
		}


		String szTime = String.format("%04d-%02d-%02d %02d:00:00", getCurYear(), getCurMonth(), getCurDay(), getCurHour());

		startProgress();
		CommManager.reserveVisit(edt_phone.getText().toString(),
				edt_nickname.getText().toString(),
				office.uid,
				szTime,
				comm_delegate);
	}



	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void reserveVisitResult(int retcode, String retmsg) {
			super.reserveVisitResult(retcode, retmsg);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				// success progress
				ToastUtility.showToast(YuYueCanGuanActivity.this, retmsg);
				popOverCurActivityAnimated();
			} else {
				ToastUtility.showToast(YuYueCanGuanActivity.this, retmsg);
			}
		}


		@Override
		public void getOfficeIntrosResult(int retcode, String retmsg, ArrayList<STOfficeCity> arrCities) {
			super.getOfficeIntrosResult(retcode, retmsg, arrCities);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				YuYueCanGuanActivity.this.arrCities.clear();
				YuYueCanGuanActivity.this.arrCities.addAll(arrCities);

				updateUI();
			} else {
				ToastUtility.showToast(YuYueCanGuanActivity.this, retmsg);
			}
		}
	};



	private void onClickedCity() {
		if (office_city == null || office == null)
			return;

		ArrayList<String> arrItems = new ArrayList<String>();
		for (int i = 0; i < arrCities.size(); i++) {
			arrItems.add(arrCities.get(i).name);
		}

		CommonSelectSingleDialog dialog = new CommonSelectSingleDialog(YuYueCanGuanActivity.this);
		dialog.initItemData(arrItems);
		dialog.setDialogTitle("请选择城市");
		dialog.delegate = new CommonSelectSingleDialog.SelectItemListener() {
			@Override
			public void onItemClicked(String item_data, int index) {
				office_city = arrCities.get(index);
				txtCity.setText(office_city.name);
				updateOffices();
			}
		};
		dialog.show();
	}


	private void onClickedOffice() {
		if (office_city == null || office == null)
			return;

		ArrayList<String> arrItems = new ArrayList<String>();
		for (int i = 0; i < office_city.offices.size(); i++) {
			arrItems.add(office_city.offices.get(i).name);
		}

		CommonSelectSingleDialog dialog = new CommonSelectSingleDialog(YuYueCanGuanActivity.this);
		dialog.initItemData(arrItems);
		dialog.setDialogTitle("请选择办事处");
		dialog.delegate = new CommonSelectSingleDialog.SelectItemListener() {
			@Override
			public void onItemClicked(String item_data, int index) {
				office = office_city.offices.get(index);
				txtOffice.setText(office.name);
			}
		};
		dialog.show();
	}


	private void updateUI() {
		if (arrCities.size() == 0)
			return;

		office_city = arrCities.get(0);

		if (office_city.offices.size() == 0)
			return;

		office = office_city.offices.get(0);

		txtCity.setText(office_city.name);
		txtOffice.setText(office.name);
	}


	private void updateOffices() {
		if (office_city == null)
			return;

		if (office_city.offices.size() == 0)
			return;

		office = office_city.offices.get(0);

		txtOffice.setText(office.name);
	}


}

