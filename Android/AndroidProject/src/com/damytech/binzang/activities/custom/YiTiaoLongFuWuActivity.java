package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STDragonService;
import com.damytech.structure.custom.STDragonServiceArea;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;


import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:03
 * File Name : YiTiaoLongFuWuActivity
 */
public class YiTiaoLongFuWuActivity extends SuperActivity {
	public static final String EXTRA_AREA_ID = "area_id";

	private long area_id = 0;

	private ListView mAreaLstView = null;
	private TextView mNameTxtView = null;
	AreaItemAdapter adapter = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yitiaolongfuwu);
	}


	@Override
	protected void initializeActivity() {
		area_id = getIntent().getLongExtra(EXTRA_AREA_ID, 0);

		mAreaLstView = (ListView)findViewById(R.id.list_service_items);
		mNameTxtView = (TextView)findViewById(R.id.txt_area_name);

		loadAreaData(area_id);
	}


	public void loadAreaData(long uid) {
		startProgress();
		CommManager.getOneDragonAreaDetail(uid, one_dragon_areadetail_delegate);
	}


	private CommDelegate one_dragon_areadetail_delegate = new CommDelegate() {
		@Override
		public void getOneDragonAreaDetailResult(int retcode, String retmsg, STDragonServiceArea area_info) {
			super.getOneDragonAreaDetailResult(retcode, retmsg, area_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setAreaData(area_info);
			} else {
				ToastUtility.showToast(YiTiaoLongFuWuActivity.this, retmsg);
			}
		}
	};

	private void setAreaData(STDragonServiceArea data) {
		mNameTxtView.setText(data.name);
		mNameTxtView.setTag(data.uid);

		adapter = new AreaItemAdapter(this, 0, data.services);
		mAreaLstView.setAdapter(adapter);

		if(data.services == null || data.services.size() <= 0) {
			ToastUtility.showToast(YiTiaoLongFuWuActivity.this, "本区域还没有提供一条龙服务的合作公司！");
		}
	}

	public class AreaItemAdapter extends ArrayAdapter<STDragonService>
	{
		Context ctx;
		ArrayList<STDragonService> list = new ArrayList<STDragonService>();

		public AreaItemAdapter(Context ctx, int resourceId, ArrayList<STDragonService> list) {
			super(ctx, resourceId, list);
			this.ctx = ctx;
			this.list = list;
		}

		@Override
		public int getCount() {
			return list.size();
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STDragonService info = list.get(position);
			STAreaItemViewHolder holder = null;

			if (convertView == null) {
				LayoutInflater inflater = (LayoutInflater)ctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

				View item_view = inflater.inflate(R.layout.item_yitiaolong_citydetail_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new STAreaItemViewHolder();

				holder.txtNo = (TextView)item_view.findViewById(R.id.txt_areano);
				holder.txtName = (TextView)item_view.findViewById(R.id.txt_areaname);
				holder.txtContents = (TextView)item_view.findViewById(R.id.txt_contents);
				holder.txtPrice = (TextView)item_view.findViewById(R.id.txt_date);
				holder.txtUserAgreeRate = (TextView)item_view.findViewById(R.id.txt_user_agree_rate);
				holder.imageArea = (ImageView)item_view.findViewById(R.id.image_area);

				holder.btnServiceSel = (ImageButton)item_view.findViewById(R.id.btn_servicesel);
				holder.btnServiceSel.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onSelectService((Long)v.getTag());
					}
				});

				item_view.setTag(holder);

				convertView = item_view;
			} else {
				holder = (STAreaItemViewHolder)convertView.getTag();
			}

			holder.txtNo.setText(Long.toString(position + 1));
			holder.txtName.setText(info.name);
			holder.txtContents.setText(info.intro);
			holder.txtPrice.setText(info.price_desc);
			holder.txtUserAgreeRate.setText(Integer.toString(info.user_agree_rate));
			BitmapUtility.setImageWithImageLoader(holder.imageArea, info.image_url, loader_options);

			holder.btnServiceSel.setTag(info.uid);

			return convertView;
		}

		private void onSelectService(Long  id)
		{
			Bundle bundle = new Bundle();
			bundle.putLong(YiTiaoLongFuWuGongSiXiangQingActivity.EXTRA_SERVICE_ID, id);

			pushNewActivityAnimated(YiTiaoLongFuWuGongSiXiangQingActivity.class, bundle);
		}

		private class STAreaItemViewHolder {
			TextView txtNo = null;
			TextView txtName = null;
			TextView txtContents = null;
			TextView txtPrice = null;
			TextView txtUserAgreeRate = null;
			ImageView imageArea = null;
			ImageButton btnServiceSel = null;
		}
	}
}
