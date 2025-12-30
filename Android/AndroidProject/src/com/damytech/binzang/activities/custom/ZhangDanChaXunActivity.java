package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.structure.custom.STBill;
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
public class ZhangDanChaXunActivity extends SuperActivity {
	private PullToRefreshListView list_view = null;
	private DataAdapter adapter = null;

	private ArrayList<STBill> arrBills = new ArrayList<STBill>();
	private int page_no = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_zhangdanchaxun);
	}


	@Override
	protected void initializeActivity() {
		adapter = new DataAdapter(ZhangDanChaXunActivity.this, arrBills);
		list_view = (PullToRefreshListView)findViewById(R.id.list_bills);
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
		page_no = arrBills.size() / AppCommon.getPageItemCount();
		CommManager.getBills(AppCommon.loadUserIDLong(getApplicationContext()), page_no, list_handler);
	}


	private PullToRefreshBase.OnRefreshListener refresh_listener = new PullToRefreshBase.OnRefreshListener() {
		@Override
		public void onRefresh(PullToRefreshBase refreshView) {
			getDataFromService();
		}
	};



	public class STViewHolder {
		public TextView txtTime = null;
		public TextView txtName = null;
		public TextView txtPrice = null;
		public ImageButton btnItem = null;
	}


	public class DataAdapter extends ArrayAdapter<STBill> {
		public DataAdapter(Context context, List<STBill> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STBill item_info = arrBills.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_zhangdan_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtName = (TextView)item_view.findViewById(R.id.txt_user_name);
				holder.txtTime = (TextView)item_view.findViewById(R.id.txt_buy_time);
				holder.txtPrice = (TextView)item_view.findViewById(R.id.txt_date);
				holder.btnItem = (ImageButton)item_view.findViewById(R.id.btn_item);
				holder.btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemSelected((STBill)v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtName.setText(item_info.name);
			holder.txtTime.setText(item_info.buy_time);
			holder.txtPrice.setText(item_info.total_amount_desc);
			holder.btnItem.setTag(item_info);

			return convertView;
		}
	};



	private void onItemSelected(STBill bill_info) {
		Bundle bundle = new Bundle();
		bundle.putLong(ZhangDanXiangQingActivity.EXTRA_BILL_ID, bill_info.uid);

		pushNewActivityAnimated(ZhangDanXiangQingActivity.class, bundle);
	}



	private CommDelegate list_handler = new CommDelegate() {
		@Override
		public void getBillsResult(int retcode, String retmsg, ArrayList<STBill> arrBills) {
			super.getBillsResult(retcode, retmsg, arrBills);
			stopProgress();
			list_view.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrBills.size(); i++) {
					STBill item = arrBills.get(i);

					boolean isExist = false;
					for (int j = 0; j < ZhangDanChaXunActivity.this.arrBills.size(); j++) {
						STBill orgInfo = ZhangDanChaXunActivity.this.arrBills.get(j);
						if (orgInfo.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						ZhangDanChaXunActivity.this.arrBills.add(item);
				}

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(ZhangDanChaXunActivity.this, retmsg);
			}
		}
	};
}
