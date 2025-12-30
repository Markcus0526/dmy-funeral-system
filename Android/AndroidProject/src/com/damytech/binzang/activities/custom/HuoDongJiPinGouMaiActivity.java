package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonDateTimePickerDialog;
import com.damytech.binzang.dialogs.preset.CommonInputNumberDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;
import org.json.JSONArray;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 00:08
 * File Name : LingDaoShouYeActivity
 */
public class HuoDongJiPinGouMaiActivity extends SuperActivity {
	private ListView list_view = null;
	private DataAdapter adapter = null;

	private ImageButton btnBuy = null;

	private ArrayList<STProduct> arrProducts = new ArrayList<STProduct>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_huodongjipingoumai);
	}


	@Override
	protected void initializeActivity() {
		list_view = (ListView)findViewById(R.id.list_view);
		adapter = new DataAdapter(HuoDongJiPinGouMaiActivity.this, arrProducts);
		list_view.setAdapter(adapter);

		btnBuy = (ImageButton)findViewById(R.id.btn_shopcart);
		btnBuy.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedShopCart();
			}
		});

		startProgress();
		CommManager.getActivityProducts(AppCommon.loadUserIDLong(getApplicationContext()),
				products_delegate);
	}



	private CommDelegate products_delegate = new CommDelegate() {
		@Override
		public void getActivityProductsResult(int retcode, String retmsg, ArrayList<STProduct> arrProducts) {
			super.getActivityProductsResult(retcode, retmsg, arrProducts);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				HuoDongJiPinGouMaiActivity.this.arrProducts.clear();
				HuoDongJiPinGouMaiActivity.this.arrProducts.addAll(arrProducts);

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(HuoDongJiPinGouMaiActivity.this, retmsg);
			}
		}
	};


	public class STViewHolder {
		public long item_id = 0;
		public TextView txtTitle = null;
		public TextView txtPrice = null;
		public ImageView imgProduct = null;
		public ImageButton btnMinus = null;
		public ImageButton btnPlus = null;
		public TextView txtCount = null;
		public ImageButton btnCount = null;
	}



	public class DataAdapter extends ArrayAdapter<STProduct> {
		public DataAdapter(Context context, List<STProduct> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STProduct item_info = arrProducts.get(position);

			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_chanpin_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtTitle = (TextView)item_view.findViewById(R.id.txt_title);
				holder.imgProduct = (ImageView)item_view.findViewById(R.id.img_product);
				holder.txtPrice = (TextView)item_view.findViewById(R.id.txt_date);
				holder.btnMinus = (ImageButton)item_view.findViewById(R.id.btn_minus);
				holder.btnPlus = (ImageButton)item_view.findViewById(R.id.btn_plus);
				holder.txtCount = (TextView)item_view.findViewById(R.id.txt_count);
				holder.btnCount = (ImageButton)item_view.findViewById(R.id.btn_count);
				holder.btnCount.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onClickedCount((STViewHolder)v.getTag());
					}
				});

				holder.btnMinus.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onMinusClicked((STViewHolder)v.getTag());
					}
				});
				holder.btnPlus.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onPlusClicked((STViewHolder)v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.item_id = item_info.uid;
			holder.txtTitle.setText(item_info.title);
			BitmapUtility.setImageWithImageLoader(holder.imgProduct, item_info.image_url, loader_options);
			holder.txtPrice.setText(item_info.price_desc);
			holder.txtCount.setText("" + item_info.amount);
			holder.btnCount.setTag(holder);
			holder.btnMinus.setTag(holder);
			holder.btnPlus.setTag(holder);

			return convertView;
		}
	};


	private STProduct getProductFromID(long uid) {
		STProduct product = null;
		for (int i = 0; i < arrProducts.size(); i++) {
			if (arrProducts.get(i).uid == uid) {
				product = arrProducts.get(i);
				break;
			}
		}

		return product;
	}


	private void onMinusClicked(STViewHolder holder) {
		STProduct product = getProductFromID(holder.item_id);
		if (product == null)
			return;

		if (product.amount > 0) {
			product.amount--;
			holder.txtCount.setText("" + product.amount);
		}
	}

	private void onPlusClicked(STViewHolder holder) {
		STProduct product = getProductFromID(holder.item_id);
		if (product == null)
			return;

		product.amount++;
		holder.txtCount.setText("" + product.amount);
	}


	private void onClickedCount(STViewHolder holder) {
		STProduct product = getProductFromID(holder.item_id);
		if (product == null)
			return;

		final STProduct final_product = product;

		CommonInputNumberDialog dialog = new CommonInputNumberDialog.Builder(HuoDongJiPinGouMaiActivity.this)
				.defaultValue(product.amount)
				.numberType(CommonInputNumberDialog.NUMBER_TYPE_INTEGER)
				.positiveListener(new CommonInputNumberDialog.NumberDialogListener() {
					@Override
					public void onResult(double fvalue) {
						final_product.amount = (int)fvalue;
						adapter.notifyDataSetChanged();
					}
				})
				.build();
		dialog.show();
	}


	private void onClickedShopCart() {
		if (getSelectedProducts().size() == 0) {
			ToastUtility.showToast(HuoDongJiPinGouMaiActivity.this, "请首先选择产品");
			return;
		}

		CommonDateTimePickerDialog dialog = new CommonDateTimePickerDialog(HuoDongJiPinGouMaiActivity.this);
		dialog.setPickerType(CommonDateTimePickerDialog.PICKER_TYPE_DATEHOUR);
		dialog.setTime(new Date());
		dialog.setDelegate(new CommonDateTimePickerDialog.DateTimeSelectDelegate() {
			@Override
			public void onDateSelected(String szDate, Date dtVal) {
				onSelectedDate(szDate);
			}
		});
		dialog.show();
	}


	private void onSelectedDate(String date) {
		ArrayList<STProduct> arrSelectedProducts = getSelectedProducts();
		JSONArray arrProducts = new JSONArray();
		for (int i = 0; i < arrSelectedProducts.size(); i++) {
			arrProducts.put(arrSelectedProducts.get(i).encodeToJSON());
		}

		Bundle bundle = new Bundle();
		bundle.putLong(QueRenZhiFuActivity.EXTRA_CUSTOMER_ID, -1);
		bundle.putString(QueRenZhiFuActivity.EXTRA_RESERVE_TIME, date);
		bundle.putLong(QueRenZhiFuActivity.EXTRA_SERVICE_ID, -1);
		bundle.putString(QueRenZhiFuActivity.EXTRA_SERVICE_NAME, "");
		bundle.putDouble(QueRenZhiFuActivity.EXTRA_SERVICE_PRICE, 0);
		bundle.putString(QueRenZhiFuActivity.EXTRA_PRODUCTS, arrProducts.toString());

		pushNewActivityAnimated(QueRenZhiFuActivity.class, bundle);
	}


	private ArrayList<STProduct> getSelectedProducts() {
		ArrayList<STProduct> arrSelectedProducts = new ArrayList<STProduct>();

		for (int i = 0; i < arrProducts.size(); i++) {
			if (arrProducts.get(i).amount == 0)
				continue;
			arrSelectedProducts.add(arrProducts.get(i));
		}

		return arrSelectedProducts;
	}

}


