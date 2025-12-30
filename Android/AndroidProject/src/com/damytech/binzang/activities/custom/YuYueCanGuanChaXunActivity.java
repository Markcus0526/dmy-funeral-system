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
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.structure.custom.STReserveLog;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 00:08
 * File Name : YuYueCanGuanChaXunActivity
 */
public class YuYueCanGuanChaXunActivity extends SuperActivity {
	private int page_no = 0;
	private PullToRefreshListView list_view = null;
	private DataAdapter adapter = null;

	private ArrayList<STReserveLog> arrReserveLogs = new ArrayList<STReserveLog>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yuyuecanguanchaxun);
	}


	@Override
	protected void initializeActivity() {
		adapter = new DataAdapter(YuYueCanGuanChaXunActivity.this, arrReserveLogs);
		list_view = (PullToRefreshListView)findViewById(R.id.list_view);
		{
			list_view.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			list_view.setOnRefreshListener(pullListRefreshListener);
			list_view.setAdapter(adapter);
			list_view.getRefreshableView().setDivider(new ColorDrawable(Color.parseColor("#00000000")));
			list_view.getRefreshableView().setDividerHeight(2);
			list_view.getRefreshableView().setCacheColorHint(Color.parseColor("#FFF1F1F1"));
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
		page_no = arrReserveLogs.size() / AppCommon.getPageItemCount();
		CommManager.getReserveLogs(AppCommon.loadUserIDLong(getApplicationContext()),
				page_no,
				comm_delegate);
	}


	public class STViewHolder {
		public TextView txtName = null;
		public TextView txtPhone = null;
		public TextView txtDate = null;
		public TextView txtState = null;
		public Button btnConfirm = null;
		public Button btnCancel = null;
	}


	public class DataAdapter extends ArrayAdapter<STReserveLog> {
		public DataAdapter(Context context, List<STReserveLog> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STReserveLog item_info = arrReserveLogs.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_yuyuecanguan_jilu_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtName = (TextView)item_view.findViewById(R.id.txt_name);
				holder.txtPhone = (TextView)item_view.findViewById(R.id.txt_phone);
				holder.txtDate = (TextView)item_view.findViewById(R.id.txt_date);
				holder.txtState = (TextView)item_view.findViewById(R.id.txt_state);

				holder.btnCancel = (Button)item_view.findViewById(R.id.btn_cancel);
				holder.btnConfirm = (Button)item_view.findViewById(R.id.btn_confirm);

				holder.btnCancel.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onClickedCancel((STReserveLog)v.getTag());
					}
				});
				holder.btnConfirm.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onClickedConfirm((STReserveLog) v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtName.setText(item_info.customer_name);
			holder.txtPhone.setText(item_info.customer_phone);
			holder.txtDate.setText(item_info.reserve_date);
			holder.txtState.setText(item_info.state_desc);
			holder.btnCancel.setTag(item_info);
			holder.btnConfirm.setTag(item_info);


			if (item_info.state == ConstMgr.RESERVE_STATE_WAIT) {
				holder.btnCancel.setVisibility(View.VISIBLE);
				holder.btnConfirm.setVisibility(View.VISIBLE);
			} else {
				holder.btnCancel.setVisibility(View.GONE);
				holder.btnConfirm.setVisibility(View.GONE);
			}

			return convertView;
		}
	};



	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getReserveLogsResult(int retcode, String retmsg, ArrayList<STReserveLog> arrLogs) {
			super.getReserveLogsResult(retcode, retmsg, arrLogs);
			stopProgress();
			list_view.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrLogs.size(); i++) {
					STReserveLog item = arrLogs.get(i);

					boolean isExist = false;
					for (int j = 0; j < arrReserveLogs.size(); j++) {
						STReserveLog old_item = arrReserveLogs.get(j);
						if (old_item.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						arrReserveLogs.add(item);
				}

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(YuYueCanGuanChaXunActivity.this, retmsg);
			}
		}


		@Override
		public void cancelReserveResult(int retcode, String retmsg, long cancelled_id) {
			super.cancelReserveResult(retcode, retmsg, cancelled_id);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrReserveLogs.size(); i++) {
					STReserveLog log = arrReserveLogs.get(i);
					if (log.uid == cancelled_id) {
						log.state = ConstMgr.RESERVE_STATE_CANCELLED;
						log.state_desc = ConstMgr.getReserveVisitStateDesc(log.state);
						adapter.notifyDataSetChanged();
						break;
					}
				}
			} else {
				ToastUtility.showToast(YuYueCanGuanChaXunActivity.this, retmsg);
			}
		}


		@Override
		public void confirmReserveResult(int retcode, String retmsg, long confirmed_id) {
			super.confirmReserveResult(retcode, retmsg, confirmed_id);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrReserveLogs.size(); i++) {
					STReserveLog log = arrReserveLogs.get(i);
					if (log.uid == confirmed_id) {
						log.state = ConstMgr.RESERVE_STATE_CONFIRMED;
						log.state_desc = ConstMgr.getReserveVisitStateDesc(log.state);
						adapter.notifyDataSetChanged();
						break;
					}
				}
			} else {
				ToastUtility.showToast(YuYueCanGuanChaXunActivity.this, retmsg);
			}
		}
	};


	private void onClickedCancel(final STReserveLog log) {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(YuYueCanGuanChaXunActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("您确定要取消该参观申请吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						cancelLog(log);
					}
				}).build();
		dialog.show();
	}


	private void onClickedConfirm(final STReserveLog log) {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(YuYueCanGuanChaXunActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("您确定要确认该参观申请吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						confirmLog(log);
					}
				}).build();
		dialog.show();
	}


	private void cancelLog(STReserveLog log) {
		startProgress();
		CommManager.cancelReserve(AppCommon.loadUserIDLong(getApplicationContext()),
				log.uid,
				comm_delegate);
	}


	private void confirmLog(STReserveLog log) {
		startProgress();
		CommManager.confirmReserve(AppCommon.loadUserIDLong(getApplicationContext()),
				log.uid,
				comm_delegate);
	}
}
