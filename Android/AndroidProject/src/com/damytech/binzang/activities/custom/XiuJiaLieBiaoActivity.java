package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.misc.ConstMgr;
import com.damytech.structure.custom.STVocation;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 23:53
 * File Name : XiuJiaLieBiaoActivity
 */
public class XiuJiaLieBiaoActivity extends SuperActivity {
	public ArrayList<STVocation> arrVocations = new ArrayList<STVocation>();

	private ListView list_view = null;
	private DataAdapter adapter = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_xiujialiebiao);
	}


	@Override
	protected void initializeActivity() {
		adapter = new DataAdapter(XiuJiaLieBiaoActivity.this, arrVocations);
		list_view = (ListView)findViewById(R.id.list_vocations);
		list_view.setAdapter(adapter);

		startProgress();
		CommManager.getVocationDates(AppCommon.loadUserIDLong(getApplicationContext()),
				comm_delegate);
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getVocationDatesResult(int retcode, String retmsg, ArrayList<STVocation> arrVocations) {
			super.getVocationDatesResult(retcode, retmsg, arrVocations);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				XiuJiaLieBiaoActivity.this.arrVocations.clear();
				for (int i = 0; i < arrVocations.size(); i++) {
					STVocation vocation = arrVocations.get(i);
					if (vocation.state == ConstMgr.VOCATION_STATE_CANCELLED)
						continue;
					XiuJiaLieBiaoActivity.this.arrVocations.add(vocation);
				}

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(XiuJiaLieBiaoActivity.this, retmsg);
			}
		}


		@Override
		public void cancelVocationResult(int retcode, String retmsg, long cancelled_id) {
			super.cancelVocationResult(retcode, retmsg, cancelled_id);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrVocations.size(); i++) {
					STVocation vocation = arrVocations.get(i);
					if (vocation.uid == cancelled_id) {
						arrVocations.remove(i);
						adapter.notifyDataSetChanged();
						break;
					}
				}
			} else {
				ToastUtility.showToast(XiuJiaLieBiaoActivity.this, retmsg);
			}
		}
	};


	public class STViewHolder {
		public TextView txtDate = null;
		public TextView txtReason = null;
		public Button btnCancel = null;
	}


	public class DataAdapter extends ArrayAdapter<STVocation> {
		public DataAdapter(Context context, List<STVocation> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STVocation item_info = arrVocations.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_xiujia_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtDate = (TextView)item_view.findViewById(R.id.txt_date);
				holder.txtReason = (TextView)item_view.findViewById(R.id.txt_type);
				holder.btnCancel = (Button)item_view.findViewById(R.id.btn_cancel);
				holder.btnCancel.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onClickedCancel((STVocation)v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtDate.setText(item_info.date);
			holder.txtReason.setText(item_info.reason_desc);
			holder.btnCancel.setTag(item_info);

			return convertView;
		}
	}


	private void onClickedCancel(STVocation vocation) {
		startProgress();
		CommManager.cancelVocation(AppCommon.loadUserIDLong(getApplicationContext()),
				vocation.uid,
				comm_delegate);
	}

}
















