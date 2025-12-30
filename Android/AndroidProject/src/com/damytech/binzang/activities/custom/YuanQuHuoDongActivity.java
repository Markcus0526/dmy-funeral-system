package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STActivity;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-15
 * Time : 14:18
 * File Name : YuanQuHuoDongActivity
 */
public class YuanQuHuoDongActivity extends SuperActivity {
	private final int REQ_CODE_DETAIL = 1;

	public static final String EXTRA_SHOPCART = "shop_cart";
	private boolean has_shopcart = false;

	private ListView list_activities = null;
	private DataAdapter adapter = null;

	private ArrayList<STActivity> arrActivities = new ArrayList<STActivity>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yuanquhuodong);
	}


	@Override
	protected void initializeActivity() {
		has_shopcart = getIntent().getBooleanExtra(EXTRA_SHOPCART, false);

		adapter = new DataAdapter(YuanQuHuoDongActivity.this, arrActivities);
		list_activities = (ListView)findViewById(R.id.list_activities);
		list_activities.setAdapter(adapter);

		startProgress();
		CommManager.getActivities(AppCommon.loadUserIDLong(getApplicationContext()), activities_handler);
	}


	public class STViewHolder {
		public TextView txtTitle = null;
		public TextView txtTime = null;
		public ImageView imgNew = null;
		public ImageButton btnItem = null;
	}


	public class DataAdapter extends ArrayAdapter<STActivity> {
		public DataAdapter(Context context, List<STActivity> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STActivity activity = arrActivities.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_yuanquhuodong_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtTitle = (TextView)item_view.findViewById(R.id.txt_title);
				holder.txtTime = (TextView)item_view.findViewById(R.id.txt_time);
				holder.imgNew = (ImageView)item_view.findViewById(R.id.img_new);
				holder.btnItem = (ImageButton)item_view.findViewById(R.id.btn_item);
				holder.btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemSelected((STActivity)v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtTitle.setText(activity.activity_type + " : " + activity.title);
			holder.txtTime.setText(activity.act_time);
			if (activity.is_read == 1)
				holder.imgNew.setVisibility(View.INVISIBLE);
			else
				holder.imgNew.setVisibility(View.VISIBLE);
			holder.btnItem.setTag(activity);

			return convertView;
		}
	};


	private CommDelegate activities_handler = new CommDelegate() {
		@Override
		public void getActivitiesResult(int retcode, String retmsg, ArrayList<STActivity> arrActivities) {
			super.getActivitiesResult(retcode, retmsg, arrActivities);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				YuanQuHuoDongActivity.this.arrActivities.clear();
				YuanQuHuoDongActivity.this.arrActivities.addAll(arrActivities);
				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(YuanQuHuoDongActivity.this, retmsg);
			}
		}
	};


	private void onItemSelected(STActivity activity) {
		Bundle bundle = new Bundle();
		bundle.putLong(YuanQuHuoDongXiangQingActivity.EXTRA_ACTIVITY_ID, activity.uid);
		bundle.putBoolean(YuanQuHuoDongXiangQingActivity.EXTRA_SHOPCART, has_shopcart);

		pushNewActivityAnimated(YuanQuHuoDongXiangQingActivity.class, bundle, REQ_CODE_DETAIL);
	}


	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);

		if (resultCode != RESULT_OK)
			return;

		if (requestCode == REQ_CODE_DETAIL) {
			long act_id = data.getLongExtra(YuanQuHuoDongXiangQingActivity.EXTRA_ACTIVITY_ID, 0);
			for (int i = 0; i < arrActivities.size(); i++) {
				STActivity activity = arrActivities.get(i);
				if (activity.uid == act_id) {
					activity.is_read = 1;
					adapter.notifyDataSetChanged();
				}
			}
		}
	}
}
