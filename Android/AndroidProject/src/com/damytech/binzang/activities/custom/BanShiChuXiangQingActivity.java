package com.damytech.binzang.activities.custom;

import android.graphics.Paint;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperScrollActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STEmployee;
import com.damytech.structure.custom.STOffice;
import com.damytech.utils.AppUtility;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 23:18
 * File Name : BanShiChuJieShaoXiangQingActivity
 */
public class BanShiChuXiangQingActivity extends SuperScrollActivity {
	public static final String EXTRA_OFFICE_ID = "office_id";

	private ImageView img_main = null;
	private TextView txt_addr = null;
	private TextView txt_phone = null;
	private ImageButton btn_phone = null;
	private LinearLayout employee_layout = null;

	private STOffice office_detail = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_banshichuxiangqing);
	}


	@Override
	protected void initializeActivity() {
		long office_id = getIntent().getLongExtra(EXTRA_OFFICE_ID, 0);

		content_scrollview = (ScrollView)findViewById(R.id.main_scrollview);

		img_main = (ImageView)findViewById(R.id.img_main);
		txt_addr = (TextView)findViewById(R.id.txt_addr);
		txt_phone = (TextView)findViewById(R.id.txt_phone);
		btn_phone = (ImageButton)findViewById(R.id.btn_phone);
		employee_layout = (LinearLayout)findViewById(R.id.emp_list_layout);

		startProgress();
		CommManager.getOfficeDetail(office_id, detail_delegate);
	}


	private CommDelegate detail_delegate = new CommDelegate() {
		@Override
		public void getOfficeDetailResult(int retcode, String retmsg, STOffice office_info) {
			super.getOfficeDetailResult(retcode, retmsg, office_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				office_detail = office_info;
				updateUI();
			} else {
				ToastUtility.showToast(BanShiChuXiangQingActivity.this, retmsg);
			}
		}
	};


	private void updateUI() {
		BitmapUtility.setImageWithImageLoader(img_main, office_detail.image_url, loader_options);
		txt_addr.setText(office_detail.address);
		txt_phone.setText(office_detail.phone);
		btn_phone.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onPhoneClicked(office_detail.phone);
			}
		});

		for (int i = 0; i < office_detail.employees.size(); i++) {
			final STEmployee employee = office_detail.employees.get(i);

			RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_banshichuyuangong_layout, null);
			ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

			TextView txt_desc = (TextView)item_layout.findViewById(R.id.txt_desc);
			TextView txt_name = (TextView)item_layout.findViewById(R.id.txt_name);
			TextView txt_phone = (TextView)item_layout.findViewById(R.id.txt_phone);
			txt_phone.setPaintFlags(txt_phone.getPaintFlags() | Paint.UNDERLINE_TEXT_FLAG);
			ImageButton btn_phone = (ImageButton)item_layout.findViewById(R.id.btn_phone);
			btn_phone.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					onPhoneClicked(employee.phone);
				}
			});
			TextView txt_qq = (TextView)item_layout.findViewById(R.id.txt_qq);
			TextView txt_weixin = (TextView)item_layout.findViewById(R.id.txt_weixin);
			ImageView imgPhoto = (ImageView)item_layout.findViewById(R.id.img_photo);

			txt_desc.setText(employee.description);
			txt_name.setText(employee.name);
			txt_phone.setText(employee.phone);
			txt_qq.setText(employee.qq);
			txt_weixin.setText(employee.wechat);
			BitmapUtility.setImageWithImageLoader(imgPhoto, employee.photo_url, loader_options);

			employee_layout.addView(item_layout);
		}
	}

	private void onPhoneClicked(final String strPhone) {
		if(strPhone.length() <= 0)
			return;

		CommonAlertDialog dialog = new CommonAlertDialog.Builder(BanShiChuXiangQingActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要呼叫" + strPhone + "吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						AppUtility.openDialPad(strPhone, BanShiChuXiangQingActivity.this);
					}
				})
				.build();
		dialog.show();
	}
}
