package com.damytech.binzang.dialogs.preset;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import com.damytech.binzang.R;
import com.damytech.preset_controls.WheelPicker.OnWheelChangedListener;
import com.damytech.preset_controls.WheelPicker.WheelAdapter;
import com.damytech.preset_controls.WheelPicker.WheelView;
import com.damytech.utils.CalendarUtility;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 2/5/2015
 * To change this template use File | Settings | File Templates.
 */
public class CommonDateTimePickerDialog extends SuperDialog {
	public static final int PICKER_TYPE_DATE = 0;
	public static final int PICKER_TYPE_DATETIME = 1;
	public static final int PICKER_TYPE_DATEHOUR = 2;

	private int picker_type = PICKER_TYPE_DATETIME;


	private WheelView yearWheelView = null;
	private WheelView monthWheelView = null;
	private WheelView dayWheelView = null;
	private WheelView hourWheelView = null;
	private WheelView minuteWheelView = null;

	private WheelAdapter minuteWheelAdapter = null;
	private WheelAdapter hourWheelAdapter = null;
	private WheelAdapter dayWheelAdapter = null;
	private WheelAdapter monthWheelAdapter = null;
	private WheelAdapter yearWheelAdapter = null;

	private Button btnConfirm = null, btnCancel = null;


	private ArrayList<Integer> arrYears = new ArrayList<Integer>();
	private ArrayList<Integer> arrMonths = new ArrayList<Integer>();
	private ArrayList<Integer> arrDays = new ArrayList<Integer>();
	private ArrayList<Integer> arrHours = new ArrayList<Integer>();
	private ArrayList<Integer> arrMinutes = new ArrayList<Integer>();


	private int curYear = 2000;
	private int curMonth = 1;
	private int curDay = 1;
	private int curHour = 0;
	private int curMinute = 0;

	private static final int YEAR_START = 1900;
	private static final int YEAR_END   = 2050;


	private DateTimeSelectDelegate delegate = null;


	public static CommonDateTimePickerDialog createDialog(Context context) {
		return new CommonDateTimePickerDialog(context);
	}



	public CommonDateTimePickerDialog(Context context) {
		super(context);
		setTime(Calendar.getInstance().getTime());
	}


