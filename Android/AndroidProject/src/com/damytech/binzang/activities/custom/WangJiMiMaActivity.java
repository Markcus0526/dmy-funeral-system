package com.damytech.binzang.activities.custom;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ScrollView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperScrollActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.utils.ToastUtility;
import com.damytech.utils.UIUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-13
 * Time : 19:26
 * File Name : WangJiMiMaActivity
 */
public class WangJiMiMaActivity extends SuperScrollActivity {
	public static final String EXTRA_USERNAME = "username";

	private EditText edt_username = null;
	private EditText edt_phone = null;
	private EditText edt_newpwd = null;
	private EditText edt_confpwd = null;
	private Button btn_confirm = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_wangjimima);
	}


	@Override
	protected void initializeActivity() {
		content_scrollview = (ScrollView)findViewById(R.id.main_scrollview);


		edt_username = (EditText)findViewById(R.id.edt_username);
		edt_phone = (EditText)findViewById(R.id.edt_phone);
		edt_newpwd = (EditText)findViewById(R.id.edt_new_pwd);
		edt_confpwd = (EditText)findViewById(R.id.edt_conf_pwd);

		btn_confirm = (Button)findViewById(R.id.btn_confirm);
		btn_confirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedConfirm();
			}
		});
	}


	private void onClickedConfirm() {
		if (edt_username.getText().toString().equals("")) {
			ToastUtility.showToast(WangJiMiMaActivity.this, "请输入用户名");
			UIUtility.selectAllText(edt_username);
			return;
		}

		if (edt_phone.getText().toString().equals("")) {
			ToastUtility.showToast(WangJiMiMaActivity.this, "请输入手机号码");
			UIUtility.selectAllText(edt_phone);
			return;
		}

		if (edt_phone.getText().toString().length() != 11) {
			ToastUtility.showToast(WangJiMiMaActivity.this, "手机号码必须为11位数字");
			UIUtility.selectAllText(edt_phone);
			return;
		}

		if (edt_newpwd.getText().toString().equals("")) {
			ToastUtility.showToast(WangJiMiMaActivity.this, "请输入新密码");
			UIUtility.selectAllText(edt_newpwd);
			return;
		}

		if (edt_newpwd.getText().toString().length() < 6) {
			ToastUtility.showToast(WangJiMiMaActivity.this, "密码必须为6-16位之间");
			UIUtility.selectAllText(edt_newpwd);
			return;
		}

		if (edt_confpwd.getText().toString().equals("")) {
			ToastUtility.showToast(WangJiMiMaActivity.this, "请输入确认密码");
			UIUtility.selectAllText(edt_confpwd);
			return;
		}

		if (!edt_newpwd.getText().toString().equals(edt_confpwd.getText().toString())) {
			ToastUtility.showToast(WangJiMiMaActivity.this, "确认密码不一致");
			UIUtility.selectAllText(edt_confpwd);
			return;
		}


		startProgress();
		CommManager.forgotPassword(edt_username.getText().toString(),
				edt_phone.getText().toString(),
				edt_newpwd.getText().toString(),
				forgot_delegate);
	}


	private CommDelegate forgot_delegate = new CommDelegate() {
		@Override
		public void forgotPasswordResult(int retcode, String retmsg) {
			super.forgotPasswordResult(retcode, retmsg);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				Intent intent = new Intent();
				intent.putExtra(EXTRA_USERNAME, edt_username.getText().toString());
				setResult(RESULT_OK, intent);

				popOverCurActivityAnimated();
			} else {
				ToastUtility.showToast(WangJiMiMaActivity.this, retmsg);
			}
		}
	};


}
