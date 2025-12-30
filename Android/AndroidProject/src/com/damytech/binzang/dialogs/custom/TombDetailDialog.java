package com.damytech.binzang.dialogs.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.SuperDialog;
import com.damytech.structure.custom.STTomb;
import com.damytech.utils.BitmapUtility;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-20
 * Time : 23:57
 * File Name : TombDetailDialog
 */
public class TombDetailDialog extends SuperDialog {
	public SuperActivity parentActivity = null;

	private ImageView imgView = null;
	private TextView txtDesc = null;
	private TextView txtPrice = null;
	private TextView txtNo = null;

	private Button btnConfirm = null;
	private Button btnCancel = null;

	public STTomb tomb_info = null;
	public DialogResultListener listener = null;


	public TombDetailDialog(Context context) {
		super(context);
	}


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.dlg_tomb_detail);

		initialize();
	}


	public void init(SuperActivity parentActivity,
					 STTomb tomb,
					 DialogResultListener listener)
	{
		this.parentActivity = parentActivity;
		this.tomb_info = tomb;
		this.listener = listener;
	}


	// initialization process
	protected void initControls() {
		// initialize title
		imgView = (ImageView)findViewById(R.id.img_tomb);
		txtDesc = (TextView)findViewById(R.id.txt_desc);
		txtPrice = (TextView)findViewById(R.id.txt_date);
		txtNo = (TextView)findViewById(R.id.txt_no);

		if (tomb_info != null) {
			BitmapUtility.setImageWithImageLoader(imgView, tomb_info.image_url, parentActivity.loader_options);
			txtDesc.setText(tomb_info.desc);
			txtPrice.setText(tomb_info.price_desc);
			txtNo.setText(tomb_info.tomb_no);
		}


		btnConfirm = (Button)findViewById(R.id.btn_confirm);
		btnConfirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				TombDetailDialog.this.dismiss();
				if (listener != null && tomb_info != null) {
					listener.onConfirmed(tomb_info.uid);
				}
			}
		});

		btnCancel = (Button)findViewById(R.id.btn_cancel);
		btnCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				TombDetailDialog.this.dismiss();
			}
		});
	}


	public interface DialogResultListener {
		public void onConfirmed(long uid);
	}


}
