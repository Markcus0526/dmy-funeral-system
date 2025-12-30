package com.damytech.utils;

import android.content.Context;
import android.graphics.Rect;
import android.graphics.RectF;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:59
 * File Name : UIUtility
 */
public class UIUtility {
	/**
	 * Method to show keyboard for the edit control
	 *
	 * @param editText Edit text to show keyboard
	 * @param context  Context
	 */
	public static void showKeyboardFromEditControl(Context context, EditText editText) {
		InputMethodManager mgr = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
		mgr.showSoftInput(editText, InputMethodManager.SHOW_IMPLICIT);
	}


	/**
	 * Method to hide keyboard for the edit control
	 *
	 * @param editText Edit text to hide keyboard
	 * @param context  Context
	 */
	public static void hideKeyboardFromEditControl(Context context, EditText editText) {
		InputMethodManager mgr = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
		mgr.hideSoftInputFromWindow(editText.getWindowToken(), 0);
	}


	/**
	 * Method to hide keyboard for the every edit controls in the group indicated with parameter
	 *
	 * @param view	View to scan the edit text
	 * @param context Context
	 */
	public static void hideKeyboardsInView(Context context, View view) {
		if (view == null)
			return;

		if (view instanceof EditText) {
			UIUtility.hideKeyboardFromEditControl(context, (EditText)view);
		}

		if (view instanceof ViewGroup) {
			ViewGroup viewGroup = (ViewGroup) view;

			int nCount = viewGroup.getChildCount();
			for (int i = 0; i < nCount; i++) {
				hideKeyboardsInView(context, viewGroup.getChildAt(i));
			}
		}
	}


	/**
	 * Method to get absolute left margin of view
	 *
	 * @param myView
	 * @return
	 */
	public static int getAbsoluteLeftForRootView(View myView) {
		if (myView.getParent() == null)
			return 0;

		if (myView.getParent() == myView.getRootView())
			return myView.getLeft();
		else
			return myView.getLeft() + getAbsoluteLeftForRootView((View) myView.getParent());
	}


	/**
	 * Method to get absolute top margin of view
	 *
	 * @param myView
	 * @return
	 */
	public static int getAbsoluteTopForRootView(View myView) {
		if (myView.getParent() == null)
			return 0;

		if (myView.getParent() == myView.getRootView())
			return myView.getTop();
		else
			return myView.getTop() + getAbsoluteTopForRootView((View) myView.getParent());
	}


	/**
	 * Method to get rect of view in global
	 *
	 * @param v
	 * @return
	 */
	public static Rect getFrameForRootView(View v) {
		int nLeft = getAbsoluteLeftForRootView(v);
		int nTop = getAbsoluteTopForRootView(v);
		return new Rect(nLeft, nTop, nLeft + v.getWidth(), nTop + v.getHeight());
	}


	public static RectF getFrameFForRootView(View v) {
		int nLeft = getAbsoluteLeftForRootView(v);
		int nTop = getAbsoluteTopForRootView(v);
		return new RectF(nLeft, nTop, nLeft + v.getWidth(), nTop + v.getHeight());
	}


	/**
	 * Select all text in edit text control
	 *
	 * @param editText
	 */
	public static void selectAllText(EditText editText) {
		if (editText == null)
			return;

		editText.requestFocus();

		if (editText.getText().toString().length() > 0)
			editText.setSelection(editText.getText().toString().length());
	}


}
