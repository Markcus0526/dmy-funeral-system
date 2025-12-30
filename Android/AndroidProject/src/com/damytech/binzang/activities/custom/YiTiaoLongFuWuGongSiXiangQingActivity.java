package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STDragonService;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 14:48
 * File Name : YiTiaoLongFuWuGongSiXiangQingActivity
 */
public class YiTiaoLongFuWuGongSiXiangQingActivity extends SuperActivity {
	public static final String EXTRA_SERVICE_ID = "area_id";

	private long service_id = 0;

	private TextView txtCompanyName = null;
	private TextView txtPrice = null;
	private TextView txtCompanyIntro = null;
	private TextView txtGoodsIntro = null;
	private TextView txtServiceContent = null;
	private ImageView imageCompanyIntro = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yitiaolongfuwugongsixiangqing);
	}

	@Override
	protected void initializeActivity() {
		service_id = getIntent().getLongExtra(EXTRA_SERVICE_ID, 0);

		txtCompanyName = (TextView)findViewById(R.id.txt_company_name);
		txtPrice = (TextView)findViewById(R.id.txt_date);
		txtCompanyIntro = (TextView)findViewById(R.id.txt_company_intro);
		txtGoodsIntro = (TextView)findViewById(R.id.txt_goods_intro);
		txtServiceContent = (TextView)findViewById(R.id.txt_service_content);
		imageCompanyIntro = (ImageView)findViewById(R.id.img_intro);

		loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getOneDragonCompanyDetail(service_id, one_service_detail_delegate);
	}

	private CommDelegate one_service_detail_delegate = new CommDelegate() {
		@Override
		public void getOneDragonCompanyDetailResult(int retcode, String retmsg, STDragonService service_info) {
			super.getOneDragonCompanyDetailResult(retcode, retmsg, service_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setServiceData(service_info);
			} else {
				ToastUtility.showToast(YiTiaoLongFuWuGongSiXiangQingActivity.this, retmsg);
			}
		}
	};

	private void setServiceData(STDragonService service_info) {
		txtCompanyName.setText(service_info.name);
		txtPrice.setText(service_info.price_desc);
		txtCompanyIntro.setText(service_info.intro);
		txtGoodsIntro.setText(service_info.product_intro);
		txtServiceContent.setText(service_info.service_contents);
		BitmapUtility.setImageWithImageLoader(imageCompanyIntro, service_info.image_url, loader_options);
	}
}
