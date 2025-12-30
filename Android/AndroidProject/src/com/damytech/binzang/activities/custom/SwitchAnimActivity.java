package com.damytech.binzang.activities.custom;

import android.graphics.PointF;
import android.graphics.RectF;
import android.support.v4.view.VelocityTrackerCompat;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.animation.*;
import android.widget.ImageView;
import android.widget.LinearLayout;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.preset_controls.HorizontalPager;
import com.damytech.utils.UIUtility;

import java.util.*;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 17:25
 * File Name : SwitchAnimActivity
 */
abstract public class SwitchAnimActivity extends SuperActivity {
	public final int ADVERT_TIMER_INTERVAL = 3000;

	// In some cases, when dragging is finished, onClick event can be occurred.
	// To prevent this, onClick event which is occurred in 'TOUCH_UP_INTERVAL' milliseconds after touch up event is ignored.
	public final int TOUCH_UP_INTERVAL = 500;

	public long touch_up_time = 0;

	public View first_view = null;
	public View second_view = null;

	public HorizontalPager first_advert_pager = null, second_advert_pager = null;
	public Timer first_advert_timer = null, second_advert_timer = null;
	public TimerTask first_advert_timer_task = null, second_advert_timer_task = null;

	public ArrayList<View> arrFirstDraggableViews = new ArrayList<View>();
	public ArrayList<View> arrSecondDraggableViews = new ArrayList<View>();

	public ArrayList<ImageView> arrFirstIndicatorViews = new ArrayList<ImageView>();
	public ArrayList<ImageView> arrSecondIndicatorViews = new ArrayList<ImageView>();
	public LinearLayout first_indicator_layout = null, second_indicator_layout = null;
	public int first_indicator_index = 0, second_indicator_index = 0;

	public final int ZORDER_FIRSTVIEW_TOP = 1;
	public final int ZORDER_SECONDVIEW_TOP = 2;
	public int zOrder = ZORDER_FIRSTVIEW_TOP;

	public boolean isAnimating = false;
	public AnimationSet topAnimSet = null;
	public AnimationSet bottomAnimSet = null;

	public final int TOTAL_ANIM_DURATION = 500;
	public final int VELOCITY_INTERVAL = 10;
	public final int SPEED_MIN_LIMIT = 10;
	public final int NEGATIVE_SPEED_MIN_LIMIT = 3;
	public final int MOVE_DIST_LIMIT = 5;

	public float downX, prevX, curX;
	public boolean isDown = false, isMoved = false;

	public final float MINIMUM_BOTTOM_VIEW_ZOOM = 10;
	public final float MINIMUM_TOP_VIEW_ZOOM = 30;
	public final float MINIMUM_ALPHA = 0.6f;


	public VelocityTracker velocityTracker = null;
	public int action_index = 0;
	public int pointer_id = 0;
	public float x_velocity = 0;


	@Override
	protected void onResume() {
		super.onResume();

		if (zOrder == ZORDER_FIRSTVIEW_TOP && arrFirstIndicatorViews.size() > 0)
			startFirstAdvertTimer();
		else if (arrSecondIndicatorViews.size() > 0)
			startSecondAdvertTimer();
	}


	@Override
	protected void onPause() {
		super.onResume();

		stopFirstAdvertTimer();
		stopSecondAdvertTimer();
	}

	@Override
	public boolean dispatchTouchEvent(MotionEvent event) {
		if (isAnimating)
			return true;

		curX = event.getX();

		switch (event.getAction()) {
			case MotionEvent.ACTION_DOWN:
				// if touch down is in draggable area, must return super operation
				if (zOrder == ZORDER_FIRSTVIEW_TOP) {
					for (int i = 0; i < arrFirstDraggableViews.size(); i++) {
						RectF rect = UIUtility.getFrameFForRootView(arrFirstDraggableViews.get(i));
						if (rect.contains(event.getX(), event.getY())) {
							return super.dispatchTouchEvent(event);
						}
					}
				} else {
					for (int i = 0; i < arrSecondDraggableViews.size(); i++) {
						RectF rect = UIUtility.getFrameFForRootView(arrSecondDraggableViews.get(i));
						if (rect.contains(event.getX(), event.getY())) {
							return super.dispatchTouchEvent(event);
						}
					}
				}

				onTouchDown(event);
				break;
			case MotionEvent.ACTION_UP: {
				onTouchUp(event);
				break;
			}
			case MotionEvent.ACTION_CANCEL: {
				onTouchCancel(event);
				break;
			}
			case MotionEvent.ACTION_MOVE:
				if (isDown) {
					velocityTracker.addMovement(event);
					velocityTracker.computeCurrentVelocity(VELOCITY_INTERVAL);

					x_velocity = VelocityTrackerCompat.getXVelocity(velocityTracker, pointer_id);

					if (!isMoved) {
						if (x_velocity > SPEED_MIN_LIMIT || curX - downX > MOVE_DIST_LIMIT) {
							// Move progress
							onTouchMove(event);
							prevX = event.getX();
						}
					} else {
						// Move progress
						onTouchMove(event);
						prevX = event.getX();
					}

					prevX = event.getX();
				}
				break;
		}

		return super.dispatchTouchEvent(event);
	}


