package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
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
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.structure.custom.STDeputyLog;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 00:08
 * File Name : LingDaoShouYeActivity
 */
public class DaiJiBaiHuiHanActivity extends SuperActivity {
	private PullToRefreshListView list_view = null;
	private DataAdapter adapter = null;

	private ArrayList<STDeputyLog> arrLogs = new ArrayList<STDeputyLog>();
	private int page_no = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_daijibaihuihan);
	}


	@Override
	protected void initializeActivity() {
		adapter = new DataAdapter(DaiJiBaiHuiHanActivity.this, arrLogs);
		list_view = (PullToRefreshListView)findViewById(R.id.list_view);
		{
			list_view.setShowDividers(LinearLayout.SHOW_DIVIDER_END);
			list_view.setDividerDrawable(new ColorDrawable(Color.parseColor("#505050")));
			list_view.getRefreshableView().setCacheColorHint(Color.WHITE);
			list_view.setOnRefreshListener(refresh_listener);
			list_view.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			list_view.setAdapter(adapter);
		}

		startProgress();
		getDataFromService();
	}


	private void getDataFromService() {
		page_no = arrLogs.size() / AppCommon.getPageItemCount();
		CommManager.getDeputyLogs(AppCommon.loadUserIDLong(getApplicationContext()), page_no, list_handler);
	}


	private PullToRefreshBase.OnRefreshListener refresh_listener = new PullToRefreshBase.OnRefreshListener() {
		@Override
		public void onRefresh(PullToRefreshBase refreshView) {
			getDataFromService();
		}
	};



	public class STViewHolder {
		public TextView txtTime = null;
		public ImageView imgMain = null;
		public ImageButton btnItem = null;
	}


	public class DataAdapter extends ArrayAdapter<STDeputyLog> {
		public DataAdapter(Context context, List<STDeputyLog> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STDeputyLog item_info = arrLogs.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_daijibaihuihan_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtTime = (TextView)item_view.findViewById(R.id.txt_time);
				holder.imgMain = (ImageView)item_view.findViewById(R.id.img_main);
				holder.btnItem = (ImageButton)item_view.findViewById(R.id.btn_item);
				holder.btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemSelected((STDeputyLog)v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtTime.setText(item_info.time);
			BitmapUtility.setImageWithImageLoader(holder.imgMain, item_info.image_url, loader_options);
			holder.btnItem.setTag(item_info);

			return convertView;
		}
	};



	private void onItemSelected(STDeputyLog log_info) {
		Bundle bundle = new Bundle();
		bundle.putLong(DaiJiBaiXiangQingActivity.EXTRA_LOG_ID, log_info.uid);

		pushNewActivityAnimated(DaiJiBaiXiangQingActivity.class, bundle);
	}



	private CommDelegate list_handler = new CommDelegate() {
		@Override
		public void getDeputyLogsResult(int retcode, String retmsg, ArrayList<STDeputyLog> arrDeputyLogs) {
			super.getDeputyLogsResult(retcode, retmsg, arrDeputyLogs);
			stopProgress();
			list_view.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrDeputyLogs.size(); i++) {
					STDeputyLog item = arrDeputyLogs.get(i);

					boolean isExist = false;
					for (int j = 0; j < arrLogs.size(); j++) {
						STDeputyLog orgInfo = arrLogs.get(j);
						if (orgInfo.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						arrLogs.add(item);
				}

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(DaiJiBaiHuiHanActivity.this, retmsg);
			}
		}
	};
}
