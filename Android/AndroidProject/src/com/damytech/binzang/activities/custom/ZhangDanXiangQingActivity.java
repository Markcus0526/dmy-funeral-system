package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperScrollActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STBill;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 00:52
 * File Name : ZhangDanXiangQingActivity
 */
public class ZhangDanXiangQingActivity extends SuperScrollActivity {
	public static final String EXTRA_BILL_ID = "bill_id";

	private STBill bill_info = null;

	private TextView txt_buy_time = null;
	private TextView txt_user_name = null;
	private TextView txt_service = null;
	private TextView txt_service_price = null;
	private LinearLayout products_layout = null;
	private TextView txt_price = null;
	private TextView txt_use_time = null;
	private TextView txt_status = null;
	private TextView txt_remark = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_zhangdanxiangqing);
	}


	@Override
	protected void initializeActivity() {
		long bill_id = getIntent().getLongExtra(EXTRA_BILL_ID, 0);

		content_scrollview = (ScrollView)findViewById(R.id.main_scroll);

		txt_buy_time = (TextView)findViewById(R.id.txt_buy_time);
		txt_user_name = (TextView)findViewById(R.id.txt_user_name);
		txt_service = (TextView)findViewById(R.id.txt_service);
		txt_service_price = (TextView)findViewById(R.id.txt_service_price);
		products_layout = (LinearLayout)findViewById(R.id.products_layout);
		txt_price = (TextView)findViewById(R.id.txt_total_price);
		txt_use_time = (TextView)findViewById(R.id.txt_use_time);
		txt_status = (TextView)findViewById(R.id.txt_status);
		txt_remark = (TextView)findViewById(R.id.txt_remark);

		if (bill_id > 0) {
			startProgress();
			CommManager.getBillDetail(AppCommon.loadUserIDLong(getApplicationContext()),
					bill_id, detail_delegate);
		}
	}



	private CommDelegate detail_delegate = new CommDelegate() {
		@Override
		public void getBillDetailResult(int retcode, String retmsg, STBill bill_info) {
			super.getBillDetailResult(retcode, retmsg, bill_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				ZhangDanXiangQingActivity.this.bill_info = bill_info;
				updateUI();
			} else {
				ToastUtility.showToast(ZhangDanXiangQingActivity.this, retmsg);
			}
		}
	};



	private void updateUI() {
		txt_buy_time.setText(bill_info.buy_time);
		txt_user_name.setText(bill_info.name);
		txt_service.setText(bill_info.service_type);
		txt_service_price.setText(bill_info.service_price_desc);
		txt_price.setText(bill_info.total_amount_desc);
		txt_use_time.setText(bill_info.consume_time);
		txt_status.setText(bill_info.state_desc);
		txt_remark.setText(bill_info.remark);

		for (int i = 0; i < bill_info.products.size(); i++) {
			STProduct product_info = bill_info.products.get(i);

			View item_view = getLayoutInflater().inflate(R.layout.item_zhangdanjipin_layout, null);
			ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

			TextView txt_name = (TextView)item_view.findViewById(R.id.txt_name);
			TextView txt_price = (TextView)item_view.findViewById(R.id.txt_date);

			txt_name.setText(product_info.title + "(" + product_info.amount + ")");
			txt_price.setText(product_info.price_desc);

			products_layout.addView(item_view);
		}
	}

}