	public void onTouchDown(MotionEvent ev) {
		isDown = true;
		isMoved = false;

		downX = ev.getX();
		prevX = ev.getX();


		action_index = ev.getActionIndex();
		pointer_id = ev.getPointerId(action_index);

		if (velocityTracker == null) {
			velocityTracker = VelocityTracker.obtain();
		} else {
			velocityTracker.clear();
		}

		velocityTracker.addMovement(ev);
	}


	public void onTouchUp(MotionEvent ev) {
		if (!isDown)
			return;

		isDown = false;
		velocityTracker.recycle();

		if (isMoved) {
			touch_up_time = Calendar.getInstance().getTimeInMillis();

			float fScale = getTimePoint(curX);
			if ((fScale < 0.5 && x_velocity < SPEED_MIN_LIMIT) ||
					x_velocity < 0 && Math.abs(x_velocity) >= NEGATIVE_SPEED_MIN_LIMIT) {
				// Restore original state
				transViewsRestore(getTimePoint(curX));
			} else {
				// Switch views
				transViewsProcess(getTimePoint(curX));
			}
		}
	}



	public void transViewsProcess(float curPoint) {
		if (isAnimating)
			return;

		int nDuration = (int)(TOTAL_ANIM_DURATION * (1 - curPoint));

		AnimationSet.AnimationListener anim_listener = new AnimationSet.AnimationListener() {
			@Override
			public void onAnimationStart(Animation animation) {
				isAnimating = true;
			}
			@Override
			public void onAnimationEnd(Animation animation) {
				if (!isAnimating)
					return;

				isAnimating = false;


				first_view.setAlpha(1);
				second_view.setAlpha(1);


				if (topAnimSet != null) {
					topAnimSet.cancel();
					topAnimSet = null;
				}

				if (bottomAnimSet != null) {
					bottomAnimSet.cancel();
					bottomAnimSet = null;
				}


				if (zOrder == ZORDER_FIRSTVIEW_TOP) {
					second_view.bringToFront();
					zOrder = ZORDER_SECONDVIEW_TOP;
					startSecondAdvertTimer();
					stopFirstAdvertTimer();
				} else {
					first_view.bringToFront();
					zOrder = ZORDER_FIRSTVIEW_TOP;
					startFirstAdvertTimer();
					stopSecondAdvertTimer();
				}
			}
			@Override
			public void onAnimationRepeat(Animation animation) {
			}
		};

		transViews(curPoint, 1, nDuration, null, anim_listener);
	}



	public void transViewsRestore(float curPoint) {
		if (isAnimating)
			return;

		int nDuration = (int)(TOTAL_ANIM_DURATION * curPoint);

		AnimationSet.AnimationListener anim_listener = new AnimationSet.AnimationListener() {
			@Override
			public void onAnimationStart(Animation animation) {
				isAnimating = true;
			}
			@Override
			public void onAnimationEnd(Animation animation) {
				if (!isAnimating)
					return;

				isAnimating = false;


				first_view.setAlpha(1);
				second_view.setAlpha(1);


				if (topAnimSet != null) {
					topAnimSet.cancel();
					topAnimSet = null;
				}

				if (bottomAnimSet != null) {
					bottomAnimSet.cancel();
					bottomAnimSet = null;
				}


				if (zOrder == ZORDER_FIRSTVIEW_TOP) {
					first_view.bringToFront();
					startFirstAdvertTimer();
					stopSecondAdvertTimer();
				} else {
					second_view.bringToFront();
					startSecondAdvertTimer();
					stopFirstAdvertTimer();
				}
			}
			@Override
			public void onAnimationRepeat(Animation animation) {
			}
		};

		transViews(curPoint, 0, nDuration, anim_listener, null);
	}



