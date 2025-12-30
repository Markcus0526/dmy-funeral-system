package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STAgent;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 16:28
 * File Name : DaiXiaoRenYuanActivity
 */
public class DaiXiaoRenYuanActivity extends SuperActivity {
	private ArrayList<STAgent> agent_list = new ArrayList<STAgent>();
	private ListView list_agents = null;
	private DataAdapter adapter = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_daixiaorenyuan);
	}


	@Override
	protected void initializeActivity() {
		adapter = new DataAdapter(DaiXiaoRenYuanActivity.this, agent_list);

		list_agents = (ListView)findViewById(R.id.agent_list);
		list_agents.setAdapter(adapter);

		startProgress();
		CommManager.getAgents(AppCommon.loadUserIDLong(getApplicationContext()),
				list_handler);
	}


	private CommDelegate list_handler = new CommDelegate() {
		@Override
		public void getAgentsResult(int retcode, String retmsg, ArrayList<STAgent> arrAgents) {
			super.getAgentsResult(retcode, retmsg, arrAgents);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				agent_list.clear();
				agent_list.addAll(arrAgents);

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(DaiXiaoRenYuanActivity.this, retmsg);
			}
		}
	};


	public class STViewHolder {
		public TextView txtName = null;
		public TextView txtPhone = null;
		public TextView txtMonth = null;
		public TextView txtHalfYear = null;
		public TextView txtYear = null;
	}


	public class DataAdapter extends ArrayAdapter<STAgent> {
		public DataAdapter(Context context, List<STAgent> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STAgent item_info = agent_list.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_daixiaorenyuan_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtName = (TextView)item_view.findViewById(R.id.txt_name);
				holder.txtPhone = (TextView)item_view.findViewById(R.id.txt_phone);
				holder.txtMonth = (TextView)item_view.findViewById(R.id.txt_monthscore);
				holder.txtHalfYear = (TextView)item_view.findViewById(R.id.txt_halfyearscore);
				holder.txtYear = (TextView)item_view.findViewById(R.id.txt_yearscore);

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtName.setText(item_info.name);
			holder.txtPhone.setText(item_info.phone);
			holder.txtMonth.setText(item_info.month_score_desc);
			holder.txtHalfYear.setText(item_info.halfyear_score_desc);
			holder.txtYear.setText(item_info.year_score_desc);

			return convertView;
		}
	};

}
