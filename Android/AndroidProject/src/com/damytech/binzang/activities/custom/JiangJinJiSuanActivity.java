package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.utils.StringUtility;
import com.damytech.utils.ToastUtility;
import com.damytech.utils.UIUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-19
 * Time : 10:59
 * File Name : JiangJinJiSuanActivity
 */
public class JiangJinJiSuanActivity extends SuperActivity {
	private EditText edt_price = null;
	private EditText edt_discount = null;
	private TextView txt_notax = null;
	private TextView txt_tax = null;

	private ImageButton btnCalc = null, btnReset = null;

	private double discount_limit = 0;
	private double commission = 0;
	private double tax_rate = 0;



	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_jiangjinjisuan);
	}


	@Override
	protected void initializeActivity() {
		edt_price = (EditText)findViewById(R.id.edt_price);
		edt_discount = (EditText)findViewById(R.id.edt_discount);
		txt_notax = (TextView)findViewById(R.id.txt_notax);
		txt_tax = (TextView)findViewById(R.id.txt_tax);

		btnCalc = (ImageButton)findViewById(R.id.btn_calc);
		btnReset = (ImageButton)findViewById(R.id.btn_reset);

		btnCalc.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCalc();
			}
		});
		btnReset.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedReset();
			}
		});


		startProgress("获取计算公式参数中，请稍后...");
		CommManager.getBonusFormula(AppCommon.loadUserIDLong(getApplicationContext()),
				formula_delegate);
	}



	private CommDelegate formula_delegate = new CommDelegate() {
		@Override
		public void getBonusFormulaResult(int retcode, String retmsg, double discount_limit, double commission, double tax_rate) {
			super.getBonusFormulaResult(retcode, retmsg, discount_limit, commission, tax_rate);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				JiangJinJiSuanActivity.this.discount_limit = discount_limit;
				JiangJinJiSuanActivity.this.commission = commission;
				JiangJinJiSuanActivity.this.tax_rate = tax_rate;
			} else {
				ToastUtility.showToast(JiangJinJiSuanActivity.this, retmsg);
			}
		}
	};


	private void onClickedCalc() {
		if (edt_price.getText().toString().equals("")) {
			ToastUtility.showToast(JiangJinJiSuanActivity.this, "请输入价格");
			UIUtility.selectAllText(edt_price);
			return;
		}

		if (edt_discount.getText().toString().equals("")) {
			ToastUtility.showToast(JiangJinJiSuanActivity.this, "请输入折扣");
			UIUtility.selectAllText(edt_discount);
			return;
		}


		double price = 0, discount = 0;

		try {
			price = Double.parseDouble(edt_price.getText().toString());
		} catch (Exception ex) {
			ex.printStackTrace();
			ToastUtility.showToast(JiangJinJiSuanActivity.this, "价格输入的不正确");
			UIUtility.selectAllText(edt_price);
			return;
		}

		try {
			discount = Double.parseDouble(edt_discount.getText().toString());
		} catch (Exception ex) {
			ex.printStackTrace();
			ToastUtility.showToast(JiangJinJiSuanActivity.this, "折扣输入的不正确");
			UIUtility.selectAllText(edt_discount);
			return;
		}


		if (price <= 0) {
			ToastUtility.showToast(JiangJinJiSuanActivity.this, "价格输入的不正确");
			UIUtility.selectAllText(edt_price);
			return;
		}


		if (discount >= 100 || discount < 0) {
			ToastUtility.showToast(JiangJinJiSuanActivity.this, "折扣值超过了范围, 请查看");
			UIUtility.selectAllText(edt_discount);
			return;
		}


		if (discount < discount_limit) {
			ToastUtility.showToast(JiangJinJiSuanActivity.this, "超过授权，无法销售！");
			UIUtility.selectAllText(edt_discount);
			return;
		}


		double notax_value = price * (discount / 100) * (commission / 100);
		double tax_value = notax_value * tax_rate;

		txt_notax.setText(StringUtility.formatDouble(notax_value) + "元");
		txt_tax.setText(StringUtility.formatDouble(tax_value) + "元");
	}


	private void onClickedReset() {
		edt_price.setText("");
		edt_discount.setText("");
		txt_notax.setText("");
		txt_tax.setText("");
		UIUtility.selectAllText(edt_discount);
	}
}




