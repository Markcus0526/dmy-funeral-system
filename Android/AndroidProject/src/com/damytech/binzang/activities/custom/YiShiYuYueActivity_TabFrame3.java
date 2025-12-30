package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.binzang.dialogs.preset.CommonInputNumberDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;
import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 10:19
 * File Name : LuoZangYiShiYuYueActivity_TabFrame3
 */
public class YiShiYuYueActivity_TabFrame3 extends SuperTabActivity.TabFrame {
	private Button btnNext = null, btnPrev = null;

	private RelativeLayout rlXianHua = null;
	private RelativeLayout rlSuiZangPin = null;
	private RelativeLayout rlGongFan = null;
	private RelativeLayout rlQiTa = null;

	private ImageButton btnFlowers = null;
	private ImageButton btnBurials = null;
	private ImageButton btnMeals = null;
	private ImageButton btnOthers = null;

	private ImageView imgFlowers = null;
	private ImageView imgBurials = null;
	private ImageView imgMeals = null;
	private ImageView imgOthers = null;

	private ListView listFlowers = null, listBurials = null, listMeal = null, listOthers = null;
	private DataAdapter flowerAdapter = null, burialAdapter = null, mealAdapter = null, otherAdapter = null;

	private ArrayList<STProduct> arrFlowers = new ArrayList<STProduct>();
	private ArrayList<STProduct> arrBurials = new ArrayList<STProduct>();
	private ArrayList<STProduct> arrMeals = new ArrayList<STProduct>();
	private ArrayList<STProduct> arrOthers = new ArrayList<STProduct>();


	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_yishiyuyue_tab3, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		rlXianHua = (RelativeLayout)parentView.findViewById(R.id.rlXianHua);
		rlSuiZangPin = (RelativeLayout)parentView.findViewById(R.id.rlSuiZangPin);
		rlGongFan = (RelativeLayout)parentView.findViewById(R.id.rlGongFan);
		rlQiTa = (RelativeLayout)parentView.findViewById(R.id.rlQiTa);

		YiShiYuYueActivity yishiActivity = (YiShiYuYueActivity)parentActivity;
		if(yishiActivity.need_bury_service)
			rlSuiZangPin.setVisibility(View.VISIBLE);
		else
			rlSuiZangPin.setVisibility(View.GONE);

		btnFlowers = (ImageButton)parentView.findViewById(R.id.btn_flowers);
		btnBurials = (ImageButton)parentView.findViewById(R.id.btn_burials);
		btnMeals = (ImageButton)parentView.findViewById(R.id.btn_meal);
		btnOthers = (ImageButton)parentView.findViewById(R.id.btn_others);

		imgFlowers = (ImageView)parentView.findViewById(R.id.img_flower);
		imgBurials = (ImageView)parentView.findViewById(R.id.img_burial);
		imgMeals = (ImageView)parentView.findViewById(R.id.img_meal);
		imgOthers = (ImageView)parentView.findViewById(R.id.img_others);

		btnFlowers.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				imgFlowers.setImageResource(R.drawable.bk_radio_sel);
				imgBurials.setImageResource(R.drawable.bk_radio_normal);
				imgMeals.setImageResource(R.drawable.bk_radio_normal);
				imgOthers.setImageResource(R.drawable.bk_radio_normal);

