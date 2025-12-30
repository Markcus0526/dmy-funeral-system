package com.damytech.preset_controls;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.HorizontalScrollView;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import com.damytech.binzang.R;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-19
 * Time : 17:36
 * File Name : TDScrollView
 */
public class TDScrollView extends RelativeLayout {
	private Context parentContext = null;


	private ScrollView verScrollView = null;
	private RelativeLayout verScrollLayout = null;

	private HorizontalScrollView horScrollView = null;
	private RelativeLayout horScrollLayout = null;


	public TDScrollView(Context context) {
		super(context);

		parentContext = context;
		layoutView();
	}


	public TDScrollView(Context context, AttributeSet attrs) {
		super(context, attrs);

		parentContext = context;
		layoutView();
	}


	public TDScrollView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);

		parentContext = context;
		layoutView();
	}


	private void layoutView() {
		LayoutInflater.from(parentContext).inflate(R.layout.preset_2d_scrollview, this);

		verScrollView = (ScrollView)findViewById(R.id.ver_scrollview);
		verScrollView.setVerticalScrollBarEnabled(false);
		verScrollLayout = (RelativeLayout)findViewById(R.id.ver_scroll_layout);

		horScrollView = (HorizontalScrollView)findViewById(R.id.hor_scrollview);
		horScrollView.setVerticalScrollBarEnabled(false);
		horScrollLayout = (RelativeLayout)findViewById(R.id.hor_scroll_layout);
	}


	public void addView(View v) {
		ViewGroup.LayoutParams params = v.getLayoutParams();
		if (params == null)
			params = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);

		if (params.width == ViewGroup.LayoutParams.MATCH_PARENT || params.width == ViewGroup.LayoutParams.FILL_PARENT)
			params.width = ViewGroup.LayoutParams.WRAP_CONTENT;

		if (params.height == ViewGroup.LayoutParams.MATCH_PARENT || params.height == ViewGroup.LayoutParams.FILL_PARENT)
			params.height = ViewGroup.LayoutParams.WRAP_CONTENT;

		v.setLayoutParams(params);

		horScrollLayout.addView(v);
	}


	public void removeAllViews() {
		if (horScrollLayout != null)
			horScrollLayout.removeAllViews();
	}


	public void removeView(View v) {
		if (horScrollLayout != null)
			horScrollLayout.removeView(v);
	}


	public View getContentLayout() {
		return horScrollLayout;
	}
}