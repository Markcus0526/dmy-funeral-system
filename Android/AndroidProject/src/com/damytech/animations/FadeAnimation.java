package com.damytech.animations;

import android.view.View;
import android.view.animation.*;

/**
 * File Name : FadeAnimation.java
 * Author : KimHM
 * Date : 2015-03-06 11:38.
 */
public class FadeAnimation extends Animation {
	public static void animate(View view,
							   float from_trans,
							   float to_trans,
							   int duration_millisec,
							   AnimationListener anim_listener) {

		Animation anim = new AlphaAnimation(from_trans, to_trans);
		anim.setInterpolator(new LinearInterpolator()); //add this
		anim.setDuration(duration_millisec);
		anim.setFillAfter(true);

		if (anim_listener != null)
			anim.setAnimationListener(anim_listener);

		view.startAnimation(anim);
	}


	public static void animate(View view,
							   double from_trans,
							   double to_trans,
							   int duration_millisec,
							   AnimationListener anim_listener) {
		animate(view, (float)from_trans, (float)to_trans, duration_millisec, anim_listener);
	}


	public static void animate(View view,
							   float from_trans,
							   float to_trans,
							   int duration_millisec) {
		animate(view, from_trans, to_trans, duration_millisec, null);
	}


	public static void animate(View view,
							   double from_trans,
							   double to_trans,
							   int duration_millisec) {
		animate(view, from_trans, to_trans, duration_millisec, null);
	}


	public static void animate(View view,
							   float from_trans,
							   float to_trans) {
		animate(view, from_trans, to_trans, 300, null);
	}


	public static void animate(View view,
							   double from_trans,
							   double to_trans) {
		animate(view, from_trans, to_trans, 300, null);
	}
}
