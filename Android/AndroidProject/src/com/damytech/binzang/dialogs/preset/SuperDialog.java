package com.damytech.binzang.dialogs.preset;


import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.FrameLayout;
import com.damytech.utils.ResolutionUtility;


/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 2015/1/16
 * To change this template use File | Settings | File Templates.
 */

public abstract class SuperDialog extends Dialog {
	protected Context context = null;


	public SuperDialog(Context context) {
		super(context);
		this.context = context;
		setOwnerActivity((Activity)context);
	}


	public SuperDialog(Context context, int theme) {
		super(context, theme);
		this.context = context;
		setOwnerActivity((Activity)context);
	}


	protected SuperDialog(Context context, boolean cancelable, OnCancelListener cancelListener) {
		super(context, cancelable, cancelListener);
		this.context = context;
		setOwnerActivity((Activity)context);
	}


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.getWindow().requestFeature(Window.FEATURE_NO_TITLE);

		SuperDialog.this.setCancelable(true);
		SuperDialog.this.setCanceledOnTouchOutside(true);
	}


	@Override
	public void hide() {
		super.hide();
	}

	/**
	 * Method to initialize dialog.
	 * If you extend the SuperDialog class, it is hardly recommended to call this method in onCreate() method.
	 * The call of this method must be placed after the set of the content view.
	 *
	 * Ex:
	 * @Override
	 * protected void onCreate(Bundle savedInstanceState) {
	 * 		super.onCreate(savedInstanceState);
	 * 		setContentView(R.layout.preset_dlg_progressor);
	 * 		initialize();
	 * }
	 */
	protected void initialize() {
		initEnvironment();
		initControls();
		initResolution();
	}


	protected abstract void initControls();



	protected void initEnvironment()
	{
		/**
		 * Code snippet below is needed when the dialog is round rectangle.
		 * Without this code, the background of the round rectangular corner remains rectangular dim color.
		 */
		this.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));


		/**
		 * Code snippet below is for the parent layout click event.
		 * This is needed for the cancelling dialog when clicked outside the dialog.
		 * Sometimes, dialog can contain transparent parent view which can be touched on.
		 * And then can occur nothing when touch on the view.
		 * So must customize click event.
		 */
		View parentView = getRootView();

		parentView.setClickable(true);
		parentView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				SuperDialog.this.dismiss();
			}
		});

		if (parentView instanceof ViewGroup) {
			ViewGroup parent_layout = (ViewGroup)parentView;
			int nCount = parent_layout.getChildCount();
			for (int i = 0; i < nCount; i++) {
				View child_view = parent_layout.getChildAt(i);
				child_view.setClickable(true);
			}
		}
	}


	/**
	 * Method to get the first child view of the dialog. Normally it is a view group(LinearLayout, RelativeLayout, Framelayout etc.)
	 * @return View object
	 */
	public View getRootView() {
		View parentView = ((FrameLayout)getWindow().getDecorView().findViewById(android.R.id.content)).getChildAt(0);
		return parentView;
	}


	/**
	 * Method to initialize the size of controls in the dialog
	 */
	protected void initResolution()
	{
		Point ptSize = new Point(ResolutionUtility.getBaseWidth(), ResolutionUtility.getBaseHeight());
		if (context != null)
			ptSize = ResolutionUtility.getScreenSize(context.getApplicationContext());

		View parentView = getRootView();
		ResolutionUtility.instance.iterateChild(parentView, ptSize.x, ptSize.y);
	}


	/**
	 * Method to customize outside touch on event.
	 * Sometimes the dialog can contain transparent part of the parent layout which can be touched on and can be
	 * recognized as the outside area of the dialog by user.
	 * In this case, touching on this part must work the same as the actual touching on outside area of the dialog.
	 * In default, the instance of the SuperDialog has the setCanceledOnTouchOutside(true)
	 * method being executed when it is created.
	 * And also in default, touching on the parent layout causes dismissal of the dialog by the code snippet
	 * in the initEnvironment() method.
	 * And then, we customized setCanceledOnTouchOutside() method and if the parameter is false,
	 * remove the click listener of the parent view.
	 *
	 * @param isCancel
	 */
	public void setCanceledOnTouchOutside(boolean isCancel) {
		super.setCanceledOnTouchOutside(isCancel);

		if (!isCancel) {
			View parentView = getRootView();
			parentView.setOnClickListener(null);
			parentView.setClickable(false);
		}
	}

}
