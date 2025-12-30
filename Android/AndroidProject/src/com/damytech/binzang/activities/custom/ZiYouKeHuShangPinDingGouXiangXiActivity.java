package com.damytech.binzang.activities.custom;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STBuyProductLog;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 21:03
 * File Name : ZiYouKeHuShanPinDingGouXiangXiActivity
 */
public class ZiYouKeHuShangPinDingGouXiangXiActivity extends SuperActivity {
	public static final String EXTRA_LOG_ID = "log_id";
	private STBuyProductLog log_detail = null;

	private TextView txtCustomer = null;
	private TextView txtPhone = null;
	private TextView txtAgent = null;
	private TextView txtReserveDate = null;
	private TextView txtServiceType = null;
	private LinearLayout products_layout = null;
	private TextView txtState = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_ziyoukehushangpindinggouxiangxi);
	}


	@Override
	protected void initializeActivity() {
		long log_id = getIntent().getLongExtra(EXTRA_LOG_ID, 0);

		txtCustomer = (TextView)findViewById(R.id.txt_customer);
		txtPhone = (TextView)findViewById(R.id.txt_phone);
		txtAgent = (TextView)findViewById(R.id.txt_agent);
		txtReserveDate = (TextView)findViewById(R.id.txt_reserve_date);
		txtServiceType = (TextView)findViewById(R.id.txt_service);
		products_layout = (LinearLayout)findViewById(R.id.products_layout);
		txtState = (TextView)findViewById(R.id.txt_state);

		if (log_id > 0) {
			startProgress();
			CommManager.getBuyProductLogDetail(AppCommon.loadUserIDLong(getApplicationContext()),
					log_id,
					comm_delegate);
		}
	}



	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getBuyProductLogDetailResult(int retcode, String retmsg, STBuyProductLog log_detail_info) {
			super.getBuyProductLogDetailResult(retcode, retmsg, log_detail_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				log_detail = log_detail_info;

				if (log_detail.is_read == 0) {
					CommManager.readBuyProductLog(AppCommon.loadUserIDLong(getApplicationContext()),
							log_detail.uid,
							comm_delegate);
				}

				updateUI();

				Intent intent = new Intent();
				intent.putExtra(EXTRA_LOG_ID, log_detail.uid);

				setResult(RESULT_OK, intent);

			} else {
				ToastUtility.showToast(ZiYouKeHuShangPinDingGouXiangXiActivity.this, retmsg);
			}
		}

		@Override
		public void readBuyProductLogResult(int retcode, String retmsg) {
			super.readBuyProductLogResult(retcode, retmsg);

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				Intent intent = new Intent();
				intent.putExtra(EXTRA_LOG_ID, log_detail.uid);

				setResult(RESULT_OK, intent);
			}
		}
	};



	private void updateUI() {
		txtCustomer.setText(log_detail.customer);
		txtPhone.setText(log_detail.phone);
		txtAgent.setText(log_detail.agent);
		txtReserveDate.setText(log_detail.reserve_date);
		txtServiceType.setText(log_detail.service_type);
		txtState.setText(log_detail.state_desc);

		for (int i = 0; i < log_detail.products.size(); i++) {
			STProduct product_info = log_detail.products.get(i);

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
