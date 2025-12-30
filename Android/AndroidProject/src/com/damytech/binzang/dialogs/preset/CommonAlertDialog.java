package com.damytech.binzang.dialogs.preset;


import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import com.damytech.binzang.R;


/**
 * Created by KimHM on 2014-10-13.
 */
public class CommonAlertDialog extends SuperDialog {
	public static int DIALOGTYPE_ALERT = 1;
	public static int DIALOGTYPE_CONFIRM = 2;

	private int nDialogType = DIALOGTYPE_ALERT;
	private String szMessage = "";

	protected View.OnClickListener positive_listener = null;
	protected View.OnClickListener negative_listener = null;

	private String szConfirm = null, szCancel = null;

	private Button btnOK = null, btnCancel = null;
	private TextView txtMessage = null;

	public CommonAlertDialog(Context context) {
		super(context);
	}


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.preset_dlg_alert);

		initialize();
	}


	@Override
	protected void initControls()
	{
		btnOK = (Button)findViewById(R.id.btnOk);
		btnOK.setOnClickListener(default_positive_listener);
		if (szConfirm != null)
			btnOK.setText(szConfirm);

		btnCancel = (Button)findViewById(R.id.btnCancel);
		btnCancel.setOnClickListener(default_negative_listener);
		if (szCancel != null)
			btnCancel.setText(szCancel);

		txtMessage = (TextView)findViewById(R.id.lbl_message);
		txtMessage.setText(szMessage);

		if (nDialogType == DIALOGTYPE_ALERT)
			btnCancel.setVisibility(View.GONE);
	}

	public void setDialogType(int nDialogType)
	{
		this.nDialogType = nDialogType;
	}

	public void setMessage(String szMessage)
	{
		this.szMessage = szMessage;
	}

	public void setConfirmTitle(String szConfirm)
	{
		this.szConfirm = szConfirm;
	}

	public void setCancelTitle(String szCancel)
	{
		this.szCancel = szCancel;
	}

	public static class Builder
	{
		private Context context = null;
		private String szMessage = "";
		private int nDialogType = DIALOGTYPE_ALERT;
		private View.OnClickListener positive_listener = null, negative_listener = null;

		private String szConfirm = null, szCancel = null;

		public Builder(Context context)
		{
			this.context = context;
		}

		public Builder message(String szMessage)
		{
			this.szMessage = szMessage;
			return this;
		}

		public Builder type(int nType)
		{
			this.nDialogType = nType;
			return this;
		}

		public Builder positiveTitle(String szConfirm)
		{
			this.szConfirm = szConfirm;
			return this;
		}

		public Builder negativeTitle(String szCancel)
		{
			this.szCancel = szCancel;
			return this;
		}

		public Builder positiveListener(View.OnClickListener positiveListener)
		{
			this.positive_listener = positiveListener;
			return this;
		}

		public Builder negativeListener(View.OnClickListener negativeListener)
		{
			this.negative_listener = negativeListener;
			return this;
		}

		public CommonAlertDialog build()
		{
			if (context == null)
				return null;

			CommonAlertDialog dlg = new CommonAlertDialog(context);
			dlg.setDialogType(nDialogType);
			dlg.setMessage(szMessage);
			dlg.setPositiveListener(positive_listener);
			dlg.setNegativeListener(negative_listener);
			dlg.setConfirmTitle(szConfirm);
			dlg.setCancelTitle(szCancel);

			return dlg;
		}
	}


	public void setPositiveListener(View.OnClickListener listener) {
		positive_listener = listener;
	}

	public void setNegativeListener(View.OnClickListener listener) {
		negative_listener = listener;
	}

	protected View.OnClickListener default_positive_listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			CommonAlertDialog.this.dismiss();
			if (positive_listener != null)
				positive_listener.onClick(v);
		}
	};

	protected View.OnClickListener default_negative_listener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			CommonAlertDialog.this.dismiss();
			if (negative_listener != null)
				negative_listener.onClick(v);
		}
	};

}
