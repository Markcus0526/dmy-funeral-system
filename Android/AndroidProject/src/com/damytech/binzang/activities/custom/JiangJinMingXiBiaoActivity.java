package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-19
 * Time : 11:43
 * File Name : JiangJinMingXiBiaoActivity
 */
public class JiangJinMingXiBiaoActivity extends SuperTabActivity {
	//private int page_no = 0;
	//private PullToRefreshListView pullList = null;
	//private PullAdpater pullAdapter = null;
	//private ArrayList<STBonusLog> arrBonusLogs = new ArrayList<STBonusLog>();

	private ArrayList<Fragment> arrFragments = new ArrayList<Fragment>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_jiangjinmingxibiao);
	}


	@Override
	protected void initializeActivity() {
		/*
		pullAdapter = new PullAdpater(this, arrBonusLogs);
		pullList = (PullToRefreshListView)findViewById(R.id.list_view);
		{
			pullList.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			pullList.setOnRefreshListener(pullListRefreshListener);
			pullList.setAdapter(pullAdapter);
			pullList.getRefreshableView().setDivider(new ColorDrawable(Color.TRANSPARENT));
			pullList.getRefreshableView().setCacheColorHint(Color.parseColor("#FFF1F1F1"));
		}

		startProgress();
		getItemsFromService();
		*/
		arrFragments.add(new JiangJinMingXiBiao_MudiTabFrame());
		arrFragments.add(new JiangJinMingXiBiao_JipinTabFrame());

		initTabContent(R.id.tab_content_layout, R.id.tab_selector_layout, arrFragments);
	}


	/*
	private PullToRefreshBase.OnRefreshListener pullListRefreshListener = new PullToRefreshBase.OnRefreshListener() {
		@Override
		public void onRefresh(PullToRefreshBase refreshView) {
			getItemsFromService();
		}
	};


	private void getItemsFromService() {
		page_no = arrBonusLogs.size() / AppCommon.getPageItemCount();
		CommManager.getBonusDetailList(AppCommon.loadUserIDLong(getApplicationContext()),
				page_no,
				list_delegate);
	}


	public class STViewHolder
	{
		TextView txtName = null;
		TextView txtNum = null;
		TextView txtTime = null;
		TextView txtPrice = null;
	}


	private class PullAdpater extends ArrayAdapter<STBonusLog> {
		public PullAdpater(Context context, List<STBonusLog> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STBonusLog item_info = arrBonusLogs.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_jiangjinmingxi_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, screen_size.x, screen_size.y);

				viewHolder = new STViewHolder();
				viewHolder.txtName = (TextView)itemView.findViewById(R.id.txt_name);
				viewHolder.txtNum = (TextView)itemView.findViewById(R.id.txt_no);
				viewHolder.txtTime = (TextView)itemView.findViewById(R.id.txt_time);
				viewHolder.txtPrice = (TextView)itemView.findViewById(R.id.txt_date);

				itemView.setTag(viewHolder);
				convertView = itemView;
			} else {
				viewHolder = (STViewHolder) convertView.getTag();
			}

			viewHolder.txtName.setText(item_info.user_name);
			viewHolder.txtNum.setText(item_info.tomb_no);
			viewHolder.txtTime.setText(item_info.buy_time);
			viewHolder.txtPrice.setText(item_info.bonus_desc);

			return convertView;
		}
	}


	private CommDelegate list_delegate = new CommDelegate() {
		@Override
		public void getBonusDetailListResult(int retcode, String retmsg, ArrayList<STBonusLog> arrLogs) {
			super.getBonusDetailListResult(retcode, retmsg, arrLogs);
			stopProgress();
			pullList.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrLogs.size(); i++) {
					STBonusLog item = arrLogs.get(i);

					boolean isExist = false;
					for (int j = 0; j < arrBonusLogs.size(); j++) {
						STBonusLog orgItem = arrBonusLogs.get(j);
						if (orgItem.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						arrBonusLogs.add(item);
				}

				pullAdapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(JiangJinMingXiBiaoActivity.this, retmsg);
			}
		}
	};
	*/

}
