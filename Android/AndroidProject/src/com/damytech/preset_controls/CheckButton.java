package com.damytech.preset_controls;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.utils.ResolutionUtility;

/**
 * Created by KimHM on 2015-02-02.
 */
public class CheckButton extends RelativeLayout {
	// Constants
	public static final int CHECKSTATE_OFF = 0;
	public static final int CHECKSTATE_ON = 1;
	public static final int CHECKSTATE_MIXED = 2;


	private Context parentContext = null;
	private CheckStateChangeListener delegate = null;

	// Resource variables
	private Bitmap bmpCheckOn = null;
	private Bitmap bmpCheckOff = null;
	private Bitmap bmpCheckMixed = null;

	// Control variables
	private ImageView imgCheck = null;
	private TextView txtCaption = null;
	private ImageButton btnCheck = null;

	// Data variables
	private String caption = "";
	private int state = CHECKSTATE_ON;
	private boolean has_third_state = false;


	public CheckButton(Context context) {
		super(context);

		parentContext = context;
		LayoutInflater.from(parentContext).inflate(R.layout.preset_checkbox, this);
		layoutView();
	}


	public CheckButton(Context context, AttributeSet attrs) {
		super(context, attrs);

		parentContext = context;
		LayoutInflater.from(parentContext).inflate(R.layout.preset_checkbox, this);
		layoutView();
	}


	public CheckButton(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);

		parentContext = context;
		LayoutInflater.from(parentContext).inflate(R.layout.preset_checkbox, this);
		layoutView();
	}

	public CheckButton(Context context,
					   String caption,
					   int initialState,
					   int check_off_resid,
					   int check_on_resid,
					   int check_mixed_resid,
					   boolean has_third_state)
	{
		super(context);
		parentContext = context;
		LayoutInflater.from(parentContext).inflate(R.layout.preset_checkbox, this);
		initialize(caption, -1, 0, initialState, check_off_resid, check_on_resid, check_mixed_resid, has_third_state);
	}


	public void initialize(String caption, int textSize, int textColor) {
		initialize(caption, textSize, textColor, CHECKSTATE_ON, 0, 0, 0, false);
	}


	public void initialize(String caption, int textSize, int textColor, int initialState) {
		initialize(caption, textSize, textColor, initialState, 0, 0, 0, false);
	}


	public void initialize(String caption,
						   int initialState,
						   int check_off_resid,
						   int check_on_resid,
						   int check_mixed_resid,
						   boolean has_third_state)
	{
		initialize(caption, -1, 0, initialState, check_off_resid, check_on_resid, check_mixed_resid, has_third_state);
	}


	/**
	 * Method to initialize check button
	 *
	 * @param caption				Check button title
	 * @param textSize				Check button title size in pixels. Please use size in Nexus S(480 x 800).
	 *								Input minus value to use default value(22pixel in Nexus S)
	 * @param initialState			Check button initial state
	 * @param check_off_resid		Check button off state resource id
	 * @param check_on_resid		Check button on state resource id
	 * @param check_mixed_resid		Check button mixed state resouce id
	 * @param has_third_state		true if check button has mixed state
	 */
	public void initialize(String caption,
						   int textSize,
						   int textColor,
						   int initialState,
						   int check_off_resid,
						   int check_on_resid,
						   int check_mixed_resid,
						   boolean has_third_state)
	{
		this.caption = caption;
		this.state = initialState;
		this.has_third_state = has_third_state;

		bmpCheckOff = BitmapFactory.decodeResource(parentContext.getResources(), check_off_resid);
		bmpCheckOn = BitmapFactory.decodeResource(parentContext.getResources(), check_on_resid);
		bmpCheckMixed = BitmapFactory.decodeResource(parentContext.getResources(), check_mixed_resid);

		layoutView(textSize, textColor);
	}


	public void setText(String text) {
		this.caption = text;

		if (txtCaption != null) {
			txtCaption.setVisibility(View.VISIBLE);
			txtCaption.setText(text);
		}
	}


	public void setText(int strid) {
		this.caption = parentContext.getResources().getString(strid);

		if (txtCaption != null) {
			txtCaption.setVisibility(View.VISIBLE);
			txtCaption.setText(this.caption);
		}
	}



	public void setCheckStateChangeListener(CheckStateChangeListener delegate) {
		this.delegate = delegate;
	}

	private void layoutView() {
		layoutView(-1, 0);
	}

	private void layoutView(int textSize, int textColor) {

		imgCheck = (ImageView)findViewById(R.id.img_check);
		txtCaption = (TextView)findViewById(R.id.txt_caption);

		btnCheck = (ImageButton)findViewById(R.id.btn_check);
		btnCheck.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedItem();
			}
		});


		// Initialize resource
		if (bmpCheckOff == null) {
			bmpCheckOff = BitmapFactory.decodeResource(parentContext.getResources(), R.drawable.preset_check_off);
		}

		if (bmpCheckOn == null) {
			bmpCheckOn = BitmapFactory.decodeResource(parentContext.getResources(), R.drawable.preset_check_on);
		}

		if (bmpCheckMixed == null) {
			bmpCheckMixed = BitmapFactory.decodeResource(parentContext.getResources(), R.drawable.preset_check_mixed);
		}


		// Initialize controls
		if (state == CHECKSTATE_ON)
			this.imgCheck.setImageBitmap(bmpCheckOn);
		else if (state == CHECKSTATE_OFF)
			this.imgCheck.setImageBitmap(bmpCheckOff);
		else
			this.imgCheck.setImageBitmap(bmpCheckMixed);

		if (textSize > 0) {
			this.txtCaption.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize * ResolutionUtility.instance.getPro());
			this.txtCaption.setTag(R.string.TAG_KEY_FONTSIZE, "" + textSize);
		}

		this.txtCaption.setTextColor(textColor);


		if (caption.equals("")) {
			this.txtCaption.setVisibility(View.GONE);
		} else {
			this.txtCaption.setVisibility(View.VISIBLE);
			this.txtCaption.setText(caption);
		}
	}



	private void onClickedItem() {
		state++;
		if (has_third_state)
			state = state % 3;
		else
			state = state % 2;

		if (state == CHECKSTATE_ON)
			imgCheck.setImageBitmap(bmpCheckOn);
		else if (state == CHECKSTATE_OFF)
			imgCheck.setImageBitmap(bmpCheckOff);
		else
			imgCheck.setImageBitmap(bmpCheckMixed);


		if (delegate != null)
			delegate.onStateChanged(state);
	}


	public int getState() {
		return this.state;
	}


	public void setState(int state) {
		this.state = state;
		if (state == CHECKSTATE_ON)
			imgCheck.setImageBitmap(bmpCheckOn);
		else if (state == CHECKSTATE_OFF)
			imgCheck.setImageBitmap(bmpCheckOff);
		else
			imgCheck.setImageBitmap(bmpCheckMixed);
	}


	public void setEnabled(boolean isEnabled) {
		super.setEnabled(isEnabled);
		btnCheck.setEnabled(isEnabled);
	}


	public interface CheckStateChangeListener {
		public void onStateChanged(int state);
	}
}
