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
import com.damytech.structure.custom.STOfficeDepositLog;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.StringUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 18:00
 * File Name : DingJinDanChaXunLingDaoActivity
 */
public class DingJinDanChaXunLingDaoActivity extends SuperActivity {
	private int page_no = 0;
	private PullToRefreshListView pullList = null;
	private PullAdpater pullAdapter = null;
	private ArrayList<STOfficeDepositLog> arrDepositLogs = new ArrayList<STOfficeDepositLog>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_dingjindanchaxun_lingdao);
	}


	@Override
	protected void initializeActivity() {
		pullAdapter = new PullAdpater(this, arrDepositLogs);
		pullList = (PullToRefreshListView)findViewById(R.id.list_view);
		{
			pullList.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			pullList.setOnRefreshListener(pullListRefreshListener);
			pullList.setAdapter(pullAdapter);
			pullList.getRefreshableView().setDivider(new ColorDrawable(Color.parseColor("#FF303030")));
			pullList.getRefreshableView().setDividerHeight(1);
			pullList.getRefreshableView().setCacheColorHint(Color.parseColor("#00000000"));
		}

		startProgress();
		getPagedItems();
	}




	private PullToRefreshBase.OnRefreshListener pullListRefreshListener = new PullToRefreshBase.OnRefreshListener() {
		@Override
		public void onRefresh(PullToRefreshBase refreshView) {
			getPagedItems();
		}
	};


	private void getPagedItems() {
		page_no = arrDepositLogs.size() / AppCommon.getPageItemCount();
		CommManager.getOfficesDepositLogs(AppCommon.loadUserIDLong(getApplicationContext()),
				page_no,
				deposits_delegate);
	}


	private CommDelegate deposits_delegate = new CommDelegate() {
		@Override
		public void getOfficesDepositLogsResult(int retcode, String retmsg, ArrayList<STOfficeDepositLog> arrLogs) {
			super.getOfficesDepositLogsResult(retcode, retmsg, arrLogs);
			stopProgress();
			pullList.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrLogs.size(); i++) {
					STOfficeDepositLog item = arrLogs.get(i);

					arrDepositLogs.add(item);
				}

				pullAdapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(DingJinDanChaXunLingDaoActivity.this, retmsg);
			}
		}
	};


	public class STViewHolder
	{
		TextView txtOffice = null;
		TextView txtEmp = null;
		TextView txtAgent = null;
		TextView txtTotal = null;
	}

	private class PullAdpater extends ArrayAdapter<STOfficeDepositLog> {
		public PullAdpater(Context context, List<STOfficeDepositLog> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STOfficeDepositLog item_info = arrDepositLogs.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_dingjindan_lingdao_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, screen_size.x, screen_size.y);

				viewHolder = new STViewHolder();
				viewHolder.txtOffice = (TextView)itemView.findViewById(R.id.txt_office);
				viewHolder.txtEmp= (TextView)itemView.findViewById(R.id.txt_emp);
				viewHolder.txtAgent = (TextView)itemView.findViewById(R.id.txt_agent);
				viewHolder.txtTotal = (TextView)itemView.findViewById(R.id.txt_total);

				itemView.setTag(viewHolder);
				convertView = itemView;
			} else {
				viewHolder = (STViewHolder) convertView.getTag();
			}

			viewHolder.txtOffice.setText(item_info.office_name);
			viewHolder.txtEmp.setText("￥" + StringUtility.formatDouble(item_info.employee));
			viewHolder.txtAgent.setText("￥" + StringUtility.formatDouble(item_info.agent));
			viewHolder.txtTotal.setText("￥" + StringUtility.formatDouble(item_info.total));

			return convertView;
		}
	}



}
