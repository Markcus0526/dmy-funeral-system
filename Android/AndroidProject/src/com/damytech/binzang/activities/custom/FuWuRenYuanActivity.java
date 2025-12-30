package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STEmployee;
import com.damytech.utils.AppUtility;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 00:08
 * File Name : LingDaoShouYeActivity
 */
public class FuWuRenYuanActivity extends SuperActivity {
	public static final String EXTRA_DETAIL_TABLE = "extra_detail_table";

	private ImageView imgPhoto = null;
	private TextView txtName = null;
	private TextView txtDesc = null;
	private TextView txtOffice = null;
	private TextView txtPhone = null;
	private ImageButton btnPhone = null;
	private TextView txtAddr = null;

	private RelativeLayout bonus_layout = null;
	private TextView txtBonusDetail = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_fuwurenyuan);
	}


	@Override
	protected void initializeActivity() {
		imgPhoto = (ImageView)findViewById(R.id.img_photo);
		txtName = (TextView)findViewById(R.id.txt_name);
		txtDesc = (TextView)findViewById(R.id.txt_desc);
		txtOffice = (TextView)findViewById(R.id.txt_office);
		txtPhone = (TextView)findViewById(R.id.txt_phone);

		btnPhone = (ImageButton)findViewById(R.id.btn_phone);
		btnPhone.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPhone();
			}
		});

		txtAddr = (TextView)findViewById(R.id.txt_addr);



		boolean hasBonusTable = getIntent().getBooleanExtra(EXTRA_DETAIL_TABLE, false);

		bonus_layout = (RelativeLayout)findViewById(R.id.detail_table);
		if (!hasBonusTable)
			bonus_layout.setVisibility(View.GONE);

		txtBonusDetail = (TextView)findViewById(R.id.lbl_details);
		txtBonusDetail.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedBonusDetail();
			}
		});


		startProgress();
		CommManager.getServicePeopleInfo(AppCommon.loadUserIDLong(getApplicationContext()),
				info_delegate);
	}



	private CommDelegate info_delegate = new CommDelegate() {
		@Override
		public void getServicePeopleInfoResult(int retcode, String retmsg, STEmployee employee) {
			super.getServicePeopleInfoResult(retcode, retmsg, employee);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				updateUI(employee);
			} else {
				ToastUtility.showToast(FuWuRenYuanActivity.this, retmsg);
			}
		}
	};


	private void updateUI(STEmployee employee) {
		BitmapUtility.setImageWithImageLoader(imgPhoto, employee.photo_url, loader_options);
		txtName.setText(employee.name);
		txtDesc.setText(employee.description);
		txtOffice.setText(employee.office);
		txtPhone.setText(employee.phone);
		txtAddr.setText(employee.address);
	}


	private void onClickedPhone() {
		if (txtPhone.getText().toString().equals(""))
			return;

		CommonAlertDialog dialog = new CommonAlertDialog.Builder(FuWuRenYuanActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要呼叫" + txtPhone.getText().toString() + "吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						AppUtility.openDialPad(txtPhone.getText().toString(), FuWuRenYuanActivity.this);
					}
				})
				.build();
		dialog.show();
	}


	private void onClickedBonusDetail() {
		pushNewActivityAnimated(JiangJinMingXiBiaoActivity.class);
	}


}
