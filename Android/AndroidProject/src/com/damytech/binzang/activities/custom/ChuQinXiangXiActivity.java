package com.damytech.binzang.activities.custom;

import android.content.Context;
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
import com.damytech.preset_controls.CalendarView;
import com.damytech.structure.custom.STVocation;
import com.damytech.utils.CalendarUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;
import org.json.JSONArray;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-22
 * Time : 17:23
 * File Name : ChuQinXiangXiActivity
 */
public class ChuQinXiangXiActivity extends SuperActivity {
	public static final String EXTRA_OFFICE_ID = "office_id";
	public static final String EXTRA_OFFICE_NAME = "office_name";
	public static final String EXTRA_TITLE = "activity_title";

	private String title = "", office_name = "";

	public ArrayList<STVocation> arrVocationInfo = new ArrayList<STVocation>();
	public ArrayList<STViewItem> arrViewItems = new ArrayList<STViewItem>();
	public ArrayList<CalendarView.STCalendarBadge> arrBadges = new ArrayList<CalendarView.STCalendarBadge>();

	private Date curDate = new Date();
	private CalendarView calView = null;

	private ListView listView = null;
	private DataAdapter adapter = null;

	private ImageButton btnPrev = null;
	private ImageButton btnNext = null;

	private ImageView imgCal = null;
	private ImageView imgList = null;
	private ImageButton btnCal = null;
	private ImageButton btnList = null;

