package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.utils.AppUtility;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 10:51
 * File Name : GongSiJianJieActivity
 */
public class GongSiJianJieActivity extends SuperActivity {

	private ImageView imgMain = null;
	private WebContentView webView = null;
	private TextView txtPhone = null;
	private ImageButton btnPhone = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_gongsijianjie);
	}

	@Override
	protected void initializeActivity() {
		imgMain = (ImageView)findViewById(R.id.imageView);
		webView = (WebContentView)findViewById(R.id.webView);
		txtPhone = (TextView)findViewById(R.id.txtPhone);

		btnPhone = (ImageButton)findViewById(R.id.btn_phone);
		btnPhone .setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				CommonAlertDialog dialog = new CommonAlertDialog.Builder(GongSiJianJieActivity.this)
						.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
						.message("确定要呼叫" + txtPhone.getText().toString() + "吗？")
						.positiveListener(new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								AppUtility.openDialPad(txtPhone.getText().toString(), GongSiJianJieActivity.this);
							}
						})
						.build();
				dialog.show();
			}
		});


		// get company intro info
		startProgress();
		CommManager.getCompanyIntro(comp_intro_delegate);
	}


	/**
	 * get company intro delegate
	 */
	private CommDelegate comp_intro_delegate = new CommDelegate() {
		@Override
		public void getCompanyIntroResult(int retcode, String retmsg, String contents, String phone, String image_url) {
			super.getCompanyIntroResult(retcode, retmsg, contents, phone, image_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				updateUI(image_url, contents, phone);
			} else {
				ToastUtility.showToast(GongSiJianJieActivity.this, retmsg);
			}
		}
	};


	/**
	 * update UI using service data
	 * @param imgUrl
	 * @param contents
	 * @param phone
	 */
	private void updateUI(String imgUrl, String contents, String phone)
	{
		BitmapUtility.setImageWithImageLoader(imgMain, imgUrl, loader_options);
		webView.loadHTMLString(contents);
		txtPhone.setText(phone);
	}


}
