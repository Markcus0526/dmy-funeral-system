package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.structure.custom.STBuyProductLog;
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
public class ZiYouKeHuShangPinDingGouActivity_TabFrame1 extends SuperTabActivity.TabFrame {
	private int page_no = 0;
	private PullToRefreshListView pullList = null;
	private PullAdpater pullAdapter = null;
	private ArrayList<STBuyProductLog> buyProductLogs = new ArrayList<STBuyProductLog>();


	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_ziyoukehushangpindinggou_tab1, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		pullAdapter = new PullAdpater(parentView.getContext(), buyProductLogs);
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
		page_no = buyProductLogs.size() / AppCommon.getPageItemCount();
		CommManager.getBuyProductLogs(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
				page_no,
				ConstMgr.BUY_PRODUCT_LOG_TYPE_WAITING,
				list_delegate);
	}


	private CommDelegate list_delegate = new CommDelegate() {
		@Override
		public void getBuyProductLogsResult(int retcode, String retmsg, ArrayList<STBuyProductLog> arrLogs) {
			super.getBuyProductLogsResult(retcode, retmsg, arrLogs);
			stopProgress();
			pullList.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrLogs.size(); i++) {
					STBuyProductLog item = arrLogs.get(i);

					boolean isExist = false;
					for (int j = 0; j < buyProductLogs.size(); j++) {
						STBuyProductLog orgItem = buyProductLogs.get(j);
						if (orgItem.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						buyProductLogs.add(item);

					pullAdapter.notifyDataSetChanged();
				}
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};


	public class STViewHolder
	{
		TextView txtCustomer = null;
		TextView txtReserveDate = null;
		ImageView imgNew = null;
		ImageButton btnItem = null;
	}


	private class PullAdpater extends ArrayAdapter<STBuyProductLog> {
		public PullAdpater(Context context, List<STBuyProductLog> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STBuyProductLog item_info = buyProductLogs.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout)parentActivity.getLayoutInflater().inflate(R.layout.item_ziyoukehushangpindinggou_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, parentActivity.screen_size.x, parentActivity.screen_size.y);

				viewHolder = new STViewHolder();
				viewHolder.txtCustomer = (TextView)itemView.findViewById(R.id.txt_name);
				viewHolder.txtReserveDate = (TextView)itemView.findViewById(R.id.txt_time);
				viewHolder.imgNew = (ImageView)itemView.findViewById(R.id.img_new);
				viewHolder.btnItem = (ImageButton)itemView.findViewById(R.id.btn_item);
				viewHolder.btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemSelected((STBuyProductLog)v.getTag());
					}
				});

				itemView.setTag(viewHolder);
				convertView = itemView;
			} else {
				viewHolder = (STViewHolder) convertView.getTag();
			}

			viewHolder.txtCustomer.setText(item_info.customer);
			viewHolder.txtReserveDate.setText(item_info.reserve_date);
			viewHolder.btnItem.setTag(item_info);
			if (item_info.is_read == 1) {
				viewHolder.imgNew.setVisibility(View.INVISIBLE);
			} else {
				viewHolder.imgNew.setVisibility(View.VISIBLE);
			}

			return convertView;
		}
	}



	private void onItemSelected(STBuyProductLog log) {
		Bundle bundle = new Bundle();
		bundle.putLong(ZiYouKeHuShangPinDingGouXiangXiActivity.EXTRA_LOG_ID, log.uid);

		parentActivity.pushNewActivityAnimated(ZiYouKeHuShangPinDingGouXiangXiActivity.class, bundle, ZiYouKeHuShangPinDingGouActivity.REQCODE_WAITING_DETAIL);
	}


	public void updateReadMark(long uid) {
		for (int i = 0; i < buyProductLogs.size(); i++) {
			STBuyProductLog log_info = buyProductLogs.get(i);
			if (log_info.uid == uid) {
				log_info.is_read = 1;
				pullAdapter.notifyDataSetChanged();
				break;
			}
		}
	}
}
