package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.preset_controls.WheelPicker.OnWheelChangedListener;
import com.damytech.preset_controls.WheelPicker.WheelAdapter;
import com.damytech.preset_controls.WheelPicker.WheelView;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-22
 * Time : 00:34
 * File Name : XiuJiaShenQingActivity
 */
public class XiuJiaShenQingActivity extends SuperActivity {
	private static final int YEAR_START = 1900;
	private static final int YEAR_END   = 2050;


	private int vocation_type = ConstMgr.VOCATION_TYPE_NORMAL;

	private TextView txtDate = null;

	private ImageView imgNormal = null, imgIllness = null, imgOthers = null;
	private ImageButton btnNormal = null, btnIllness = null, btnOthers = null;

	private WheelView yearWheelView = null, monthWheelView = null, dayWheelView = null;
	private WheelAdapter yearWheelAdapter = null, monthWheelAdapter = null, dayWheelAdapter = null;

	private ArrayList<Integer> arrYears = new ArrayList<Integer>();
	private ArrayList<Integer> arrMonths = new ArrayList<Integer>();
	private ArrayList<Integer> arrDays = new ArrayList<Integer>();

	private Button btnSubmit = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_xiujiashenqing);
	}


	@Override
	protected void initializeActivity() {
		txtDate = (TextView)findViewById(R.id.txt_date);

		imgNormal = (ImageView)findViewById(R.id.img_normal);
		imgIllness = (ImageView)findViewById(R.id.img_illness);
		imgOthers = (ImageView)findViewById(R.id.img_others);

		btnNormal = (ImageButton)findViewById(R.id.btn_normal);
		btnIllness = (ImageButton)findViewById(R.id.btn_illness);
		btnOthers = (ImageButton)findViewById(R.id.btn_others);

		btnNormal.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedNormal();
			}
		});
		btnIllness.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedIllness();
			}
		});
		btnOthers.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedOthers();
			}
		});


		btnSubmit = (Button)findViewById(R.id.btn_confirm);
		btnSubmit.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedSubmit();
			}
		});


		yearWheelView = (WheelView)findViewById(R.id.year_view);
		monthWheelView = (WheelView)findViewById(R.id.month_view);
		dayWheelView = (WheelView)findViewById(R.id.day_view);

		yearWheelView.setCyclic(true);
		monthWheelView.setCyclic(true);
		dayWheelView.setCyclic(true);

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

		yearWheelView.setAdapter(yearWheelAdapter);
		monthWheelView.setAdapter(monthWheelAdapter);
		dayWheelView.setAdapter(dayWheelAdapter);

		// Initialize wheel selector
		Calendar cal = Calendar.getInstance();

		yearWheelView.setCurrentItem(cal.get(Calendar.YEAR) - YEAR_START);
		monthWheelView.setCurrentItem(cal.get(Calendar.MONTH));
		dayWheelView.setCurrentItem(cal.get(Calendar.DAY_OF_MONTH) - 1);

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

		dayWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				onDayUpdated();
			}
		});

		onYearUpdated();
		onMonthUpdated();

		dateUpdated();
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

		dateUpdated();
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

		dateUpdated();
	}


	private void onDayUpdated() {
		dateUpdated();
	}


	private void dateUpdated() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, getCurYear());
		cal.set(Calendar.MONTH, getCurMonth() - 1);
		cal.set(Calendar.DAY_OF_MONTH, getCurDay());

		int nDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		txtDate.setText(String.format("%04d年%02d月%02d日", getCurYear(), getCurMonth(), getCurDay()) + getDayOfWeekDesc(nDayOfWeek));
	}


	private String getDayOfWeekDesc(int day) {
		String result = "";

		switch (day) {
			case Calendar.SUNDAY:
				result = "星期天";
				break;
			case Calendar.MONDAY:
				result = "星期一";
				break;
			case Calendar.TUESDAY:
				result = "星期二";
				break;
			case Calendar.WEDNESDAY:
				result = "星期三";
				break;
			case Calendar.THURSDAY:
				result = "星期四";
				break;
			case Calendar.FRIDAY:
				result = "星期五";
				break;
			case Calendar.SATURDAY:
				result = "星期六";
				break;
		}

		return result;
	}


	private void onClickedNormal() {
		imgNormal.setImageResource(R.drawable.bk_radio_sel);
		imgIllness.setImageResource(R.drawable.bk_radio_normal);
		imgOthers.setImageResource(R.drawable.bk_radio_normal);

		vocation_type = ConstMgr.VOCATION_TYPE_NORMAL;
	}

	private void onClickedIllness() {
		imgNormal.setImageResource(R.drawable.bk_radio_normal);
		imgIllness.setImageResource(R.drawable.bk_radio_sel);
		imgOthers.setImageResource(R.drawable.bk_radio_normal);

		vocation_type = ConstMgr.VOCATION_TYPE_ILLNESS;
	}

	private void onClickedOthers() {
		imgNormal.setImageResource(R.drawable.bk_radio_normal);
		imgIllness.setImageResource(R.drawable.bk_radio_normal);
		imgOthers.setImageResource(R.drawable.bk_radio_sel);

		vocation_type = ConstMgr.VOCATION_TYPE_OTHERS;
	}


	private void onClickedSubmit() {
		String date = String.format("%04d-%02d-%02d", getCurYear(), getCurMonth(), getCurDay());

		startProgress();
		CommManager.submitVocation(AppCommon.loadUserIDLong(getApplicationContext()),
				vocation_type,
				date,
				submit_delegate);
	}


	private CommDelegate submit_delegate = new CommDelegate() {
		@Override
		public void submitVocationResult(int retcode, String retmsg) {
			super.submitVocationResult(retcode, retmsg);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				ToastUtility.showToast(XiuJiaShenQingActivity.this, "申请成功!");
				popOverCurActivityAnimated();
			} else {
				ToastUtility.showToast(XiuJiaShenQingActivity.this, retmsg);
			}
		}
	};


}
