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
import com.damytech.structure.custom.STVocation;
import com.damytech.utils.ResolutionUtility;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-22
 * Time : 23:02
 * File Name : ChuQinZhuangTaiActivity
 */
public class ChuQinZhuangTaiActivity extends SuperActivity {
	public static final String EXTRA_VOCATIONS = "vocations";
	public static final String EXTRA_DESC = "activity_desc";

	private ListView list_view = null;
	private DataAdapter adapter = null;

	private ArrayList<STVocation> arrVocations = new ArrayList<STVocation>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_chuqinzhuangtai);
	}


	@Override
	protected void initializeActivity() {
		adapter = new DataAdapter(ChuQinZhuangTaiActivity.this, arrVocations);
		list_view = (ListView)findViewById(R.id.list_items);
		list_view.setAdapter(adapter);

		String szData = getIntent().getStringExtra(EXTRA_VOCATIONS);
		try {
			JSONArray arrJSONVocations = new JSONArray(szData);
			for (int i = 0; i < arrJSONVocations.length(); i++) {
				JSONObject jsonObj = arrJSONVocations.getJSONObject(i);
				STVocation vocation = STVocation.decodeFromJSON(jsonObj);
				arrVocations.add(vocation);
			}

			adapter.notifyDataSetChanged();
		} catch (Exception ex) {
			ex.printStackTrace();
		}


		TextView txtDesc = (TextView)findViewById(R.id.txt_desc);
		txtDesc.setText(getIntent().getStringExtra(EXTRA_DESC));
	}


	public class STViewHolder {
		public TextView txtNo = null;
		public TextView txtName = null;
		public TextView txtDesc = null;
		public TextView txtReason = null;
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
				View item_view = getLayoutInflater().inflate(R.layout.item_chuqinzhuangtai_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STViewHolder();

				holder.txtNo = (TextView)item_view.findViewById(R.id.txt_no);
				holder.txtName = (TextView)item_view.findViewById(R.id.txt_name);
				holder.txtDesc = (TextView)item_view.findViewById(R.id.txt_desc);
				holder.txtReason = (TextView)item_view.findViewById(R.id.txt_reason);

				item_view.setTag(holder);
				convertView = item_view;
			} else {
				holder = (STViewHolder)convertView.getTag();
			}


			holder.txtNo.setText("" + (position + 1) + ". ");
			holder.txtDesc.setText(item_info.user_desc + "：");
			holder.txtName.setText(item_info.user_name);
			holder.txtReason.setText(item_info.reason_desc);


			return convertView;
		}
	};

}
















