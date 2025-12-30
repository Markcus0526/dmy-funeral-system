package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.structure.custom.STDepositLog;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-19
 * Time : 17:00
 * File Name : DingJinDanChaXunActivity
 */
public class DingJinDanChaXunDaiXiaoShangActivity extends SuperActivity {
	private int page_no = 0;
	private PullToRefreshListView pullList = null;
	private PullAdpater pullAdapter = null;
	private ArrayList<STDepositLog> arrLogs = new ArrayList<STDepositLog>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_dingjindanchaxun_daixiaoshang);
	}


	@Override
	protected void initializeActivity() {
		pullAdapter = new PullAdpater(this, arrLogs);
		pullList = (PullToRefreshListView)findViewById(R.id.list_deposits);
		{
			pullList.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			pullList.setOnRefreshListener(pullListRefreshListener);
			pullList.setAdapter(pullAdapter);
			pullList.getRefreshableView().setDivider(new ColorDrawable(Color.TRANSPARENT));
			pullList.getRefreshableView().setCacheColorHint(Color.parseColor("#FFF1F1F1"));
		}


		startProgress();
		getItemsFromService();
	}


	private PullToRefreshBase.OnRefreshListener pullListRefreshListener = new PullToRefreshBase.OnRefreshListener() {
		@Override
		public void onRefresh(PullToRefreshBase refreshView) {
			getItemsFromService();
		}
	};


	private void getItemsFromService() {
		page_no = arrLogs.size() / AppCommon.getPageItemCount();
		CommManager.getDepositLogs(AppCommon.loadUserIDLong(getApplicationContext()),
				AppCommon.loadUserIDLong(getApplicationContext()),
				page_no,
				list_delegate);
	}


	public class STViewHolder
	{
		TextView txtStartTime = null;
		TextView txtEndTime = null;
		TextView txtUserName = null;
		TextView txtTombNo = null;
		TextView txtReceiver = null;
		TextView txtPrice = null;
	}


	private class PullAdpater extends ArrayAdapter<STDepositLog> {
		public PullAdpater(Context context, List<STDepositLog> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STDepositLog item_info = arrLogs.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_dingjindan_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, screen_size.x, screen_size.y);

				viewHolder = new STViewHolder();
				viewHolder.txtStartTime = (TextView)itemView.findViewById(R.id.txt_start_time);
				viewHolder.txtEndTime = (TextView)itemView.findViewById(R.id.txt_end_time);
				viewHolder.txtUserName = (TextView)itemView.findViewById(R.id.txt_user_name);
				viewHolder.txtTombNo = (TextView)itemView.findViewById(R.id.txt_tomb_no);
				viewHolder.txtReceiver = (TextView)itemView.findViewById(R.id.txt_receiver);
				viewHolder.txtPrice = (TextView)itemView.findViewById(R.id.txt_date);

				itemView.setTag(viewHolder);
				convertView = itemView;
			} else {
				viewHolder = (STViewHolder) convertView.getTag();
			}

			viewHolder.txtStartTime.setText(item_info.start_time);
			viewHolder.txtEndTime.setText(item_info.end_time);
			viewHolder.txtUserName.setText(item_info.name);
			viewHolder.txtTombNo.setText(item_info.tomb_no);
			viewHolder.txtReceiver.setText(item_info.receiver);
			viewHolder.txtPrice.setText(item_info.price_desc);

			return convertView;
		}
	}


	private CommDelegate list_delegate = new CommDelegate() {
		@Override
		public void getDepositLogsResult(int retcode, String retmsg, ArrayList<STDepositLog> arrLogs) {
			super.getDepositLogsResult(retcode, retmsg, arrLogs);
			stopProgress();
			pullList.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrLogs.size(); i++) {
					STDepositLog item = arrLogs.get(i);

					boolean isExist = false;
					for (int j = 0; j < DingJinDanChaXunDaiXiaoShangActivity.this.arrLogs.size(); j++) {
						STDepositLog orgItem = DingJinDanChaXunDaiXiaoShangActivity.this.arrLogs.get(j);
						if (orgItem.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						DingJinDanChaXunDaiXiaoShangActivity.this.arrLogs.add(item);

					pullAdapter.notifyDataSetChanged();
				}
			} else {
				ToastUtility.showToast(DingJinDanChaXunDaiXiaoShangActivity.this, retmsg);
			}
		}
	};


}
