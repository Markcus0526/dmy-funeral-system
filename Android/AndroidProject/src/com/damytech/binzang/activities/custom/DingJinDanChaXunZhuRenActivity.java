package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.activities.preset.SuperScrollActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STEmployee;
import com.damytech.structure.custom.STOffice;
import com.damytech.structure.custom.STRelative;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 23:18
 * File Name : DingJinDanChaXunZhuRenActivity
 */
public class DingJinDanChaXunZhuRenActivity extends SuperActivity {
	private ListView listView = null;
	private DataAdapter adapter = null;

	private STOffice office_detail = new STOffice();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_dingjindanchaxun_zhuren);
	}


	@Override
	protected void initializeActivity() {
		long office_id = AppCommon.loadOfficeID(getApplicationContext());

		listView = (ListView)findViewById(R.id.list_view);

		startProgress();
		CommManager.getOfficeDetail(office_id, detail_delegate);
	}


	private CommDelegate detail_delegate = new CommDelegate() {
		@Override
		public void getOfficeDetailResult(int retcode, String retmsg, STOffice office_info) {
			super.getOfficeDetailResult(retcode, retmsg, office_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				office_detail = office_info;

				adapter = new DataAdapter(DingJinDanChaXunZhuRenActivity.this, office_detail.employees);
				listView.setAdapter(adapter);
				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(DingJinDanChaXunZhuRenActivity.this, retmsg);
			}
		}
	};



	public class STViewHolder {
		public TextView txtName = null;
		public ImageButton btnItem = null;
	}


	public class DataAdapter extends ArrayAdapter<STEmployee> {
		public DataAdapter(Context context, List<STEmployee> objects) {
			super(context, 0, objects);
		}


		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STEmployee item_info = office_detail.employees.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_dingjindan_zhuren_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtName = (TextView)item_view.findViewById(R.id.txt_name);
				holder.btnItem = (ImageButton)item_view.findViewById(R.id.btn_item);
				holder.btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemSelected((STEmployee)v.getTag());
					}
				});

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtName.setText(item_info.name);
			holder.btnItem.setTag(item_info);

			return convertView;
		}
	};


	private void onItemSelected(STEmployee employee) {
		Bundle bundle = new Bundle();
		bundle.putString(DingJinDanChaXunYuanGongActivity.EXTRA_TITLE, "订金单查询");
		bundle.putLong(DingJinDanChaXunYuanGongActivity.EXTRA_AIM_USER_ID, employee.uid);
		bundle.putBoolean(DingJinDanChaXunYuanGongActivity.EXTRA_BONUS_LOG, false);

		pushNewActivityAnimated(DingJinDanChaXunYuanGongActivity.class, bundle);
	}


}
