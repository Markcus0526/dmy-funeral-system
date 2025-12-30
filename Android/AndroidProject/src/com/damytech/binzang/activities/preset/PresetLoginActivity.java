package com.damytech.binzang.activities.preset;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.Point;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.*;
import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.api.TagAliasCallback;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.custom.*;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.preset_controls.CheckButton;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;
import com.damytech.utils.UIUtility;

import java.util.LinkedHashSet;
import java.util.Set;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-07
 * Time : 14:53
 * File Name : LoginActivity
 */
public class PresetLoginActivity extends SuperScrollActivity {
	private final int REQ_CODE_FORGOTPWD = 1;

	private ImageView imgBack = null;
	private EditText edt_account = null;
	private EditText edt_password = null;
	private Button btn_confirm = null;

	private CheckButton btn_remember = null;
	private TextView txt_forgot_pwd = null;

	private static final int MSG_SET_TAGS = 1002;
	private static final String TAG = "JPush";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.preset_activity_login);
	}


	@Override
	public void initResolution() {
		final ViewGroup parent_layout = (ViewGroup)getRootView();
		parent_layout.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
			@Override
			public void onGlobalLayout() {
				Point ptTemp = getScreenSize();
				boolean bNeedUpdate = false;

				if (screen_size.x == 0 && screen_size.y == 0) {
					screen_size = ptTemp;
					bNeedUpdate = true;
				} else if (screen_size.x != ptTemp.x || screen_size.y != ptTemp.y) {
					screen_size = ptTemp;
					bNeedUpdate = true;
				}

				if (bNeedUpdate) {
					runOnUiThread(new Runnable() {
						@Override
						public void run() {
							ResolutionUtility.instance.iterateChild(parent_layout, screen_size.x, screen_size.y);

							ViewGroup.LayoutParams params = imgBack.getLayoutParams();
							params.height = screen_size.y;
							imgBack.setLayoutParams(params);
						}
					});
				}

				checkKeyboard();
			}
		});
	}



	@Override
	public void initializeActivity() {
		content_scrollview = (ScrollView)findViewById(R.id.main_scrollview);

		imgBack = (ImageView)findViewById(R.id.img_back);
		edt_account = (EditText)findViewById(R.id.edt_account);
		edt_password = (EditText)findViewById(R.id.edt_password);

		btn_confirm = (Button)findViewById(R.id.btn_login);
		btn_confirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedConfirm();
			}
		});


		boolean isRemember = AppCommon.loadRememberFlag(getApplicationContext());
		if (isRemember) {
			edt_account.setText(AppCommon.loadUserName(getApplicationContext()));
			edt_password.setText(AppCommon.loadUserPwd(getApplicationContext()));
		} else {
			edt_account.setText("");
			edt_password.setText("");
		}

		btn_remember = (CheckButton)findViewById(R.id.btn_remember);
		btn_remember.initialize("记住密码",
				22,
				Color.GRAY,
				isRemember ? CheckButton.CHECKSTATE_ON : CheckButton.CHECKSTATE_OFF);

		txt_forgot_pwd = (TextView)findViewById(R.id.txt_forgot_pwd);
		txt_forgot_pwd.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedForgotPwd();
			}
		});
	}

	private void setNotiTag(String tag)
	{
		// "," Set
		String[] sArray = tag.split(",");
		Set<String> tagSet = new LinkedHashSet<String>();
		for (String sTagItme : sArray) {
			tagSet.add(sTagItme);
		}

		//调用JPush API设置Tag
		mHandler.sendMessage(mHandler.obtainMessage(MSG_SET_TAGS, tagSet));
	}

	private final Handler mHandler = new Handler() {
		@Override
		public void handleMessage(android.os.Message msg) {
			super.handleMessage(msg);
			switch (msg.what) {
				case MSG_SET_TAGS:
					JPushInterface.setAliasAndTags(getApplicationContext(), null, (Set<String>) msg.obj, mTagsCallback);
					break;

				default:
			}
		}
	};

	private final TagAliasCallback mTagsCallback = new TagAliasCallback() {

		@Override
		public void gotResult(int code, String alias, Set<String> tags) {
			String logs ;
			switch (code) {
				case 0:
					logs = "Set tag and alias success";
					Log.i(TAG, logs);
					break;

				case 6002:
					logs = "Failed to set alias and tags due to timeout. Try again after 60s.";
					Log.i(TAG, logs);
//                    if (ExampleUtil.isConnected(getApplicationContext())) {
					mHandler.sendMessageDelayed(mHandler.obtainMessage(MSG_SET_TAGS, tags), 1000 * 60);
//                    } else {
//                        Log.i(TAG, "No network");
//                    }
					break;

				default:
					logs = "Failed with errorCode = " + code;
					Log.e(TAG, logs);
			}
		}
	};

	@Override
	protected void onKeyboardShown(boolean isShown) {
		super.onKeyboardShown(isShown);

		if (isShown)
			content_scrollview.smoothScrollTo(0, (int)(280 * ResolutionUtility.instance.getYPro()));
		else
			content_scrollview.smoothScrollTo(0, 0);
	}


	private void onClickedConfirm() {
		if (edt_account.getText().toString().equals("")) {
			ToastUtility.showToast(PresetLoginActivity.this, "请输入用户名");
			UIUtility.selectAllText(edt_account);
			return;
		}

		if (edt_password.getText().toString().equals("")) {
			ToastUtility.showToast(PresetLoginActivity.this, "请输入密码");
			UIUtility.selectAllText(edt_password);
			return;
		}

		if (edt_password.getText().length() < 6) {
			ToastUtility.showToast(PresetLoginActivity.this, "密码必须为6-16位之间");
			UIUtility.selectAllText(edt_password);
			return;
		}


		startProgress();
		CommManager.loginUser(edt_account.getText().toString(), edt_password.getText().toString(), login_delegate);
	}



	private void onClickedForgotPwd() {
		pushNewActivityAnimatedWithReqCode(WangJiMiMaActivity.class, REQ_CODE_FORGOTPWD);
	}


	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);

		if (resultCode != RESULT_OK)
			return;

		if (requestCode == REQ_CODE_FORGOTPWD) {
			edt_account.setText(data.getStringExtra(WangJiMiMaActivity.EXTRA_USERNAME));
			edt_password.setText("");
		}
	}


	private CommDelegate login_delegate = new CommDelegate() {
		@Override
		public void loginUserResult(int retcode, String retmsg, long user_id, String user_realname, String access_token, int user_type, long office_id, String office_name, String id_image_url) {
			super.loginUserResult(retcode, retmsg, user_id, user_realname, access_token, user_type, office_id, office_name, id_image_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				AppCommon.saveUserID(getApplicationContext(), user_id);
				AppCommon.saveUserRealName(getApplicationContext(), user_realname);
				AppCommon.saveAccessToken(getApplicationContext(), access_token);
				AppCommon.saveUserType(getApplicationContext(), user_type);
				AppCommon.saveOfficeID(getApplicationContext(), office_id);
				AppCommon.saveOfficeName(getApplicationContext(), office_name);
				AppCommon.saveIDImageUrl(getApplicationContext(), id_image_url);

				if (btn_remember.getState() == CheckButton.CHECKSTATE_OFF) {
					AppCommon.saveRememberFlag(getApplicationContext(), false);
					AppCommon.saveUserName(getApplicationContext(), "");
					AppCommon.saveUserPwd(getApplicationContext(), "");
				} else {
					AppCommon.saveRememberFlag(getApplicationContext(), true);
					AppCommon.saveUserName(getApplicationContext(), edt_account.getText().toString());
					AppCommon.saveUserPwd(getApplicationContext(), edt_password.getText().toString());
				}

				//push notification.
				long userid = AppCommon.loadUserIDLong(getApplicationContext());

				if (AppCommon.loadUserType(getApplicationContext()) == ConstMgr.USER_TYPE_CUSTOMER)
					userid += 100000;
				setNotiTag("" + userid);

				moveToHomeActivity();
			} else {
				ToastUtility.showToast(PresetLoginActivity.this, retmsg);
			}
		}
	};


	private void moveToHomeActivity() {
		int user_type = AppCommon.loadUserType(getApplicationContext());

		if (user_type == ConstMgr.USER_TYPE_CUSTOMER) {
			pushNewActivityAnimated(JiuKeHuShouYeActivity.class);
		} else if (user_type == ConstMgr.USER_TYPE_EMPLOYEE) {
			pushNewActivityAnimated(YuanGongShouYeActivity.class);
		} else if (user_type == ConstMgr.USER_TYPE_AGENT) {
			pushNewActivityAnimated(DaiXiaoShangShouYeActivity.class);
		} else if (user_type >= ConstMgr.USER_TYPE_MANAGER) {
			pushNewActivityAnimated(ZhuRenShouYeActivity.class);
		} else {
			pushNewActivityAnimated(LingDaoShouYeActivity.class);
		}

		popOverCurActivityNonAnimated();
	}

}