	private RelativeLayout cal_layout = null;
	private RelativeLayout list_layout = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_chuqinxiangxi);
	}


	@Override
	protected void initializeActivity() {
		long office_id = getIntent().getLongExtra(EXTRA_OFFICE_ID, 0);
		title = getIntent().getStringExtra(EXTRA_TITLE);
		office_name = getIntent().getStringExtra(EXTRA_OFFICE_NAME);

		TextView txtTitle = (TextView)findViewById(R.id.txt_title);
		txtTitle.setText(title);

		calView = (CalendarView)findViewById(R.id.cal_view);
		calView.setCalendarListener(cal_listener);
		calView.getSettings().setSelectable(false);

		listView = (ListView)findViewById(R.id.list_logs);
		adapter = new DataAdapter(ChuQinXiangXiActivity.this, arrViewItems);
		listView.setAdapter(adapter);


		btnPrev = (ImageButton)findViewById(R.id.btn_prev);
		btnPrev.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPrev();
			}
		});
		btnNext = (ImageButton)findViewById(R.id.btn_next);
		btnNext.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedNext();
			}
		});


		imgCal = (ImageView)findViewById(R.id.img_cal);
		imgCal.setImageResource(R.drawable.bk_radio_sel);
		imgList = (ImageView)findViewById(R.id.img_list);
		imgList.setImageResource(R.drawable.bk_radio_normal);

		btnCal = (ImageButton)findViewById(R.id.btn_cal);
		btnCal.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCal();
			}
		});
		btnList = (ImageButton)findViewById(R.id.btn_list);
		btnList.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedList();
			}
		});

		cal_layout = (RelativeLayout)findViewById(R.id.cal_layout);
		cal_layout.setVisibility(View.VISIBLE);
		list_layout = (RelativeLayout)findViewById(R.id.list_layout);
		list_layout.setVisibility(View.GONE);

		startProgress();
		CommManager.getOfficeAttendance(AppCommon.loadUserIDLong(getApplicationContext()),
				office_id,
				attendance_handler);

	}



	private void onClickedPrev() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(curDate);
		cal.add(Calendar.MONTH, -1);

		curDate = cal.getTime();

		calView.getSettings().setCur_date(curDate);
		calView.invalidate();
	}

	private void onClickedNext() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(curDate);
		cal.add(Calendar.MONTH, 1);

		curDate = cal.getTime();

		calView.getSettings().setCur_date(curDate);
		calView.invalidate();
	}


	private void onClickedCal() {
		imgCal.setImageResource(R.drawable.bk_radio_sel);
		imgList.setImageResource(R.drawable.bk_radio_normal);

		cal_layout.setVisibility(View.VISIBLE);
		list_layout.setVisibility(View.GONE);
	}

	private void onClickedList() {
		imgCal.setImageResource(R.drawable.bk_radio_normal);
		imgList.setImageResource(R.drawable.bk_radio_sel);

		cal_layout.setVisibility(View.GONE);
		list_layout.setVisibility(View.VISIBLE);
	}



	private CommDelegate attendance_handler = new CommDelegate() {
		@Override
		public void getOfficeAttendanceResult(int retcode, String retmsg, ArrayList<STVocation> arrVocations) {
			super.getOfficeAttendanceResult(retcode, retmsg, arrVocations);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrVocationInfo.clear();
				arrVocationInfo.addAll(arrVocations);
				arrViewItems.clear();
				arrBadges.clear();

				updateUI();
			} else {
				ToastUtility.showToast(ChuQinXiangXiActivity.this, retmsg);
			}
		}
	};



	private void updateUI() {
		Calendar cal = Calendar.getInstance();
		Calendar cal_cur = Calendar.getInstance();


		// Initialize list view
		STViewItem title_view_item = new STViewItem();
		title_view_item.uid = 0;
		title_view_item.name = "名称";
		title_view_item.desc = "职位";
		title_view_item.month = "当月";
		title_view_item.year = "年度";
		arrViewItems.add(title_view_item);

		for (STVocation vocation : arrVocationInfo) {
			boolean exist_user = false;
			for (STViewItem view_item : arrViewItems) {
				if (vocation.user_id == view_item.uid) {
					exist_user = true;
					break;
				}
			}

			if (exist_user)
				continue;

			STViewItem view_item = new STViewItem();
			view_item.uid = vocation.user_id;
			view_item.name = vocation.user_name;
			view_item.desc = vocation.user_desc;
			arrViewItems.add(view_item);
		}


		for (STViewItem view_item : arrViewItems) {
			if (view_item.uid == 0)
				continue;

			int nYearCount = 0, nMonthCount = 0;
			for (STVocation vocation_item : arrVocationInfo) {
				if (view_item.uid != vocation_item.user_id)
					continue;

				try {
					Date dt_val = CalendarUtility.string2Date(vocation_item.date, "yyyy-MM-dd");
					cal.setTime(dt_val);
					if (cal.get(Calendar.YEAR) == cal_cur.get(Calendar.YEAR))
						nYearCount++;

					if (cal.get(Calendar.MONTH) == cal_cur.get(Calendar.MONTH))
						nMonthCount++;
				} catch (Exception ex) {
					ex.printStackTrace();
					cal = Calendar.getInstance();
				}
			}

			view_item.month = "" + nMonthCount + "天";
			view_item.year = "" + nYearCount + "天";
		}

		adapter.notifyDataSetChanged();


		// Initialize calendar badges
		ArrayList<String> arr_dates = new ArrayList<String>();
		for (STVocation vocation : arrVocationInfo) {
			boolean exist_date = false;
			for (String date_item : arr_dates) {
				if (date_item.contentEquals(vocation.date)) {
					exist_date = true;
					break;
				}
			}

			if (exist_date)
				continue;

			arr_dates.add(vocation.date);
		}


		for (String date_item : arr_dates) {
			int nCount = 0;
			for (STVocation vocation : arrVocationInfo) {
				if (vocation.date.contains(date_item))
					nCount++;
			}

			if (nCount > 0) {
				CalendarView.STCalendarBadge badge = new CalendarView.STCalendarBadge();
				badge.badgeText = "" + nCount;
				badge.dateValue = CalendarUtility.string2Date(date_item, "yyyy-MM-dd");
				arrBadges.add(badge);
			}
		}

		calView.getSettings().setBadges(arrBadges);
		calView.invalidate();
	}


	private CalendarView.CalendarListener cal_listener = new CalendarView.CalendarListener() {
		@Override
		public void onDateSelected(Date dt) {
			ArrayList<STVocation> arrVocations = new ArrayList<STVocation>();
			for (STVocation vocation : arrVocationInfo) {
				Date dtVal = CalendarUtility.string2Date(vocation.date, "yyyy-MM-dd");
				if (CalendarUtility.isSameDates(dtVal, dt)) {
					arrVocations.add(vocation);
				}
			}

			if (arrVocations.size() == 0)
				return;

			JSONArray arrJSONVocations = new JSONArray();
			for (STVocation vocation : arrVocations) {
				arrJSONVocations.put(vocation.encodeToJSON());
			}


			Bundle bundle = new Bundle();
			bundle.putString(ChuQinZhuangTaiActivity.EXTRA_VOCATIONS, arrJSONVocations.toString());
			bundle.putString(ChuQinZhuangTaiActivity.EXTRA_DESC, "'"
					+ office_name
					+ "'"
					+ CalendarUtility.date2String(dt, "yyyy年MM月dd日") + "出勤状况");

			pushNewActivityAnimated(ChuQinZhuangTaiActivity.class, bundle);
		}

		@Override
		public void onDateDeselected(Date dt) {}
	};


	public class STViewItem {
		public long uid = 0;
		public String name = "";
		public String desc = "";
		public String month = "";
		public String year = "";
	}



	public class STViewHolder {
		public TextView txtName = null;
		public TextView txtDesc = null;
		public TextView txtMonth = null;
		public TextView txtYear = null;
	}


	public class DataAdapter extends ArrayAdapter<STViewItem> {
		public DataAdapter(Context context, List<STViewItem> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_chuqinxinxi_layout, parent, false);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtName = (TextView)item_view.findViewById(R.id.txt_name);
				holder.txtDesc = (TextView)item_view.findViewById(R.id.txt_desc);
				holder.txtMonth = (TextView)item_view.findViewById(R.id.txt_month);
				holder.txtYear = (TextView)item_view.findViewById(R.id.txt_year);

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}


			STViewItem item_info = arrViewItems.get(position);

			holder.txtName.setText(item_info.name);
			holder.txtDesc.setText(item_info.desc);
			holder.txtMonth.setText(item_info.month);
			holder.txtYear.setText(item_info.year);

			return convertView;
		}
	};



}
