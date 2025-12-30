package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STOfficeCity;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;
import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:00
 * File Name : BanShiChuJieShaoActivity
 */
public class BanShiChuChengShiActivity extends SuperActivity {
	private ListView listCities = null;
	private OfficeAdapter listAdapter = null;

	private ArrayList<STOfficeCity> mArrCities = new ArrayList<STOfficeCity>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_banshichu_chengshi);
	}

	@Override
	protected void initializeActivity()
	{
		listCities = (ListView) findViewById(R.id.listView);
		listAdapter = new OfficeAdapter(BanShiChuChengShiActivity.this, mArrCities);
		listCities.setAdapter(listAdapter);

		// get office list
		startProgress();
		CommManager.getOfficeIntros(office_intro_delegate);
	}


	/**
	 * get office intro list delegate
	 */
	private CommDelegate office_intro_delegate = new CommDelegate() {
		@Override
		public void getOfficeIntrosResult(int retcode, String retmsg, ArrayList<STOfficeCity> arrCities)
		{
			super.getOfficeIntrosResult(retcode, retmsg, arrCities);

			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				mArrCities = arrCities;
				updateUI();
			} else {
				ToastUtility.showToast(BanShiChuChengShiActivity.this, retmsg);
			}
		}
	};

	/**
	 * update ui by detail info
	 */
	private void updateUI()
	{
		listAdapter.clear();
		listAdapter.addAll(mArrCities);
		listAdapter.notifyDataSetChanged();
	}


	public class ViewHolder
	{
		public TextView txtItem = null;
		public ImageButton btnItem = null;
	}

	public class OfficeAdapter extends ArrayAdapter<STOfficeCity> {
		public OfficeAdapter(Context context, List<STOfficeCity> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STOfficeCity item = mArrCities.get(position);
			ViewHolder holder = null;

			if (convertView == null) {
				RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_banshichu_chengshi_layout, null);
				ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

				holder = new ViewHolder();

				holder.txtItem = (TextView)item_layout.findViewById(R.id.txt_city);
				holder.btnItem = (ImageButton)item_layout.findViewById(R.id.btn_item);
				holder.btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						STOfficeCity office_city = (STOfficeCity)v.getTag();
						onItemSelected(office_city);
					}
				});

				item_layout.setTag(holder);

				convertView = item_layout;
			} else {
				holder = (ViewHolder)convertView.getTag();
			}

			holder.txtItem.setText(item.name);
			holder.btnItem.setTag(item);

			return convertView;
		}
	}


	private void onItemSelected(STOfficeCity office_city) {
		JSONArray arrOffices = new JSONArray();
		for (int i = 0; i < office_city.offices.size(); i++) {
			arrOffices.put(office_city.offices.get(i).encodeToJSON());
		}

		Bundle bundle = new Bundle();
		bundle.putString(BanShiChuJieShaoActivity.EXTRA_OFFICES, arrOffices.toString());

		pushNewActivityAnimated(BanShiChuJieShaoActivity.class, bundle);
	}

}
