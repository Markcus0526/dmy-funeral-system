package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STCustomer;
import com.damytech.utils.ToastUtility;
import com.damytech.utils.UIUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-20
 * Time : 10:02
 * File Name : LingYuanYuLiuActivity_TabFrame1
 */
public class LingYuanYuLiuActivity_TabFrame1 extends SuperTabActivity.TabFrame {
	private EditText edt_username = null;
	private EditText edt_phone = null;
	private EditText edt_death1 = null;
	private EditText edt_mgr1 = null;
	private EditText edt_death2 = null;
	private EditText edt_mgr2 = null;


	private Button btnCancel = null;
	private Button btnNext = null;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_lingyuanyuliu_tab1, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		edt_username = (EditText)parentView.findViewById(R.id.edt_username);
		edt_phone = (EditText)parentView.findViewById(R.id.edt_userphone);
		edt_death1 = (EditText)parentView.findViewById(R.id.edt_death1);
		edt_mgr1 = (EditText)parentView.findViewById(R.id.edt_mgr1);
		edt_death2 = (EditText)parentView.findViewById(R.id.edt_death2);
		edt_mgr2 = (EditText)parentView.findViewById(R.id.edt_mgr2);


		btnCancel = (Button)parentView.findViewById(R.id.btn_cancel);
		btnCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCancel();
			}
		});

		btnNext = (Button)parentView.findViewById(R.id.btn_next);
		btnNext.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedNext();
			}
		});
	}



	private void onClickedCancel() {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(parentActivity)
				.message("确定要取消吗？")
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						parentActivity.popOverCurActivityAnimated();
					}
				})
				.build();
		dialog.show();
	}


	private void onClickedNext() {
		if (edt_username.getText().toString().equals("")) {
			ToastUtility.showToast(parentActivity, "请输入用户名");
			UIUtility.selectAllText(edt_username);
			return;
		} else if (edt_phone.getText().toString().equals("")) {
			ToastUtility.showToast(parentActivity, "请输入用户手机号码");
			UIUtility.selectAllText(edt_phone);
			return;
		}

		if (edt_death1.getText().toString().equals("") && edt_death2.getText().toString().equals("")) {
			ToastUtility.showToast(parentActivity, "请输入至少一个末者名称");
			return;
		} else if (!edt_death1.getText().toString().equals("") && edt_mgr1.getText().toString().equals("")) {
			ToastUtility.showToast(parentActivity, "请输入抚慰人名称");
			UIUtility.selectAllText(edt_mgr1);
			return;
		} else if (!edt_death2.getText().toString().equals("") && edt_mgr2.getText().toString().equals("")) {
			ToastUtility.showToast(parentActivity, "请输入抚慰人名称");
			UIUtility.selectAllText(edt_mgr2);
			return;
		}

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.customer_name = edt_username.getText().toString();
		yuliuActivity.customer_phone = edt_phone.getText().toString();
		yuliuActivity.death1 = edt_death1.getText().toString();
		yuliuActivity.comfort1 = edt_mgr1.getText().toString();
		yuliuActivity.death2 = edt_death2.getText().toString();
		yuliuActivity.comfort2 = edt_mgr2.getText().toString();

		yuliuActivity.tab_adapter.changeTab(1);
	}

}