				listFlowers.setVisibility(View.VISIBLE);
				listBurials.setVisibility(View.INVISIBLE);
				listMeal.setVisibility(View.INVISIBLE);
				listOthers.setVisibility(View.INVISIBLE);
			}
		});
		btnBurials.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				imgFlowers.setImageResource(R.drawable.bk_radio_normal);
				imgBurials.setImageResource(R.drawable.bk_radio_sel);
				imgMeals.setImageResource(R.drawable.bk_radio_normal);
				imgOthers.setImageResource(R.drawable.bk_radio_normal);

				listFlowers.setVisibility(View.INVISIBLE);
				listBurials.setVisibility(View.VISIBLE);
				listMeal.setVisibility(View.INVISIBLE);
				listOthers.setVisibility(View.INVISIBLE);
			}
		});
		btnMeals.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				imgFlowers.setImageResource(R.drawable.bk_radio_normal);
				imgBurials.setImageResource(R.drawable.bk_radio_normal);
				imgMeals.setImageResource(R.drawable.bk_radio_sel);
				imgOthers.setImageResource(R.drawable.bk_radio_normal);

				listFlowers.setVisibility(View.INVISIBLE);
				listBurials.setVisibility(View.INVISIBLE);
				listMeal.setVisibility(View.VISIBLE);
				listOthers.setVisibility(View.INVISIBLE);
			}
		});
		btnOthers.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				imgFlowers.setImageResource(R.drawable.bk_radio_normal);
				imgBurials.setImageResource(R.drawable.bk_radio_normal);
				imgMeals.setImageResource(R.drawable.bk_radio_normal);
				imgOthers.setImageResource(R.drawable.bk_radio_sel);

				listFlowers.setVisibility(View.INVISIBLE);
				listBurials.setVisibility(View.INVISIBLE);
				listMeal.setVisibility(View.INVISIBLE);
				listOthers.setVisibility(View.VISIBLE);
			}
		});


		listFlowers = (ListView)parentView.findViewById(R.id.list_flowers);
		listBurials = (ListView)parentView.findViewById(R.id.list_burials);
		listMeal = (ListView)parentView.findViewById(R.id.list_meal);
		listOthers = (ListView)parentView.findViewById(R.id.list_others);

		flowerAdapter = new DataAdapter(parentActivity, DataAdapter.LIST_FLOWERS, arrFlowers);
		burialAdapter = new DataAdapter(parentActivity, DataAdapter.LIST_BURIALS, arrBurials);
		mealAdapter = new DataAdapter(parentActivity, DataAdapter.LIST_MEALS, arrMeals);
		otherAdapter = new DataAdapter(parentActivity, DataAdapter.LIST_OTHERS, arrOthers);

		listFlowers.setAdapter(flowerAdapter);
		listBurials.setAdapter(burialAdapter);
		listMeal.setAdapter(mealAdapter);
		listOthers.setAdapter(otherAdapter);

		btnPrev = (Button)parentView.findViewById(R.id.btn_prev);
		btnPrev.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPrev();
			}
		});
		btnNext = (Button)parentView.findViewById(R.id.btn_next);
		btnNext.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedNext();
			}
		});

		startProgress();
		CommManager.getFuneralProducts(list_handler);
	}


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
		public static final int LIST_FLOWERS = 0;
		public static final int LIST_BURIALS = 1;
		public static final int LIST_MEALS = 2;
		public static final int LIST_OTHERS = 3;

		private int type = LIST_FLOWERS;

		public DataAdapter(Context context, int type, List<STProduct> objects) {
			super(context, 0, objects);
			this.type = type;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STProduct item_info = null;
			if (type == LIST_FLOWERS)
				item_info = arrFlowers.get(position);
			else if (type == LIST_BURIALS)
				item_info = arrBurials.get(position);
			else if (type == LIST_MEALS)
				item_info = arrMeals.get(position);
			else if (type == LIST_OTHERS)
				item_info = arrOthers.get(position);

			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = parentActivity.getLayoutInflater().inflate(R.layout.item_chanpin_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, parentActivity.screen_size.x, parentActivity.screen_size.y);

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
			BitmapUtility.setImageWithImageLoader(holder.imgProduct, item_info.image_url, parentActivity.loader_options);
			holder.txtPrice.setText(item_info.price_desc);
			holder.txtCount.setText("" + item_info.amount);
			holder.btnCount.setTag(holder);
			holder.btnMinus.setTag(holder);
			holder.btnPlus.setTag(holder);

			return convertView;
		}
	};


	private CommDelegate list_handler = new CommDelegate() {
		@Override
		public void getFuneralProductsResult(int retcode, String retmsg, ArrayList<STProduct> arrProducts) {
			super.getFuneralProductsResult(retcode, retmsg, arrProducts);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrProducts.size(); i++) {
					STProduct product = arrProducts.get(i);
					if (product.type == DataAdapter.LIST_FLOWERS)
						arrFlowers.add(product);
					else if (product.type == DataAdapter.LIST_BURIALS)
						arrBurials.add(product);
					else if (product.type == DataAdapter.LIST_MEALS)
						arrMeals.add(product);
					else if (product.type == DataAdapter.LIST_OTHERS)
						arrOthers.add(product);
				}

				flowerAdapter.notifyDataSetChanged();
				burialAdapter.notifyDataSetChanged();
				mealAdapter.notifyDataSetChanged();
				otherAdapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};


	private STProduct getProductFromID(long uid) {
		STProduct product = null;
		for (int i = 0; i < arrFlowers.size(); i++) {
			if (arrFlowers.get(i).uid == uid) {
				product = arrFlowers.get(i);
				break;
			}
		}

		if (product == null) {
			for (int i = 0; i < arrBurials.size(); i++) {
				if (arrBurials.get(i).uid == uid) {
					product = arrBurials.get(i);
					break;
				}
			}
		}

		if (product == null) {
			for (int i = 0; i < arrMeals.size(); i++) {
				if (arrMeals.get(i).uid == uid) {
					product = arrMeals.get(i);
					break;
				}
			}
		}

		if (product == null) {
			for (int i = 0; i < arrOthers.size(); i++) {
				if (arrOthers.get(i).uid == uid) {
					product = arrOthers.get(i);
					break;
				}
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

		CommonInputNumberDialog dialog = new CommonInputNumberDialog.Builder(parentActivity)
				.defaultValue(product.amount)
				.numberType(CommonInputNumberDialog.NUMBER_TYPE_INTEGER)
				.positiveListener(new CommonInputNumberDialog.NumberDialogListener() {
					@Override
					public void onResult(double fvalue) {
						final_product.amount = (int)fvalue;

						if (final_product.type == DataAdapter.LIST_FLOWERS) {
							flowerAdapter.notifyDataSetChanged();
						} else if (final_product.type == DataAdapter.LIST_BURIALS) {
							burialAdapter.notifyDataSetChanged();
						} else if (final_product.type == DataAdapter.LIST_MEALS) {
							mealAdapter.notifyDataSetChanged();
						} else if (final_product.type == DataAdapter.LIST_OTHERS) {
							otherAdapter.notifyDataSetChanged();
						}
					}
				})
				.build();
		dialog.show();
	}


	private void onClickedNext() {
		YiShiYuYueActivity luozangActivity = (YiShiYuYueActivity)parentActivity;
		luozangActivity.arrSelectedProducts.clear();

		for (int i = 0; i < arrFlowers.size(); i++) {
			STProduct product = arrFlowers.get(i);
			if (product.amount == 0)
				continue;
			luozangActivity.arrSelectedProducts.add(product);
		}

		for (int i = 0; i < arrBurials.size(); i++) {
			STProduct product = arrBurials.get(i);
			if (product.amount == 0)
				continue;
			luozangActivity.arrSelectedProducts.add(product);
		}

		for (int i = 0; i < arrMeals.size(); i++) {
			STProduct product = arrMeals.get(i);
			if (product.amount == 0)
				continue;
			luozangActivity.arrSelectedProducts.add(product);
		}

		for (int i = 0; i < arrOthers.size(); i++) {
			STProduct product = arrOthers.get(i);
			if (product.amount == 0)
				continue;
			luozangActivity.arrSelectedProducts.add(product);
		}

		if (luozangActivity.arrSelectedProducts.size() == 0) {
			CommonAlertDialog dialog = new CommonAlertDialog.Builder(parentActivity)
					.message("您没有选择祭拜产品，确定下一步吗？")
					.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
					.positiveListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							onClickedConfirm();
						}
					})
					.build();
			dialog.show();
		} else {
			onClickedConfirm();
		}
	}


	private void onClickedPrev() {
		parentActivity.tab_adapter.changeTab(1);
	}


	private void onClickedConfirm() {
		YiShiYuYueActivity luozangActivity = (YiShiYuYueActivity)parentActivity;

		long service_id = 0;
		if (luozangActivity.need_bury_service) {
			if (luozangActivity.buryService != null)
				service_id = luozangActivity.buryService.uid;
		} else {
			service_id = -1;
		}

		JSONArray arrProducts = new JSONArray();
		for (int i = 0; i < luozangActivity.arrSelectedProducts.size(); i++) {
			arrProducts.put(luozangActivity.arrSelectedProducts.get(i).encodeToJSON());
		}

		Bundle bundle = new Bundle();
		bundle.putLong(QueRenZhiFuActivity.EXTRA_CUSTOMER_ID, luozangActivity.customer_id);
		bundle.putString(QueRenZhiFuActivity.EXTRA_RESERVE_TIME, luozangActivity.sel_time);
		bundle.putLong(QueRenZhiFuActivity.EXTRA_SERVICE_ID, service_id);
		bundle.putString(QueRenZhiFuActivity.EXTRA_SERVICE_NAME, luozangActivity.buryService == null ? "" : luozangActivity.buryService.title);
		bundle.putDouble(QueRenZhiFuActivity.EXTRA_SERVICE_PRICE, luozangActivity.buryService == null ? 0 : luozangActivity.buryService.price);
		bundle.putString(QueRenZhiFuActivity.EXTRA_PRODUCTS, arrProducts.toString());
		bundle.putLong(QueRenZhiFuActivity.EXTRA_TOMB_ID, luozangActivity.tomb_id);
		bundle.putLong(QueRenZhiFuActivity.EXTRA_IS_DEPUTYSERVICE, luozangActivity.tomb_id);

		luozangActivity.pushNewActivityAnimated(QueRenZhiFuActivity.class, bundle);
		luozangActivity.popOverCurActivityNonAnimated();
	}
}
