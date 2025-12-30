package com.damytech.preset_controls;

import android.content.Context;
import android.graphics.Bitmap;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.*;
import com.damytech.binzang.R;

/**
 * Created by KimHM on 2015-02-02.
 */
public class ComboButton extends RelativeLayout {
	private Context parentContext = null;
	private OnClickListener onClickListener = null;


	// UI Controls
	private LinearLayout content_layout = null;
	private TextView txtContent = null;
	private ImageView imgDownArrow = null;
	private ImageButton btnSelect = null;


	public ComboButton(Context context) {
		super(context);

		parentContext = context;
		layoutViews();
	}


	public ComboButton(Context context, AttributeSet attrs) {
		super(context, attrs);

		parentContext = context;
		layoutViews();
	}


	public ComboButton(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);

		parentContext = context;
		layoutViews();
	}


	private void layoutViews() {
		LayoutInflater.from(parentContext).inflate(R.layout.preset_combobox, this);

		content_layout = (LinearLayout)findViewById(R.id.content_layout);

		txtContent = (TextView)findViewById(R.id.txt_content);
		txtContent.setText("");

		imgDownArrow = (ImageView)findViewById(R.id.img_downarrow);

		btnSelect = (ImageButton)findViewById(R.id.btn_select);
		btnSelect.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickSelect();
			}
		});
	}


	@Override
	public void setBackgroundResource(int resid) {
		content_layout.setBackgroundResource(resid);
	}


	public void setDownArrow(int resid) {
		imgDownArrow.setImageResource(resid);
	}


	public void setDownArrow(Bitmap bmp) {
		imgDownArrow.setImageBitmap(bmp);
	}


	public void setText(String text) {
		this.txtContent.setText(text);
	}


	public void showImgDownArrow(boolean isShow) {
		if (isShow)
			this.imgDownArrow.setVisibility(View.VISIBLE);
		else
			this.imgDownArrow.setVisibility(View.INVISIBLE);
	}


	@Override
	public void setOnClickListener(OnClickListener l) {
		this.onClickListener = l;
	}


	private void onClickSelect() {
		if (this.onClickListener != null) {
			this.onClickListener.onClick(this);
		}
	}


	public void setEnabled(boolean isEnabled) {
		super.setEnabled(isEnabled);
		btnSelect.setEnabled(isEnabled);
	}

}
