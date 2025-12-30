package com.damytech.binzang.activities.custom;

import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.preset_controls.CalendarView;
import com.damytech.structure.custom.STVocation;
import com.damytech.utils.CalendarUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 21:48
 * File Name : XiuJiaBiaoActivity
 */
public class XiuJiaBiaoActivity extends SuperActivity {
	private CalendarView calView = null;
	private ImageButton btnPrevMonth = null, btnNextMonth = null;
	private Button btnCancel = null, btnRequest = null;

	private Date curDate = new Date();

	private ArrayList<STVocation> vocation_list = new ArrayList<STVocation>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_xiujiabiao);
	}


	@Override
	protected void initializeActivity() {
		calView = (CalendarView)findViewById(R.id.calendar_view);
		CalendarView.CalendarSelectOption option = calView.getSettings();
		option.setCur_date(curDate);
		option.setBack_select_color(Color.RED);
		option.setText_select_color(Color.WHITE);
		option.setSelectable(false);

		btnPrevMonth = (ImageButton)findViewById(R.id.btn_prev_month);
		btnNextMonth = (ImageButton)findViewById(R.id.btn_next_month);

		btnCancel = (Button)findViewById(R.id.btn_cancel_vocation);
		btnRequest = (Button)findViewById(R.id.btn_req_vocation);

		btnPrevMonth.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPrevMonth();
			}
		});
		btnNextMonth.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedNextMonth();
			}
		});
		btnCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCancel();
			}
		});
		btnRequest.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedRequest();
			}
		});
	}


	@Override
	protected void onResume() {
		super.onResume();

		startProgress();
		CommManager.getVocationDates(AppCommon.loadUserIDLong(getApplicationContext()),
				vocation_dates_delegate);
	}



	private CommDelegate vocation_dates_delegate = new CommDelegate() {
		@Override
		public void getVocationDatesResult(int retcode, String retmsg, ArrayList<STVocation> arrVocations) {
			super.getVocationDatesResult(retcode, retmsg, arrVocations);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				vocation_list.clear();
				vocation_list.addAll(arrVocations);

				updateCalendarView();
			} else {
				ToastUtility.showToast(XiuJiaBiaoActivity.this, retmsg);
			}
		}
	};



	private void updateCalendarView() {
		ArrayList<Date> arrDates = new ArrayList<Date>();
		ArrayList<CalendarView.STCalendarBadge> arrBadges = new ArrayList<CalendarView.STCalendarBadge>();
		for (int i = 0; i < vocation_list.size(); i++) {
			STVocation vocation = vocation_list.get(i);
			if (vocation.state == ConstMgr.VOCATION_STATE_CANCELLED)
				continue;

			Date dtItem = CalendarUtility.string2Date(vocation.date, "yyyy-MM-dd");
			//arrDates.add(dtItem);

			CalendarView.STCalendarBadge badge = new CalendarView.STCalendarBadge();
			badge.badgeText = "1";
			badge.dateValue = dtItem;
			arrBadges.add(badge);
		}

		//calView.getSettings().setSel_dates(arrDates);
		calView.getSettings().setBadges(arrBadges);
		calView.invalidate();
	}



	private void onClickedPrevMonth() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(curDate);
		cal.add(Calendar.MONTH, -1);

		curDate = cal.getTime();

		calView.getSettings().setCur_date(curDate);
		calView.invalidate();
	}


	private void onClickedNextMonth() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(curDate);
		cal.add(Calendar.MONTH, 1);

		curDate = cal.getTime();

		calView.getSettings().setCur_date(curDate);
		calView.invalidate();
	}


	private void onClickedCancel() {
		pushNewActivityAnimated(XiuJiaLieBiaoActivity.class);
	}


	private void onClickedRequest() {
		pushNewActivityAnimated(XiuJiaShenQingActivity.class);
	}
}


