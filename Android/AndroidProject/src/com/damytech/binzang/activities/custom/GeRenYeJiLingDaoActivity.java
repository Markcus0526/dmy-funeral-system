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
 * File Name : GeRenYeJiLingDaoActivity
 */
public class GeRenYeJiLingDaoActivity extends SuperActivity {
	private int page_no = 0;
	private PullToRefreshListView pullList = null;
	private PullAdpater pullAdapter = null;
	private ArrayList<STPersonalScore_Boss> arrPersonalScores = new ArrayList<STPersonalScore_Boss>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_gerenyeji_lingdao);
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
		CommManager.getEmployeePersonalScore(AppCommon.loadUserIDLong(getApplicationContext()),
				page_no,
				scores_delegate);
	}


	private CommDelegate scores_delegate = new CommDelegate() {
		@Override
		public void getEmployeePersonalScoreResult(int retcode, String retmsg, ArrayList<STPersonalScore_Boss> arrScores) {
			super.getEmployeePersonalScoreResult(retcode, retmsg, arrScores);
			stopProgress();
			pullList.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrScores.size(); i++) {
					STPersonalScore_Boss item = arrScores.get(i);

					boolean isExist = false;
					for (int j = 0; j < arrPersonalScores.size(); j++) {
						STPersonalScore_Boss orgItem = arrPersonalScores.get(j);
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
				ToastUtility.showToast(GeRenYeJiLingDaoActivity.this, retmsg);
			}
		}
	};


	public class STViewHolder
	{
		TextView txtOffice = null;
		TextView txtName = null;
		TextView txtScore = null;
	}

	private class PullAdpater extends ArrayAdapter<STPersonalScore_Boss> {
		public PullAdpater(Context context, List<STPersonalScore_Boss> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STPersonalScore_Boss item_info = arrPersonalScores.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_gerenyeji_lingdao_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, screen_size.x, screen_size.y);

				viewHolder = new STViewHolder();
				viewHolder.txtOffice = (TextView)itemView.findViewById(R.id.lbl_office);
				viewHolder.txtName = (TextView)itemView.findViewById(R.id.lbl_name);
				viewHolder.txtScore = (TextView)itemView.findViewById(R.id.lbl_score);

				itemView.setTag(viewHolder);
				convertView = itemView;
			} else {
				viewHolder = (STViewHolder) convertView.getTag();
			}

			viewHolder.txtName.setText(item_info.user_name);
			viewHolder.txtOffice.setText(item_info.office_name);
			viewHolder.txtScore.setText(StringUtility.formatDouble(item_info.score));

			return convertView;
		}
	}



}
