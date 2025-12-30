package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 15:10
 * File Name : ShouHouFuWu_JiBaiYongPinTabFrame
 */
public class ShouHouFuWu_JiBaiYongPinTabFrame extends SuperTabActivity.TabFrame {
	private boolean isInit = false;

	private ImageButton btnFlowers = null;
	private ImageButton btnBurials = null;
	private ImageButton btnMeals = null;
	private ImageButton btnOthers = null;

	private ImageView imgFlowers = null;
	private ImageView imgBurials = null;
	private ImageView imgMeals = null;
	private ImageView imgOthers = null;

	private ListView listFlowers = null, listBurials = null, listMeal = null, listOthers = null;
	private FuneralProductAdapter flowerAdapter = null, burialAdapter = null, mealAdapter = null, otherAdapter = null;

	private ArrayList<STProduct> arrFlowers = new ArrayList<STProduct>();
	private ArrayList<STProduct> arrBurials = new ArrayList<STProduct>();
	private ArrayList<STProduct> arrMeals = new ArrayList<STProduct>();
	private ArrayList<STProduct> arrOthers = new ArrayList<STProduct>();

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_shouhoufuwu_jibaiyongpin_tab, container, false);

		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {

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

		flowerAdapter = new FuneralProductAdapter(parentActivity, FuneralProductAdapter.LIST_FLOWERS, arrFlowers);
		burialAdapter = new FuneralProductAdapter(parentActivity, FuneralProductAdapter.LIST_BURIALS, arrBurials);
		mealAdapter = new FuneralProductAdapter(parentActivity, FuneralProductAdapter.LIST_MEALS, arrMeals);
		otherAdapter = new FuneralProductAdapter(parentActivity, FuneralProductAdapter.LIST_OTHERS, arrOthers);

		listFlowers.setAdapter(flowerAdapter);
		listBurials.setAdapter(burialAdapter);
		listMeal.setAdapter(mealAdapter);
		listOthers.setAdapter(otherAdapter);
	}


	@Override
	public void onResume() {
		super.onResume();

		if (!isInit) {
			startProgress();
			CommManager.getFuneralProducts(funeral_product_delegate);
		}
	}

	public class ViewHolder {
		public TextView txt_title = null;
		public ImageView img_contents = null;
	}



	public class FuneralProductAdapter extends ArrayAdapter<STProduct> {

		public static final int LIST_FLOWERS = 0;
		public static final int LIST_BURIALS = 1;
		public static final int LIST_MEALS = 2;
		public static final int LIST_OTHERS = 3;

		private int type = LIST_FLOWERS;

		public FuneralProductAdapter(Context context, int type, List<STProduct> objects) {
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

			ViewHolder holder = null;

			if (convertView == null) {
				View item_view = parentActivity.getLayoutInflater().inflate(R.layout.item_jipin_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, parentActivity.screen_size.x, parentActivity.screen_size.y);

				holder = new ViewHolder();
				holder.txt_title = (TextView)item_view.findViewById(R.id.txt_title);
				holder.img_contents = (ImageView)item_view.findViewById(R.id.img_contents);

				item_view.setTag(holder);

				convertView = item_view;
			} else {
				holder = (ViewHolder)convertView.getTag();
			}

			holder.txt_title.setText(item_info.title);
			BitmapUtility.setImageWithImageLoader(holder.img_contents, item_info.image_url, parentActivity.loader_options);

			return convertView;
		}
	}


	private CommDelegate funeral_product_delegate = new CommDelegate() {
		@Override
		public void getFuneralProductsResult(int retcode, String retmsg, ArrayList<STProduct> arrFuneralProducts) {
			super.getFuneralProductsResult(retcode, retmsg, arrFuneralProducts);
			stopProgress();


			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrFuneralProducts.size(); i++) {
					STProduct product = arrFuneralProducts.get(i);
					if (product.type == FuneralProductAdapter.LIST_FLOWERS)
						arrFlowers.add(product);
					else if (product.type == FuneralProductAdapter.LIST_BURIALS)
						arrBurials.add(product);
					else if (product.type == FuneralProductAdapter.LIST_MEALS)
						arrMeals.add(product);
					else if (product.type == FuneralProductAdapter.LIST_OTHERS)
						arrOthers.add(product);
				}

				flowerAdapter.notifyDataSetChanged();
				burialAdapter.notifyDataSetChanged();
				mealAdapter.notifyDataSetChanged();
				otherAdapter.notifyDataSetChanged();
				isInit = true;
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};

}