	public void transViews(float fromScale,
							float toScale,
							int nDuration,
							AnimationSet.AnimationListener top_listener,
							AnimationSet.AnimationListener bottom_listener) {
		// Animation parameters
		PointF fromTopViewPos = getTopViewPosition(fromScale);			// Current position of top view
		PointF toTopViewPos = getTopViewPosition(toScale);				// Destination position of top view

		PointF fromBottomViewPos = getBottomViewPosition(fromScale);		// Current position of bottom view
		PointF toBottomViewPos = getBottomViewPosition(toScale);		// Destination position of bottom view

		float fromTopViewZoom = getTopViewScale(fromScale);				// Current zoom level of top view
		float toTopViewZoom = getTopViewScale(toScale);					// Destination zoom level of top view
		float fromBottomViewZoom = getBottomViewScale(fromScale);		// Current zoom level of bottom view
		float toBottomViewZoom = getBottomViewScale(toScale);			// Destination zoom level of bottom view

		float fromTopViewAlpha = getTopViewAlpha(fromScale);			// Current alpha of top view
		float toTopViewAlpha = getTopViewAlpha(toScale);				// Destination alpha of top view
		float fromBottomViewAlpha = getBottomViewAlpha(fromScale);		// Current alpha of bottom view
		float toBottomViewAlpha = getBottomViewAlpha(toScale);			// Destination alpha of bottom view


		// Top view
		TranslateAnimation transTopAnim = new TranslateAnimation(fromTopViewPos.x, toTopViewPos.x, fromTopViewPos.y, toTopViewPos.y);
		transTopAnim.setInterpolator(new LinearInterpolator());
		transTopAnim.setFillAfter(true);

		ScaleAnimation scaleTopAnim = new ScaleAnimation(fromTopViewZoom, toTopViewZoom, fromTopViewZoom, toTopViewZoom);
		transTopAnim.setInterpolator(new LinearInterpolator());
		scaleTopAnim.setFillAfter(true);

		AlphaAnimation fadeTopAnim = new AlphaAnimation(fromTopViewAlpha, toTopViewAlpha);
		fadeTopAnim.setInterpolator(new LinearInterpolator());
		fadeTopAnim.setFillAfter(true);

		topAnimSet = new AnimationSet(false);
		topAnimSet.addAnimation(scaleTopAnim);
		topAnimSet.addAnimation(transTopAnim);
		topAnimSet.addAnimation(fadeTopAnim);
		topAnimSet.setDuration(nDuration);

		if (top_listener != null)
			topAnimSet.setAnimationListener(top_listener);


		// Bottom view
		TranslateAnimation transBottomAnim = new TranslateAnimation(fromBottomViewPos.x, toBottomViewPos.x, fromBottomViewPos.y, toBottomViewPos.y);
		transTopAnim.setInterpolator(new LinearInterpolator());
		transBottomAnim.setFillAfter(true);

		ScaleAnimation scaleBottomAnim = new ScaleAnimation(fromBottomViewZoom, toBottomViewZoom, fromBottomViewZoom, toBottomViewZoom);
		scaleBottomAnim.setInterpolator(new LinearInterpolator());
		scaleBottomAnim.setFillAfter(true);

		AlphaAnimation fadeBottomAnim = new AlphaAnimation(fromBottomViewAlpha, toBottomViewAlpha);
		fadeBottomAnim.setInterpolator(new LinearInterpolator());
		fadeBottomAnim.setFillAfter(true);

		bottomAnimSet = new AnimationSet(false);
		bottomAnimSet.addAnimation(scaleBottomAnim);
		bottomAnimSet.addAnimation(transBottomAnim);
		bottomAnimSet.addAnimation(fadeBottomAnim);
		bottomAnimSet.setDuration(nDuration);

		if (bottom_listener != null)
			bottomAnimSet.setAnimationListener(bottom_listener);

		if (zOrder == ZORDER_FIRSTVIEW_TOP) {
			first_view.startAnimation(topAnimSet);
			second_view.startAnimation(bottomAnimSet);
		} else {
			first_view.startAnimation(bottomAnimSet);
			second_view.startAnimation(topAnimSet);
		}
	}



