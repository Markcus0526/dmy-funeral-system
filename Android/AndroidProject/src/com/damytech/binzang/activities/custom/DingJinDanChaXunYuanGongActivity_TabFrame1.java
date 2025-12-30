package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
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
 * Date : 2015-04-21
 * Time : 17:24
 * File Name : DingJinDanChaXunYuanGong_TabFrame1
 */
public class DingJinDanChaXunYuanGongActivity_TabFrame1 extends SuperTabActivity.TabFrame {
	private int page_no = 0;
	private PullToRefreshListView pullList = null;
	private PullAdpater pullAdapter = null;
	private ArrayList<STDepositLog> arrDepositLogs = new ArrayList<STDepositLog>();

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_dingjindanchaxun_yuangong_tab1, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		pullAdapter = new PullAdpater(parentView.getContext(), arrDepositLogs);
		pullList = (PullToRefreshListView)parentView.findViewById(R.id.list_view);
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
		DingJinDanChaXunYuanGongActivity dingjinActivity = (DingJinDanChaXunYuanGongActivity)parentActivity;

		page_no = arrDepositLogs.size() / AppCommon.getPageItemCount();
		CommManager.getDepositLogs(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
				dingjinActivity.aim_user_id,
				page_no,
				list_delegate);
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
					for (int j = 0; j < arrDepositLogs.size(); j++) {
						STDepositLog orgItem = arrDepositLogs.get(j);
						if (orgItem.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						arrDepositLogs.add(item);

					pullAdapter.notifyDataSetChanged();
				}
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};


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
			STDepositLog item_info = arrDepositLogs.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout)parentActivity.getLayoutInflater().inflate(R.layout.item_dingjindan_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, parentActivity.screen_size.x, parentActivity.screen_size.y);

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

}
