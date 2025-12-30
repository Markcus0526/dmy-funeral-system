package com.damytech.binzang.dialogs.preset;

import android.content.Context;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import com.damytech.binzang.R;
import com.damytech.utils.StringUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 16:59
 * File Name : CommonInputNumberDialog
 */
public class CommonInputNumberDialog extends SuperDialog {
	public static final int NUMBER_TYPE_DOUBLE = 1;
	public static final int NUMBER_TYPE_INTEGER = 2;

	private int number_type = NUMBER_TYPE_INTEGER;

	private NumberDialogListener listener = null;
	private double defValue = 0;

	private EditText edt_value = null;
	private Button btnConfirm = null, btnCancel = null;

	public CommonInputNumberDialog(Context context) {
		super(context);
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.preset_dlg_inputnum);

		initialize();
	}


	@Override
	protected void initControls() {
		edt_value = (EditText)findViewById(R.id.edt_num);
		if (number_type == NUMBER_TYPE_DOUBLE) {
			edt_value.setText("" + StringUtility.formatDouble(defValue));
			edt_value.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL);
		} else {
			edt_value.setText("" + (int)defValue);
			edt_value.setInputType(InputType.TYPE_CLASS_NUMBER);
		}

		btnConfirm = (Button)findViewById(R.id.btn_confirm);
		btnConfirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (listener != null) {
					listener.onResult(Double.parseDouble(edt_value.getText().toString()));
				}

				CommonInputNumberDialog.this.dismiss();
			}
		});

		btnCancel = (Button)findViewById(R.id.btn_cancel);
		btnCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				CommonInputNumberDialog.this.dismiss();
			}
		});
	}


	public void setDefaultValue(double defValue) {
		CommonInputNumberDialog.this.defValue = defValue;
		if (edt_value != null) {
			if (number_type == NUMBER_TYPE_DOUBLE) {
				edt_value.setText("" + StringUtility.formatDouble(defValue));
				edt_value.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL);
			} else {
				edt_value.setText("" + (int)defValue);
				edt_value.setInputType(InputType.TYPE_CLASS_NUMBER);
			}
		}
	}


	public void setNumberType(int type) {
		CommonInputNumberDialog.this.number_type = type;

		if (edt_value != null) {
			if (number_type == NUMBER_TYPE_DOUBLE) {
				edt_value.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL);
			} else {
				edt_value.setInputType(InputType.TYPE_CLASS_NUMBER);
			}
		}
	}


	public void setPositiveListener(NumberDialogListener listener) {
		CommonInputNumberDialog.this.listener = listener;
	}


	public static class Builder {
		Context context = null;
		double defValue = 0;
		int number_type = NUMBER_TYPE_DOUBLE;
		NumberDialogListener listener = null;

		public Builder(Context context) {
			super();
			this.context = context;
		}


		public Builder defaultValue(double defValue) {
			this.defValue = defValue;
			return Builder.this;
		}

		public Builder numberType(int type) {
			this.number_type = type;
			return Builder.this;
		}

		public Builder positiveListener(NumberDialogListener listener) {
			this.listener = listener;
			return Builder.this;
		}

		public CommonInputNumberDialog build() {
			CommonInputNumberDialog dialog = new CommonInputNumberDialog(context);

			dialog.setDefaultValue(defValue);
			dialog.setNumberType(number_type);
			dialog.setPositiveListener(listener);

			return dialog;
		}

	}


	public interface NumberDialogListener {
		public void onResult(double fvalue);
	}


}
