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
import com.damytech.structure.custom.STAgentScore_Mgr;
import com.damytech.structure.custom.STDailyScore;
import com.damytech.structure.custom.STPersonalScore_Boss;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.StringUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 16:20
 * File Name : DaiXiaoYeJiZhuRenActivity
 */
public class DaiXiaoYeJiZhuRenActivity extends SuperActivity {
	private int page_no = 0;
	private PullToRefreshListView pullList = null;
	private PullAdpater pullAdapter = null;
	private ArrayList<STAgentScore_Mgr> arrPersonalScores = new ArrayList<STAgentScore_Mgr>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_daixiaoyeji_zhuren);
	}


	@Override
	protected void initializeActivity() {
		pullAdapter = new PullAdpater(this, arrPersonalScores);
		pullList = (PullToRefreshListView)findViewById(R.id.list_view);
		{
			pullList.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			pullList.setOnRefreshListener(pullListRefreshListener);
			pullList.setAdapter(pullAdapter);
			pullList.getRefreshableView().setDivider(new ColorDrawable(Color.parseColor("#00000000")));
			pullList.getRefreshableView().setDividerHeight(2);
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
		page_no = arrPersonalScores.size() / AppCommon.getPageItemCount();
		CommManager.getAgentPersonalScoreMgr(AppCommon.loadUserIDLong(getApplicationContext()),
				page_no,
				scores_delegate);
	}


	private CommDelegate scores_delegate = new CommDelegate() {
		@Override
		public void getAgentPersonalScoreMgrResult(int retcode, String retmsg, ArrayList<STAgentScore_Mgr> arrScores) {
			super.getAgentPersonalScoreMgrResult(retcode, retmsg, arrScores);
			stopProgress();
			pullList.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrScores.size(); i++) {
					STAgentScore_Mgr item = arrScores.get(i);

					boolean isExist = false;
					for (int j = 0; j < arrPersonalScores.size(); j++) {
						STAgentScore_Mgr orgItem = arrPersonalScores.get(j);
						if (orgItem.user_id == item.user_id) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						arrPersonalScores.add(item);
				}

				pullAdapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(DaiXiaoYeJiZhuRenActivity.this, retmsg);
			}
		}
	};


	public class STViewHolder
	{
		TextView txtName = null;
		TextView txtScore = null;
	}

	private class PullAdpater extends ArrayAdapter<STAgentScore_Mgr> {
		public PullAdpater(Context context, List<STAgentScore_Mgr> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STAgentScore_Mgr item_info = arrPersonalScores.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_daixiaodanriyeji_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, screen_size.x, screen_size.y);

				viewHolder = new STViewHolder();
				viewHolder.txtName = (TextView)itemView.findViewById(R.id.lbl_item1);
				viewHolder.txtScore = (TextView)itemView.findViewById(R.id.lbl_item2);

				itemView.setTag(viewHolder);
				convertView = itemView;
			} else {
				viewHolder = (STViewHolder) convertView.getTag();
			}

			viewHolder.txtName.setText(item_info.user_name);
			viewHolder.txtScore.setText(StringUtility.formatDouble(item_info.score));

			return convertView;
		}
	}



}
