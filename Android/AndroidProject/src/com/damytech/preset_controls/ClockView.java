package com.damytech.preset_controls;

import android.app.Activity;
import android.content.Context;
import android.graphics.*;
import android.util.AttributeSet;
import android.view.View;

import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by KimHM on 2015/1/14.
 */
public class ClockView extends View {
	private int hour = 3;
	private int minute = 20;

	private final int hour_pin_color = Color.rgb(0xF9, 0xC2, 0x31);
	private final int minute_pin_color = Color.rgb(0x36, 0xBA, 0x55);
	private final int frame_color = Color.rgb(0x00, 0x91, 0xCA);
	private final int content_color = Color.rgb(0xFF, 0xFF, 0xFF);
	private final int scale_color = Color.rgb(0x00, 0x00, 0x00);
	private final int core_color = Color.rgb(0x00, 0x00, 0x00);

	private final int hour_pin_length_rate = 35;
	private final int minute_pin_length_rate = 50;
	private final int frame_weight_rate = 20;

	private final int main_scale_length_rate = 4;

	private final int margin_rate = 10;

	private final int text_size_rate = 15;

	private Context parentContext = null;

	public ClockView(Context context) {
		super(context);
		parentContext = context;
	}

	public ClockView(Context context, AttributeSet attrs) {
		super(context, attrs);
		parentContext = context;
	}