	public CommonDateTimePickerDialog(Context context, Date date) {
		super(context);
		setTime(date);
	}


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.preset_dlg_datetime);
		getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));

		initialize();
	}


	@Override
	protected void initControls() {
		// Picker views
		yearWheelView = (WheelView) findViewById(R.id.year_wheel_view);
		monthWheelView = (WheelView) findViewById(R.id.month_wheel_view);
		dayWheelView = (WheelView) findViewById(R.id.day_wheel_view);
		hourWheelView = (WheelView) findViewById(R.id.hour_wheel_view);
		minuteWheelView = (WheelView) findViewById(R.id.minute_wheel_view);


		if (picker_type == PICKER_TYPE_DATE) {
			hourWheelView.setVisibility(View.GONE);
			minuteWheelView.setVisibility(View.GONE);
		} else if (picker_type == PICKER_TYPE_DATETIME) {
			hourWheelView.setVisibility(View.VISIBLE);
			minuteWheelView.setVisibility(View.VISIBLE);
		} else if (picker_type == PICKER_TYPE_DATEHOUR) {
			hourWheelView.setVisibility(View.VISIBLE);
			minuteWheelView.setVisibility(View.GONE);
		}


		btnConfirm = (Button)findViewById(R.id.btn_confirm);
		btnConfirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedConfirm();
			}
		});

		btnCancel = (Button)findViewById(R.id.btn_cancel);
		btnCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCancel();
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

		for (int i = 0; i < 60; i++) {
			arrMinutes.add(i);
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

		minuteWheelAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() {
				return arrMinutes.size();
			}
			@Override
			public String getItem(int index) {
				return "" + arrMinutes.get(index) + "分";
			}
			@Override
			public int getMaximumLength() {
				return arrMinutes.size();
			}
		};

		yearWheelView.setAdapter(yearWheelAdapter);
		monthWheelView.setAdapter(monthWheelAdapter);
		dayWheelView.setAdapter(dayWheelAdapter);
		hourWheelView.setAdapter(hourWheelAdapter);
		minuteWheelView.setAdapter(minuteWheelAdapter);


		// Initialize wheel selector
		yearWheelView.setCurrentItem(curYear - YEAR_START);
		monthWheelView.setCurrentItem(curMonth - 1);
		dayWheelView.setCurrentItem(curDay - 1);
		hourWheelView.setCurrentItem(curHour);
		minuteWheelView.setCurrentItem(curMinute);


		yearWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				curYear = arrYears.get(yearWheelView.getCurrentItem());
				onYearUpdated();
			}
		});

		monthWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				curMonth = arrMonths.get(monthWheelView.getCurrentItem());
				onMonthUpdated();
			}
		});

		dayWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				curDay = arrDays.get(dayWheelView.getCurrentItem());
			}
		});

		hourWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				curHour = arrHours.get(hourWheelView.getCurrentItem());
			}
		});

		minuteWheelView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				curMinute = arrMinutes.get(minuteWheelView.getCurrentItem());
			}
		});

		onYearUpdated();
		onMonthUpdated();

		findViewById(R.id.btn_cancel).setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				dismiss();
			}
		});
	}


	protected void onMonthUpdated() {
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

	protected void onYearUpdated() {
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


	// methods to get result
	public Date getTime() {
		Calendar cal = Calendar.getInstance();

		cal.set(Calendar.YEAR, curYear);
		cal.set(Calendar.MONTH, curMonth - 1);
		cal.set(Calendar.DAY_OF_MONTH, curDay);

		if (picker_type == PICKER_TYPE_DATE) {
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
		} else if (picker_type == PICKER_TYPE_DATETIME) {
			cal.set(Calendar.HOUR_OF_DAY, curHour);
			cal.set(Calendar.MINUTE, curMinute);
		} else if (picker_type == PICKER_TYPE_DATEHOUR) {
			cal.set(Calendar.HOUR_OF_DAY, curHour);
			cal.set(Calendar.MINUTE, 0);
		}

		return cal.getTime();
	}


	public String getTimeAsString(String format) {
		String szTime = null;

		Date dtVal = getTime();
		szTime = CalendarUtility.date2String(dtVal, format);

		return szTime;
	}


	public int getCurYear() { return curYear; }
	public int getCurMonth() { return curMonth; }
	public int getCurDay() { return curDay; }
	public int getCurHour() { return curHour; }
	public int getCurMinute() { return curMinute; }


	// methods to set value to dialog
	public CommonDateTimePickerDialog setTime(String szTime, String format) {
		Date dtVal = CalendarUtility.string2Date(szTime, format);
		setTime(dtVal);
		return CommonDateTimePickerDialog.this;
	}


	public CommonDateTimePickerDialog setTime(Date date) {
		Calendar cal = Calendar.getInstance();
		if (date != null)
			cal.setTime(date);

		curYear = cal.get(Calendar.YEAR);
		curMonth = cal.get(Calendar.MONTH) + 1;
		curDay = cal.get(Calendar.DAY_OF_MONTH);
		curHour = cal.get(Calendar.HOUR_OF_DAY);
		curMinute = cal.get(Calendar.MINUTE);


		if (yearWheelView != null)
			yearWheelView.setCurrentItem(curYear - YEAR_START);

		if (monthWheelView != null)
			monthWheelView.setCurrentItem(curMonth - 1);

		if (dayWheelView != null)
			dayWheelView.setCurrentItem(curDay - 1);

		if (hourWheelView != null)
			hourWheelView.setCurrentItem(curHour);

		if (minuteWheelView != null)
			minuteWheelView.setCurrentItem(curMinute);

		onMonthUpdated();
		onYearUpdated();

		return CommonDateTimePickerDialog.this;
	}


	public CommonDateTimePickerDialog setPickerType(int type) {
		picker_type = type;

		if (picker_type == PICKER_TYPE_DATE) {
			if (hourWheelView != null)
				hourWheelView.setVisibility(View.GONE);
			if (minuteWheelView != null)
				minuteWheelView.setVisibility(View.GONE);
		} else if (picker_type == PICKER_TYPE_DATETIME) {
			if (hourWheelView != null)
				hourWheelView.setVisibility(View.VISIBLE);
			if (minuteWheelView != null)
				minuteWheelView.setVisibility(View.VISIBLE);
		} else if (picker_type == PICKER_TYPE_DATEHOUR) {
			if (hourWheelView != null)
				hourWheelView.setVisibility(View.VISIBLE);
			if (minuteWheelView != null)
				minuteWheelView.setVisibility(View.GONE);
		}

		return CommonDateTimePickerDialog.this;
	}


	public CommonDateTimePickerDialog setDelegate(DateTimeSelectDelegate delegate) {
		CommonDateTimePickerDialog.this.delegate = delegate;
		return CommonDateTimePickerDialog.this;
	}



	private void onClickedConfirm() {
		CommonDateTimePickerDialog.this.dismiss();

		if (delegate != null) {
			Calendar cal = Calendar.getInstance();

			cal.set(Calendar.YEAR, curYear);
			cal.set(Calendar.MONTH, curMonth - 1);
			cal.set(Calendar.DAY_OF_MONTH, curDay);

			String format = "";
			if (picker_type == PICKER_TYPE_DATE) {
				cal.set(Calendar.HOUR_OF_DAY, 0);
				cal.set(Calendar.MINUTE, 0);

				format = "yyyy-MM-dd";
			} else if (picker_type == PICKER_TYPE_DATETIME) {
				cal.set(Calendar.HOUR_OF_DAY, curHour);
				cal.set(Calendar.MINUTE, curMinute);

				format = "yyyy-MM-dd HH:mm";
			} else if (picker_type == PICKER_TYPE_DATEHOUR) {
				cal.set(Calendar.HOUR_OF_DAY, curHour);
				cal.set(Calendar.MINUTE, 0);

				format = "yyyy-MM-dd HH:00";
			}

			String szTime = CalendarUtility.date2String(cal.getTime(), format);
			delegate.onDateSelected(szTime, cal.getTime());
		}
	}


	private void onClickedCancel() {
		CommonDateTimePickerDialog.this.dismiss();
	}


	public interface DateTimeSelectDelegate {
		public void onDateSelected(String szDate, Date dtVal);
	}


}