	/**
	 * Calculating animation parameter methods
	 */
	public float getTimePoint(float x_pos) {
		float fResult = (x_pos - downX) / screen_size.x;
		if (fResult < 0)
			fResult = 0;
		return fResult;
	}


	public float getTopViewScale(float time_point) {
		float result = 0;
		result = 1 - (100 - MINIMUM_TOP_VIEW_ZOOM) / 100 * time_point;
		return result;
	}


	public float getBottomViewScale(float time_point) {
		float result = 0;
		result = MINIMUM_BOTTOM_VIEW_ZOOM / 100 + (100 - MINIMUM_BOTTOM_VIEW_ZOOM) / 100 * time_point;
		return result;
	}



	public PointF getTopViewPosition(float time_point) {
		PointF result = new PointF();

		float minimum_height = getTopViewScale(1) * first_view.getHeight();
		float move_distance = first_view.getHeight() - minimum_height;

		result.x = first_view.getWidth() * time_point;
		result.y = move_distance / 2 * time_point;

		return result;
	}


	public PointF getBottomViewPosition(float time_point) {
		PointF result = new PointF();

		float minimum_width = getBottomViewScale(0) * first_view.getWidth();
		float minimum_height = getBottomViewScale(0) * first_view.getHeight();

		result.x = (first_view.getWidth() - minimum_width) * (1 - time_point) / 2;
		result.y = (first_view.getHeight() - minimum_height) * (1 - time_point) / 2;

		return result;
	}


	public float getTopViewAlpha(float time_point) {
		float fAlpha = 0;

		fAlpha = 1 - time_point * (1 - MINIMUM_ALPHA);

		if (fAlpha < 0.1f)
			fAlpha = 0.1f;

		if (fAlpha > 1)
			fAlpha = 0.99f;

		return fAlpha;
	}


	public float getBottomViewAlpha(float time_point) {
		float fAlpha = 0;

		fAlpha = MINIMUM_ALPHA + time_point * (1 - MINIMUM_ALPHA);

		if (fAlpha < 0.1f)
			fAlpha = 0.1f;

		if (fAlpha > 1)
			fAlpha = 0.99f;

		return fAlpha;
	}


	//////////////////////////////////////////////////////////////////////////////


