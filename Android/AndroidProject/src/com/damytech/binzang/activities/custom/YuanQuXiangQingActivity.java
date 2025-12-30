package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.ConstMgr;
import com.damytech.structure.custom.STAreaPoint;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;


/**
 * Created by kimoc on 4/11/15.
 */
public class YuanQuXiangQingActivity extends SuperActivity
{
	private long nAreaId = 0;
	private STAreaPoint mDetInfo = new STAreaPoint();

	private TextView txtTitle = null;
	private TextView txtContent = null;
	private LinearLayout products_list = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yuanquxiangqing);
	}

	@Override
	protected void initializeActivity() {
		nAreaId = getIntent().getLongExtra("area_id", 0);

		txtTitle = (TextView) findViewById(R.id.txtTitle);
		txtContent = (TextView) findViewById(R.id.txtContent);
		products_list = (LinearLayout)findViewById(R.id.products_layout);

		// get area detail info
		startProgress();
		CommManager.getAreaPointDetail(nAreaId, area_detail_delegate);
	}

	/**
	 * get area detail info delegate
	 */
	private CommDelegate area_detail_delegate = new CommDelegate() {
		@Override
		public void getAreaPointDetailResult(int retcode, String retmsg, STAreaPoint point_info)
		{
			super.getAreaPointDetailResult(retcode, retmsg, point_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				mDetInfo = point_info;
				updateUI();
			} else {
				ToastUtility.showToast(YuanQuXiangQingActivity.this, retmsg);
			}
		}
	};

	/**
	 * update ui by detail info
	 */
	private void updateUI()
	{
		txtTitle.setText(mDetInfo.name);
		txtContent.setText(mDetInfo.contents);

		for (int i = 0; i < mDetInfo.products.size(); i++) {
			products_list.addView(getView(mDetInfo.products.get(i)));
		}
	}


	private View getView(STProduct product) {
		RelativeLayout item_layout = null;
		if(product.type == 0) {
			item_layout = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_yuanquchanpin_site_layout, null);
			ImageView imgProduct = (ImageView)item_layout.findViewById(R.id.imageView);
			TextView txtName = (TextView)item_layout.findViewById(R.id.txtName);
			TextView txtOrigin = (TextView)item_layout.findViewById(R.id.txtOrigin);
			TextView txtPrice = (TextView)item_layout.findViewById(R.id.txtPrice);

			BitmapUtility.setImageWithImageLoader(imgProduct, product.image_url, loader_options);
			txtName.setText(product.title);
			txtOrigin.setText(product.product_origin);
			txtPrice.setText(product.price_desc);
		}
		else {
			item_layout = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_yuanquchanpin_tablet_layout, null);
			TextView txtName = (TextView)item_layout.findViewById(R.id.txtName);
			TextView txtPrice = (TextView)item_layout.findViewById(R.id.txtPrice);

			txtName.setText(product.title);
			txtPrice.setText(product.price_desc);
		}

		ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

		return item_layout;
	}
}
