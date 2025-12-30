package com.damytech.preset_controls;

import android.content.Context;
import android.graphics.*;
import android.text.TextPaint;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import com.damytech.utils.CalendarUtility;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by KimHM on 2014/12/10.
 */
public class CalendarView extends View {
	public static final String[] eng_months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
	public static final String[] chn_months = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};

	public static final String[] eng_days = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
	public static final String[] chn_days = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};

	public static final String ENG_YEAR = "Year";
	public static final String ENG_MONTH = "Month";

	public static final String CHN_YEAR = "年";
	public static final String CHN_MONTH = "月";

	public static final int DAYS_COUNT = 7;
	public static final int DAYS_ROW_COUNT = 6;

	public static final int LANG_ENG = 1;
	public static final int LANG_CHN = 2;


	/**
	 * Internal variables for the UI rectangular area calculation
	 */
	private final int internal_padding = 20;
	private final int day_internal_padding = 3;
	private final int month_internal_padding = 5;
	private final float fCharPaddingRatio = 1.3f;

	private int title_weight = 20;
	private int days_weight = 20;
	private int calendar_weight = 120;

	private int title_height = -1;
	private int days_height = -1;
	private int calendar_height = -1;

	private int title_fontsize = 0;
	private int days_fontsize = 0;
	private int calendar_fontsize = 0;

	private ArrayList<Rect> arrDayRects = new ArrayList<Rect>();


	/**
	 * Main options
 	 */
	private CalendarListener listener = null;

	private CalendarSelectOption main_options = new CalendarSelectOption();


	public CalendarView(Context context) { super(context); }
	public CalendarView(Context context, AttributeSet attrs) { super(context, attrs); }
	public CalendarView(Context context, AttributeSet attrs, int defStyle) { super(context, attrs, defStyle); }



	@Override
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);
		drawAll(canvas);
	}


	@Override
	public boolean onTouchEvent(MotionEvent event) {
		if (!this.isEnabled()) {
			return super.onTouchEvent(event);
		}

		switch (event.getAction()) {
			case MotionEvent.ACTION_DOWN:
//				CalendarView.this.getParent().requestDisallowInterceptTouchEvent(true);
				processSelection((int)event.getX(), (int)event.getY());
				break;
			case MotionEvent.ACTION_MOVE:
				break;
			case MotionEvent.ACTION_UP:
//				CalendarView.this.getParent().requestDisallowInterceptTouchEvent(false);
				break;
			case MotionEvent.ACTION_CANCEL:
			case MotionEvent.ACTION_HOVER_EXIT:
//				CalendarView.this.getParent().requestDisallowInterceptTouchEvent(false);
				break;
			default:
				break;
		}
		return true;
	}


	private void processSelection(int x, int y) {
		Rect rcBounds = getInternalBounds();
		if (!rcBounds.contains(x, y))
			return;

		int nIndex = -1;

		Date first_day = getFirstDisplayDate();

		Calendar cur_calendar = Calendar.getInstance();
		cur_calendar.setTime(main_options.getCur_date());

		Calendar sel_calendar = Calendar.getInstance();
		sel_calendar.setTime(first_day);

		for (int i = 0; i < arrDayRects.size(); i++)
		{
			Rect rcDayItem = arrDayRects.get(i);
			if (rcDayItem.contains(x, y)) {
				nIndex = i;
				break;
			}
		}

		if (nIndex < 0)
			return;

		sel_calendar.add(Calendar.DAY_OF_MONTH, nIndex);
		if (main_options.isSelectable() && !main_options.isMulti_selectable())
			main_options.getSel_dates().clear();

		int nExistIndex = -1;
		for (int i = 0; i < main_options.getSel_dates().size(); i++) {
			Date dt_item = main_options.getSel_dates().get(i);
			Calendar cal_item = Calendar.getInstance();
			cal_item.setTime(dt_item);

			if (cal_item.get(Calendar.YEAR) == sel_calendar.get(Calendar.YEAR) &&
				cal_item.get(Calendar.MONTH) == sel_calendar.get(Calendar.MONTH) &&
				cal_item.get(Calendar.DAY_OF_MONTH) == sel_calendar.get(Calendar.DAY_OF_MONTH))
			{
				nExistIndex = i;
				break;
			}
		}

		if (nExistIndex < 0) {
			if (main_options.isSelectable()) {
				main_options.getSel_dates().add(sel_calendar.getTime());
			}

			if (listener != null)
				listener.onDateSelected(sel_calendar.getTime());
		} else {
			if (main_options.isSelectable()) {
				main_options.getSel_dates().remove(nExistIndex);
			}

			if (listener != null)
				listener.onDateDeselected(sel_calendar.getTime());
		}

		invalidate();
	}


	private Rect getInternalBounds() {
		int padding = internal_padding;
		if (padding < 0)
			padding = 0;

		return new Rect(padding, padding, getWidth() - padding, getHeight() - padding);
	}


	private void drawAll(Canvas canvas) {
		calcComponentSizes();

		Rect rcBounds = getInternalBounds();

		Calendar cal_inst = Calendar.getInstance();
		cal_inst.setTime(main_options.getCur_date());

		int nYear = cal_inst.get(Calendar.YEAR);
		int nMonth = cal_inst.get(Calendar.MONTH) + 1;

		// Draw title
		Rect rcTitle = new Rect(rcBounds.left, rcBounds.top, rcBounds.left + rcBounds.width(), rcBounds.top + title_height);
		if (title_height > 0) {
			String szTitle = getTitle(nYear, nMonth);

			TextPaint txtPaint = new TextPaint();
			txtPaint.setTextAlign(Paint.Align.CENTER);
			txtPaint.setAntiAlias(true);
			txtPaint.setColor(main_options.getTitle_color());
			txtPaint.setTextSize(title_fontsize);

			canvas.drawText(szTitle,
					rcTitle.left + rcTitle.width() / 2,
					rcTitle.top + rcTitle.height() / 2 - (txtPaint.descent() + txtPaint.ascent()) / 2,
					txtPaint);
		}


		// Draw days
		Rect rcDays = new Rect(rcBounds.left, rcTitle.top + rcTitle.height(), rcBounds.left + rcBounds.width(), rcTitle.top + rcTitle.height() + days_height);
		if (days_height > 0) {
			String[] days = null;
			if (main_options.getLang_type() == LANG_ENG) {
				days = eng_days;
			} else if (main_options.getLang_type() == LANG_CHN) {
				days = chn_days;
			}

			TextPaint txtPaint = new TextPaint();
			txtPaint.setAntiAlias(true);
			txtPaint.setTextAlign(Paint.Align.CENTER);
			txtPaint.setColor(main_options.getDays_color());
			txtPaint.setTextSize(days_fontsize);

			Point rcDaySize = new Point(rcDays.width() / DAYS_COUNT, rcDays.height());
			for (int i = 0; i < DAYS_COUNT; i++) {
				Rect rcDayItem;
				if (i == DAYS_COUNT - 1) {
					rcDayItem = new Rect(rcDays.left + rcDaySize.x * i, rcDays.top, rcDays.left + rcDays.width(), rcDays.top + rcDaySize.y);
				} else {
					rcDayItem = new Rect(rcDays.left + rcDaySize.x * i, rcDays.top, rcDays.left + rcDaySize.x * i + rcDaySize.x, rcDays.top + rcDaySize.y);
				}

				String szDay = days[i];
				canvas.drawText(szDay,
						rcDayItem.left + rcDayItem.width() / 2,
						rcDayItem.top + rcDayItem.height() / 2 - (txtPaint.descent() + txtPaint.ascent()) / 2,
						txtPaint);
			}
		}


		// Draw calendar
		Rect rcCalendar = new Rect(rcBounds.left,
				rcDays.top + rcDays.height(),
				rcBounds.left + rcBounds.width(),
				rcDays.top + rcDays.height() + calendar_height);

		arrDayRects.clear();

		TextPaint txtPaint = new TextPaint();
		txtPaint.setTextSize(calendar_fontsize);
		txtPaint.setTextAlign(Paint.Align.CENTER);
		txtPaint.setAntiAlias(true);

		Date firstDay = getFirstDisplayDate();

		Calendar cal_cur = Calendar.getInstance();
		cal_cur.setTime(main_options.getCur_date());

		Calendar cal_display = Calendar.getInstance();
		cal_display.setTime(firstDay);

		for (int i = 0; i < DAYS_ROW_COUNT * DAYS_COUNT; i++) {
			Rect rcDayItem = getDayItemRect(rcCalendar, i);
			arrDayRects.add(rcDayItem);

			boolean isSelected = false;

			if (main_options.isSelectable()) {
				for (int j = 0; j < main_options.getSel_dates().size(); j++) {
					Date sel_date_item = main_options.getSel_dates().get(j);

					Calendar cal_seldate = Calendar.getInstance();
					cal_seldate.setTime(sel_date_item);

					if (cal_seldate.get(Calendar.YEAR) == cal_display.get(Calendar.YEAR) &&
							cal_seldate.get(Calendar.MONTH) == cal_display.get(Calendar.MONTH) &&
							cal_seldate.get(Calendar.DAY_OF_MONTH) == cal_display.get(Calendar.DAY_OF_MONTH)) {
						isSelected = true;
						break;
					}
				}
			}

			if (isSelected) {
				txtPaint.setColor(main_options.getText_select_color());
			} else {
				if (cal_display.get(Calendar.MONTH) != cal_cur.get(Calendar.MONTH)) {
					txtPaint.setColor(main_options.getText_disable_color());
				} else {
					txtPaint.setColor(main_options.getText_normal_color());
				}
			}


			// Draw selected
			if (isSelected) {
				RectF rcDayInternalBounds = new RectF(rcDayItem.left + day_internal_padding,
						rcDayItem.top + day_internal_padding,
						rcDayItem.left + rcDayItem.width() - day_internal_padding,
						rcDayItem.top + rcDayItem.height() - day_internal_padding);

				int nSize = (int)Math.min(rcDayInternalBounds.width(), rcDayInternalBounds.height());
				rcDayInternalBounds = new RectF(rcDayInternalBounds.left + rcDayInternalBounds.width() / 2 - nSize / 2,
						rcDayInternalBounds.top + rcDayInternalBounds.height() / 2 - nSize / 2,
						rcDayInternalBounds.left + rcDayInternalBounds.width() / 2 + nSize / 2,
						rcDayInternalBounds.top + rcDayInternalBounds.height() / 2 + nSize / 2);

				Paint selPaint = new Paint();
				selPaint.setAntiAlias(true);
				selPaint.setColor(main_options.getBack_select_color());
				selPaint.setStyle(Paint.Style.FILL);

				canvas.drawOval(rcDayInternalBounds, selPaint);
			}

			String szDay = "" + cal_display.get(Calendar.DAY_OF_MONTH);

			canvas.drawText(szDay,
					rcDayItem.left + rcDayItem.width() / 2,
					rcDayItem.top + rcDayItem.height() / 2 - (txtPaint.descent() + txtPaint.ascent()) / 2,
					txtPaint);


			// Draw badge
			STCalendarBadge badge = null;
			for (int j = 0; j < main_options.badges.size(); j++) {
				STCalendarBadge badge_item = main_options.badges.get(j);
				if (badge_item.badgeText.equals("") || badge_item.dateValue == null)
					continue;

				Calendar cal = Calendar.getInstance();
				cal.setTime(badge_item.dateValue);

				if (CalendarUtility.isSameDates(cal, cal_display)) {
					badge = badge_item;
					break;
				}
			}

			if (badge != null) {
				Paint badgeBKPaint = new Paint();
				badgeBKPaint.setStyle(Paint.Style.FILL);
				badgeBKPaint.setColor(Color.RED);
				badgeBKPaint.setAntiAlias(true);

				TextPaint badgePaint = new TextPaint();
				badgePaint.setTextSize(calendar_fontsize / 1.5f);
				badgePaint.setTextAlign(Paint.Align.CENTER);
				badgePaint.setAntiAlias(true);
				badgePaint.setColor(Color.WHITE);

				Rect badge_size = new Rect();
				badgePaint.getTextBounds(badge.badgeText, 0, badge.badgeText.length(), badge_size);

				int nSize = badge_size.height() * 2;

				RectF rcBadge = new RectF(rcDayItem.right - nSize,
						rcDayItem.top,
						rcDayItem.right,
						rcDayItem.top + nSize);

				canvas.drawOval(rcBadge, badgeBKPaint);
				canvas.drawText(badge.badgeText,
						rcBadge.left + rcBadge.width() / 2,
						rcBadge.top + rcBadge.height() / 2 - (badgePaint.descent() + badgePaint.ascent()) / 2,
						badgePaint);
			}


			// Increase display date value
			cal_display.add(Calendar.DAY_OF_MONTH, 1);
		}
	}


	/**
	 * Method to get the area of the day
	 *
	 * @param rcTotal	The total area of the calendar
	 * @param nRow		The index of the row. The first row is considered as 0
	 * @param nCol		The index of the column. The first column is considered as 0
	 * @return			The rectangle of the day item
	 */
	private Rect getDayItemRect(Rect rcTotal, int nRow, int nCol) {
		Point dayitem_size = new Point(rcTotal.width() / DAYS_COUNT, rcTotal.height() / DAYS_ROW_COUNT);
		Rect rcItem = new Rect(rcTotal.left + nCol * dayitem_size.x,
				rcTotal.top + nRow * dayitem_size.y,
				rcTotal.left + (nCol + 1) * dayitem_size.x,
				rcTotal.top + (nRow + 1) * dayitem_size.y);

		return rcItem;
	}


	/**
	 * A month displays 42 days, including some days in prev and next month
	 * Each days has index from 0 to 41
	 *
	 * @param rcTotal	The total area of the calendar
	 * @param nIndex	index of the day
	 * @return			The rect of the day
	 */
	private Rect getDayItemRect(Rect rcTotal, int nIndex) {
		int nRow = nIndex / DAYS_COUNT;
		int nCol = nIndex - nRow * DAYS_COUNT;

		return getDayItemRect(rcTotal, nRow, nCol);
	}



	private Date getFirstDisplayDate() {
		Calendar cur_cal = Calendar.getInstance();
		cur_cal.setTime(main_options.getCur_date());
		cur_cal.set(Calendar.DAY_OF_MONTH, 1);

		int day_of_week = cur_cal.get(Calendar.DAY_OF_WEEK);
		int nPreMonth_DaysCount = day_of_week - 1;
		cur_cal.add(Calendar.DAY_OF_MONTH, -nPreMonth_DaysCount);

		return cur_cal.getTime();
	}


	private String getTitle(int year, int month) {
		String title = "";


		if (main_options.getLang_type() == LANG_ENG) {
			title = eng_months[month - 1] + "," + year;
		} else if (main_options.getLang_type() == LANG_CHN) {
			title = "" + year + CHN_YEAR + month + CHN_MONTH;
		}

		return title;
	}


	private void calcComponentSizes() {
		int nViewHeight = getInternalBounds().height();

		float total_weight = 0;

		if (!main_options.isHasTitle())
			title_weight = 0;

		if (!main_options.isHasDays())
			days_height = 0;


		total_weight = title_weight + days_weight + calendar_weight;

		title_height = (int)(nViewHeight * title_weight / total_weight);
		days_height = (int)(nViewHeight * days_weight / total_weight);
		calendar_height = (int)(nViewHeight * calendar_weight / total_weight);

		int padding = internal_padding;
		if (padding < 0)
			padding = 0;

		int nRealWidth = getWidth() - padding * 2;
		title_fontsize = title_height * 2 / 3;
		{
			int nCharCount = 0;

			if (main_options.getLang_type() == LANG_ENG) {
				nCharCount = 4;
			} else if (main_options.getLang_type() == LANG_CHN) {
				nCharCount = 8;
			}

			if (nCharCount != 0) {
				float fCandidateSize = nRealWidth / (nCharCount * fCharPaddingRatio);
				if (title_fontsize > fCandidateSize)
					title_fontsize = (int)fCandidateSize;
			}
		}

		days_fontsize = days_height * 2 / 3;
		{
			int nCharCount = 0;

			if (main_options.getLang_type() == LANG_ENG) {
				nCharCount = 3;
			} else if (main_options.getLang_type() == LANG_CHN) {
				nCharCount = 2;
			}

			if (nCharCount != 0) {
				float fCandidateSize = nRealWidth / (DAYS_COUNT * nCharCount * fCharPaddingRatio);
				if (days_fontsize > fCandidateSize)
					days_fontsize = (int)fCandidateSize;
			}
		}


		calendar_fontsize = calendar_height / (DAYS_ROW_COUNT * 2);
		{
			int nCharCount = 2;
			float fCandidateSize = nRealWidth / (DAYS_COUNT * nCharCount * fCharPaddingRatio);
			if (calendar_fontsize > fCandidateSize)
				calendar_fontsize = (int)fCandidateSize;
		}
	}


	private int getMaximumDayOfMonth(Calendar cal) {
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}


	public CalendarSelectOption getSettings() {
		if (main_options == null) {
			main_options = new CalendarSelectOption();
		}

		return main_options;
	}


	public void setCalendarListener(CalendarListener listener) {
		this.listener = listener;
	}

	public CalendarListener getCalendarListener() {
		return this.listener;
	}


	public void setSettings(CalendarSelectOption option) {
		main_options = option;
		invalidate();
	}


	public static class CalendarSelectOption {
		protected static int lang_type = LANG_CHN;

		protected boolean hasTitle = true;
		protected boolean hasDays = true;
		protected boolean multi_selectable = true;
		protected boolean selectable = true;

		protected int title_color = Color.rgb(40, 40, 40);
		protected int days_color = Color.rgb(40, 40, 40);

		protected int text_normal_color = Color.rgb(40, 40, 40);
		protected int text_disable_color = Color.LTGRAY;
		protected int text_select_color = Color.WHITE;

		protected int back_select_color = Color.rgb(0, 145, 202);
		protected int back_normal_color = Color.rgb(75, 196, 233);			// Used only in the month select mode

		protected Date cur_date = new Date();
		protected ArrayList<Date> sel_dates = new ArrayList<Date>();

		protected ArrayList<STCalendarBadge> badges = new ArrayList<STCalendarBadge>();

		public int getLang_type() {
			return lang_type;
		}

		public CalendarSelectOption setLang_type(int lang_type) {
			CalendarSelectOption.lang_type = lang_type;
			return this;
		}

		public boolean isHasTitle() {
			return hasTitle;
		}

		public CalendarSelectOption setHasTitle(boolean hasTitle) {
			this.hasTitle = hasTitle;
			return this;
		}

		public boolean isHasDays() {
			return hasDays;
		}

		public CalendarSelectOption setHasDays(boolean hasDays) {
			this.hasDays = hasDays;
			return this;
		}

		public boolean isMulti_selectable() {
			return multi_selectable;
		}

		public CalendarSelectOption setMulti_selectable(boolean multi_selectable) {
			this.multi_selectable = multi_selectable;
			return this;
		}

		public boolean isSelectable() {
			return selectable;
		}

		public CalendarSelectOption setSelectable(boolean selectable) {
			this.selectable = selectable;
			return this;
		}

		public int getTitle_color() {
			return title_color;
		}

		public CalendarSelectOption setTitle_color(int title_color) {
			this.title_color = title_color;
			return this;
		}

		public int getDays_color() {
			return days_color;
		}

		public CalendarSelectOption setDays_color(int days_color) {
			this.days_color = days_color;
			return this;
		}

		public int getText_normal_color() {
			return text_normal_color;
		}

		public CalendarSelectOption setText_normal_color(int text_normal_color) {
			this.text_normal_color = text_normal_color;
			return this;
		}

		public int getText_disable_color() {
			return text_disable_color;
		}

		public CalendarSelectOption setText_disable_color(int text_disable_color) {
			this.text_disable_color = text_disable_color;
			return this;
		}

		public int getText_select_color() {
			return text_select_color;
		}

		public CalendarSelectOption setText_select_color(int text_select_color) {
			this.text_select_color = text_select_color;
			return this;
		}

		public int getBack_select_color() {
			return back_select_color;
		}

		public CalendarSelectOption setBack_select_color(int back_select_color) {
			this.back_select_color = back_select_color;
			return this;
		}

		public int getBack_normal_color() {
			return back_normal_color;
		}

		public CalendarSelectOption setBack_normal_color(int back_normal_color) {
			this.back_normal_color = back_normal_color;
			return this;
		}

		public Date getCur_date() {
			return cur_date;
		}

		public CalendarSelectOption setCur_date(Date cur_date) {
			this.cur_date = cur_date;
			return this;
		}

		public ArrayList<Date> getSel_dates() {
			return sel_dates;
		}

		public CalendarSelectOption setSel_dates(ArrayList<Date> sel_dates) {
			this.sel_dates = sel_dates;
			return this;
		}


		public ArrayList<STCalendarBadge> getBadges() {
			return badges;
		}

		public CalendarSelectOption setBadges(ArrayList<STCalendarBadge> badges) {
			this.badges = badges;
			return this;
		}
	}


	public static class STCalendarBadge {
		public Date dateValue = new Date();
		public String badgeText = "";

		public STCalendarBadge() {}

		public STCalendarBadge(Date dtVal, String badgeTxt) {
			this.dateValue = dtVal;
			badgeText = badgeTxt;
		}
	}


	public interface CalendarListener {
		public void onDateSelected(Date dt);
		public void onDateDeselected(Date dt);
	}


}