	public void onTouchMove(MotionEvent ev) {
		if (!isDown)
			return;

		if (curX < downX)
			return;

		if (!isMoved) {
			// Started dragging
			isMoved = true;

			first_view.setAlpha(0.99f);
			second_view.setAlpha(0.99f);

			ScaleAnimation initial_anim = new ScaleAnimation(1, getBottomViewScale(0), 1, getBottomViewScale(0));
			initial_anim.setDuration(0);
			initial_anim.setFillAfter(true);

			if (zOrder == ZORDER_FIRSTVIEW_TOP) {
				second_view.startAnimation(initial_anim);
			} else {
				first_view.startAnimation(initial_anim);
			}
		}


		float cur_timepoint = getTimePoint(curX);
		float prev_timepoint = getTimePoint(prevX);


		float fTopViewCurScale = getTopViewScale(cur_timepoint);
		float fTopViewPrevScale = getTopViewScale(prev_timepoint);
		PointF topViewCurPoint = getTopViewPosition(cur_timepoint);
		PointF topViewPrevPoint = getTopViewPosition(prev_timepoint);

		float fBottomViewCurScale = getBottomViewScale(cur_timepoint);
		float fBottomViewPrevScale = getBottomViewScale(prev_timepoint);
		PointF bottomViewCurPoint = getBottomViewPosition(cur_timepoint);
		PointF bottomViewPrevPoint = getBottomViewPosition(prev_timepoint);

		float fBottomViewAlpha = getBottomViewAlpha(cur_timepoint);
		float fTopViewAlpha = getTopViewAlpha(cur_timepoint);

		// Top view
		TranslateAnimation transTopAnim = new TranslateAnimation(topViewPrevPoint.x, topViewCurPoint.x, topViewPrevPoint.y, topViewCurPoint.y);
		transTopAnim.setDuration(0);
		transTopAnim.setFillAfter(true);

		ScaleAnimation scaleTopAnim = new ScaleAnimation(fTopViewPrevScale, fTopViewCurScale, fTopViewPrevScale, fTopViewCurScale);
		scaleTopAnim.setDuration(0);
		scaleTopAnim.setFillAfter(true);

		AnimationSet animTopSet = new AnimationSet(false);
		animTopSet.addAnimation(scaleTopAnim);
		animTopSet.addAnimation(transTopAnim);


		// Bottom view
		TranslateAnimation transBottomAnim = new TranslateAnimation(bottomViewPrevPoint.x, bottomViewCurPoint.x, bottomViewPrevPoint.y, bottomViewCurPoint.y);
		transBottomAnim.setDuration(0);
		transBottomAnim.setFillAfter(true);

		ScaleAnimation scaleBottomAnim = new ScaleAnimation(fBottomViewPrevScale, fBottomViewCurScale, fBottomViewPrevScale, fBottomViewCurScale);
		scaleBottomAnim.setDuration(0);
		scaleBottomAnim.setFillAfter(true);

		AnimationSet animBottomSet = new AnimationSet(false);
		animBottomSet.addAnimation(scaleBottomAnim);
		animBottomSet.addAnimation(transBottomAnim);


		if (zOrder == ZORDER_FIRSTVIEW_TOP) {
			second_view.setAlpha(fBottomViewAlpha);
			first_view.setAlpha(fTopViewAlpha);

			second_view.startAnimation(animBottomSet);
			first_view.startAnimation(animTopSet);
		} else {
			first_view.setAlpha(fBottomViewAlpha);
			second_view.setAlpha(fTopViewAlpha);

			first_view.startAnimation(animBottomSet);
			second_view.startAnimation(animTopSet);
		}
	}

	public void onTouchCancel(MotionEvent ev) {
		onTouchUp(ev);
	}

	public void startFirstAdvertTimer() {
		stopFirstAdvertTimer();

		first_advert_timer_task = new TimerTask() {
			@Override
			public void run() {
				runOnUiThread(new Runnable() {
					@Override
					public void run() {
						if (isAnimating || (isMoved && isDown))
							return;

						if (arrFirstIndicatorViews.size() == 0)
							return;

						int nCurScreen = first_advert_pager.getCurrentScreen();
						if (nCurScreen == arrFirstIndicatorViews.size() - 1)
							nCurScreen = 0;
						else
							nCurScreen++;

						first_advert_pager.setCurrentScreen(nCurScreen, true);
					}
				});
			}
		};

		first_advert_timer = new Timer();
		first_advert_timer.schedule(first_advert_timer_task, ADVERT_TIMER_INTERVAL, ADVERT_TIMER_INTERVAL);
	}


	public void stopFirstAdvertTimer() {
		if (first_advert_timer_task != null) {
			first_advert_timer_task.cancel();
			first_advert_timer_task = null;
		}

		if (first_advert_timer != null) {
			first_advert_timer.cancel();
			first_advert_timer = null;
		}
	}


	public void startSecondAdvertTimer() {
		stopSecondAdvertTimer();

		second_advert_timer_task = new TimerTask() {
			@Override
			public void run() {
				runOnUiThread(new Runnable() {
					@Override
					public void run() {
						if (isAnimating || (isMoved && isDown))
							return;

						if (arrSecondIndicatorViews.size() == 0)
							return;

						int nCurScreen = second_advert_pager.getCurrentScreen();
						if (nCurScreen == arrSecondIndicatorViews.size() - 1)
							nCurScreen = 0;
						else
							nCurScreen++;

						second_advert_pager.setCurrentScreen(nCurScreen, true);
					}
				});
			}
		};

		second_advert_timer = new Timer();
		second_advert_timer.schedule(second_advert_timer_task, ADVERT_TIMER_INTERVAL, ADVERT_TIMER_INTERVAL);
	}


	public void stopSecondAdvertTimer() {
		if (second_advert_timer_task != null) {
			second_advert_timer_task.cancel();
			second_advert_timer_task = null;
		}

		if (second_advert_timer != null) {
			second_advert_timer.cancel();
			second_advert_timer = null;
		}
	}
}