	public ClockView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		parentContext = context;
	}

	private Timer auto_timer = null;
	private TimerTask auto_timer_task = null;

	public void startAuto() {
		stopAuto();

		auto_timer_task = new TimerTask() {
			@Override
			public void run() {
				Calendar cal_current = Calendar.getInstance();

				hour = cal_current.get(Calendar.HOUR_OF_DAY);
				minute = cal_current.get(Calendar.MINUTE);

				Activity activity = (Activity)parentContext;
				activity.runOnUiThread(new Runnable() {
					@Override
					public void run() {
						invalidate();
					}
				});
			}
		};

		auto_timer = new Timer();
		auto_timer.schedule(auto_timer_task, 0, 1000);
	}


	public void stopAuto() {
		if (auto_timer_task != null) {
			auto_timer_task.cancel();
			auto_timer_task = null;
		}

		if (auto_timer != null) {
			auto_timer.cancel();
			auto_timer = null;
		}
	}


	@Override
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);

		int nHour = hour % 12;
		int nMinute = minute % 60;

		int nWidth = getWidth();
		int nHeight = getHeight();

		int nMinSize = Math.min(nWidth, nHeight);
		int nActualSize = nMinSize * (100 - margin_rate) / 100;

		RectF rcFrame = new RectF((nWidth - nActualSize) / 2.f,
				(nHeight - nActualSize) / 2.f,
				(nWidth + nActualSize) / 2.f,
				(nHeight + nActualSize) / 2.f);


		// Draw main frame
		Paint framePaint = new Paint();
		framePaint.setAntiAlias(true);
		framePaint.setColor(frame_color);
		framePaint.setStyle(Paint.Style.FILL);
		canvas.drawOval(rcFrame, framePaint);


		// Draw content
		int nContentSize = nMinSize * (100 - margin_rate - frame_weight_rate) / 100;
		RectF rcContent = new RectF((nWidth - nContentSize) / 2.f,
				(nHeight - nContentSize) / 2.f,
				(nWidth + nContentSize) / 2.f,
				(nHeight + nContentSize) / 2.f);

		Paint contentPaint = new Paint();
		contentPaint.setAntiAlias(true);
		contentPaint.setColor(content_color);
		contentPaint.setStyle(Paint.Style.FILL);
		canvas.drawOval(rcContent, contentPaint);


		// Draw scales
		int nMainScaleLen = main_scale_length_rate * nActualSize / 100;
		int nMainScaleMargin = nMainScaleLen / 2;

		Paint scalePaint = new Paint();
		scalePaint.setAntiAlias(true);
		scalePaint.setColor(scale_color);
		scalePaint.setStyle(Paint.Style.FILL);

		for (int i = 0; i < 12; i++) {
			RectF rcScale = new RectF(0, 0, 0, 0);
			PointF ptScale = new PointF(0, 0);

			if (i == 0) {
				ptScale = new PointF(nWidth / 2.f, rcContent.top + nMainScaleMargin);
				rcScale = new RectF(ptScale.x - 1, ptScale.y, ptScale.x + 1, ptScale.y + nMainScaleLen);
			} else if (i == 3) {
				ptScale = new PointF(rcContent.right - nMainScaleMargin, nHeight / 2.f);
				rcScale = new RectF(ptScale.x - nMainScaleLen, ptScale.y - 1, ptScale.x, ptScale.y + 1);
			} else if (i == 6) {
				ptScale = new PointF(nWidth / 2.f, rcContent.bottom - nMainScaleMargin);
				rcScale = new RectF(ptScale.x - 1, ptScale.y - nMainScaleLen, ptScale.x + 1, ptScale.y);
			} else if (i == 9) {
				ptScale = new PointF(rcContent.left + nMainScaleMargin, nHeight / 2.f);
				rcScale = new RectF(ptScale.x, ptScale.y - 1, ptScale.x + nMainScaleLen, ptScale.y + 1);
			} else {
				float angle = i * 30;
				float fRadius = Math.min(rcContent.width() / 2.f - 2,
						rcContent.width() / 2.f - nMainScaleMargin - nMainScaleLen + 3);

				if (i < 3) {
					ptScale = new PointF(nWidth / 2.f + (float) Math.sin(angle * Math.PI / 180) * fRadius, nHeight / 2.f - (float) Math.cos(angle * Math.PI / 180) * fRadius);
				} else if (i < 6) {
					ptScale = new PointF(nWidth / 2.f + (float) Math.sin(Math.PI - angle * Math.PI / 180) * fRadius, nHeight / 2.f + (float) Math.cos(Math.PI - angle * Math.PI / 180) * fRadius);
				} else if (i < 9) {
					ptScale = new PointF(nWidth / 2.f - (float) Math.sin(angle * Math.PI / 180 - Math.PI) * fRadius, nHeight / 2.f + (float) Math.cos(angle * Math.PI / 180 - Math.PI) * fRadius);
				} else {			// i < 12
					ptScale = new PointF(nWidth / 2.f - (float) Math.sin(Math.PI * 2 - angle * Math.PI / 180) * fRadius, nHeight / 2.f - (float) Math.cos(Math.PI * 2 - angle * Math.PI / 180) * fRadius);
				}

				rcScale = new RectF(ptScale.x - 1, ptScale.y - 1, ptScale.x + 1, ptScale.y + 1);
			}

			canvas.drawRoundRect(rcScale, 1, 1, scalePaint);
		}


		// Draw hour pin
		{
			PointF ptScale = new PointF(0, 0);

			float angle = (nHour + nMinute / 60.f) * 30;
			float fRadius = nActualSize / 2 * hour_pin_length_rate / 100;

			float fHourPinMargin = nActualSize / 2 - fRadius;

			if (nMinute == 0 && nHour == 0) {
				ptScale = new PointF(nWidth / 2.f, rcFrame.top + fHourPinMargin);
			} else if (nMinute == 0 && nHour == 3) {
				ptScale = new PointF(rcFrame.right - fHourPinMargin, nHeight / 2.f);
			} else if (nMinute == 0 && nHour == 6) {
				ptScale = new PointF(nWidth / 2.f, rcFrame.bottom - fHourPinMargin);
			} else if (nMinute == 0 && nHour == 9) {
				ptScale = new PointF(rcFrame.left + fHourPinMargin, nHeight / 2.f);
			} else {
				if (nHour < 3) {
					ptScale = new PointF(nWidth / 2.f + (float) Math.sin(angle * Math.PI / 180) * fRadius, nHeight / 2.f - (float) Math.cos(angle * Math.PI / 180) * fRadius);
				} else if (nHour < 6) {
					ptScale = new PointF(nWidth / 2.f + (float) Math.sin(Math.PI - angle * Math.PI / 180) * fRadius, nHeight / 2.f + (float) Math.cos(Math.PI - angle * Math.PI / 180) * fRadius);
				} else if (nHour < 9) {
					ptScale = new PointF(nWidth / 2.f - (float) Math.sin(angle * Math.PI / 180 - Math.PI) * fRadius, nHeight / 2.f + (float) Math.cos(angle * Math.PI / 180 - Math.PI) * fRadius);
				} else {		// i < 12
					ptScale = new PointF(nWidth / 2.f - (float) Math.sin(Math.PI * 2 - angle * Math.PI / 180) * fRadius, nHeight / 2.f - (float) Math.cos(Math.PI * 2 - angle * Math.PI / 180) * fRadius);
				}
			}

			Paint ptHourPin = new Paint();
			ptHourPin.setAntiAlias(true);
			ptHourPin.setColor(hour_pin_color);
			ptHourPin.setStrokeWidth(4);
			ptHourPin.setStrokeCap(Paint.Cap.ROUND);
			ptHourPin.setStyle(Paint.Style.STROKE);
			canvas.drawLine(nWidth / 2.f, nHeight / 2.f, ptScale.x, ptScale.y, ptHourPin);
		}


		// Draw minute pin
		{
			PointF ptScale = new PointF(0, 0);

			float angle = nMinute * 6;
			float fRadius = nActualSize / 2 * minute_pin_length_rate / 100;

			float fMinutePinMargin = nActualSize / 2 - fRadius;

			if (nMinute == 0) {
				ptScale = new PointF(nWidth / 2.f, rcFrame.top + fMinutePinMargin);
			} else if (nMinute == 15) {
				ptScale = new PointF(rcFrame.right - fMinutePinMargin, nHeight / 2.f);
			} else if (nMinute == 30) {
				ptScale = new PointF(nWidth / 2.f, rcFrame.bottom - fMinutePinMargin);
			} else if (nMinute == 45) {
				ptScale = new PointF(rcFrame.left + fMinutePinMargin, nHeight / 2.f);
			} else {
				if (nMinute < 15) {
					ptScale = new PointF(nWidth / 2.f + (float) Math.sin(angle * Math.PI / 180) * fRadius, nHeight / 2.f - (float) Math.cos(angle * Math.PI / 180) * fRadius);
				} else if (nMinute < 30) {
					ptScale = new PointF(nWidth / 2.f + (float) Math.sin(Math.PI - angle * Math.PI / 180) * fRadius, nHeight / 2.f + (float) Math.cos(Math.PI - angle * Math.PI / 180) * fRadius);
				} else if (nMinute < 45) {
					ptScale = new PointF(nWidth / 2.f - (float) Math.sin(angle * Math.PI / 180 - Math.PI) * fRadius, nHeight / 2.f + (float) Math.cos(angle * Math.PI / 180 - Math.PI) * fRadius);
				} else {		// nMinute < 45
					ptScale = new PointF(nWidth / 2.f - (float) Math.sin(Math.PI * 2 - angle * Math.PI / 180) * fRadius, nHeight / 2.f - (float) Math.cos(Math.PI * 2 - angle * Math.PI / 180) * fRadius);
				}
			}

			Paint ptMinutePin = new Paint();
			ptMinutePin.setAntiAlias(true);
			ptMinutePin.setColor(minute_pin_color);
			ptMinutePin.setStrokeWidth(2);
			ptMinutePin.setStrokeCap(Paint.Cap.ROUND);
			ptMinutePin.setStyle(Paint.Style.STROKE);
			canvas.drawLine(nWidth / 2.f, nHeight / 2.f, ptScale.x, ptScale.y, ptMinutePin);
		}


		// Draw core point
		{
			Paint paintCore = new Paint();
			paintCore.setColor(core_color);
			paintCore.setStyle(Paint.Style.FILL);
			paintCore.setAntiAlias(true);

			RectF rcCore = new RectF(nWidth / 2.f - 3, nHeight / 2.f - 3, nWidth / 2.f + 3, nHeight / 2.f + 3);
			canvas.drawOval(rcCore, paintCore);
		}
	}


	public void setTime(int nHour, int nMinute) {
		hour = nHour;
		minute = nMinute;

		invalidate();
	}


	public int getHour() {
		return hour;
	}

	public int getMinute() {
		return minute;
	}
}
