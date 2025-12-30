package com.damytech.binzang.activities.custom;

import android.content.Context;
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
import com.damytech.structure.custom.STRelative;
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
public class QinRenShuJuChaXunActivity extends SuperActivity {
	private ListView list_view = null;
	private DataAdapter adapter = null;

	private ArrayList<STRelative> arrRelatives = new ArrayList<STRelative>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_qinrenshujuchaxun);
	}


	@Override
	protected void initializeActivity() {
		adapter = new DataAdapter(QinRenShuJuChaXunActivity.this, arrRelatives);
		list_view = (ListView)findViewById(R.id.list_relatives);
		list_view.setAdapter(adapter);

		startProgress();
		CommManager.getRelativeData(AppCommon.loadUserIDLong(getApplicationContext()), list_handler);
	}


	public class STViewHolder {
		public TextView txtName = null;
		public TextView txtArea = null;
		public TextView txtBirthday = null;
		public TextView txtDeathday = null;
	}


	public class DataAdapter extends ArrayAdapter<STRelative> {
		public DataAdapter(Context context, List<STRelative> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STRelative item_info = arrRelatives.get(position);
			STViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_qinrenshuju_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtName = (TextView)item_view.findViewById(R.id.txt_name);
				holder.txtArea = (TextView)item_view.findViewById(R.id.txt_area);
				holder.txtBirthday = (TextView)item_view.findViewById(R.id.txt_birthday);
				holder.txtDeathday = (TextView)item_view.findViewById(R.id.txt_deathday);

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}

			holder.txtName.setText(item_info.relative+ " : " + item_info.name);
			holder.txtArea.setText(item_info.area_no);
			holder.txtBirthday.setText(item_info.birthday);
			holder.txtDeathday.setText(item_info.deathday);

			return convertView;
		}
	};


	private CommDelegate list_handler = new CommDelegate() {
		@Override
		public void getRelativeDataResult(int retcode, String retmsg, ArrayList<STRelative> arrRelatives) {
			super.getRelativeDataResult(retcode, retmsg, arrRelatives);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				QinRenShuJuChaXunActivity.this.arrRelatives.clear();
				QinRenShuJuChaXunActivity.this.arrRelatives.addAll(arrRelatives);
				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(QinRenShuJuChaXunActivity.this, retmsg);
			}
		}
	};
}
