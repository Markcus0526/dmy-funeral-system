package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.structure.custom.STOffice;
import com.damytech.utils.AppUtility;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;
import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:00
 * File Name : BanShiChuJieShaoActivity
 */
public class BanShiChuJieShaoActivity extends SuperActivity {
	public static final String EXTRA_OFFICES = "office_array";

	private ListView listOffice = null;
	private OfficeAdapter listAdapter = null;

	private ArrayList<STOffice> mArrOffices = new ArrayList<STOffice>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_banshichujieshao);
	}

	@Override
	protected void initializeActivity()
	{
		listOffice = (ListView) findViewById(R.id.listView);
		listAdapter = new OfficeAdapter(BanShiChuJieShaoActivity.this, mArrOffices);
		listOffice.setAdapter(listAdapter);

		String szData = getIntent().getStringExtra(EXTRA_OFFICES);
		try {
			JSONArray arrJSONOffices = new JSONArray(szData);
			for (int i = 0; i < arrJSONOffices.length(); i++) {
				STOffice office = STOffice.decodeFromJSON(arrJSONOffices.getJSONObject(i));
				mArrOffices.add(office);
			}

			listAdapter.notifyDataSetChanged();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		if(mArrOffices == null || mArrOffices.size() <= 0) {
			ToastUtility.showToast(BanShiChuJieShaoActivity.this, "本城市还没有办事处！");
		}
	}



	public class ViewHolder
	{
		public ImageView imgOffice = null;
		public TextView txtName = null;
		public TextView txtAddress = null;
		public TextView txtPhone = null;
		public ImageButton btnDetail = null;
		public ImageButton btnAddr = null;
		public ImageButton btnPhone = null;
	}

	public class OfficeAdapter extends ArrayAdapter<STOffice> {
		public OfficeAdapter(Context context, List<STOffice> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STOffice office = mArrOffices.get(position);
			ViewHolder holder = null;

			if (convertView == null) {
				RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_banshichu_layout, null);
				ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

				holder = new ViewHolder();

				holder.imgOffice = (ImageView)item_layout.findViewById(R.id.imageView);
				holder.txtName = (TextView)item_layout.findViewById(R.id.txtName);
				holder.txtAddress = (TextView)item_layout.findViewById(R.id.txtAddress);
				holder.txtPhone = (TextView)item_layout.findViewById(R.id.txtPhone);
				holder.btnDetail = (ImageButton)item_layout.findViewById(R.id.btn_detail);
				holder.btnDetail.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						STOffice office = (STOffice)v.getTag();
						onItemSelected(office);
					}
				});
				holder.btnAddr = (ImageButton)item_layout.findViewById(R.id.btn_addr);
				holder.btnAddr.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						STOffice office = (STOffice)v.getTag();
						onAddrClicked(office);
					}
				});
				holder.btnPhone = (ImageButton)item_layout.findViewById(R.id.btn_phone);
				holder.btnPhone.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						STOffice office = (STOffice)v.getTag();
						onPhoneClicked(office);
					}
				});

				item_layout.setTag(holder);

				convertView = item_layout;
			} else {
				holder = (ViewHolder)convertView.getTag();
			}

			holder.txtName.setText(office.name);
			holder.txtAddress.setText(office.address);
			holder.txtPhone.setText(office.phone);
			BitmapUtility.setImageWithImageLoader(holder.imgOffice, office.image_url, loader_options);
			holder.btnDetail.setTag(office);
			holder.btnAddr.setTag(office);
			holder.btnPhone.setTag(office);

			return convertView;
		}
	}


	private void onItemSelected(STOffice office) {
		Bundle bundle = new Bundle();
		bundle.putLong(BanShiChuXiangQingActivity.EXTRA_OFFICE_ID, office.uid);

		pushNewActivityAnimated(BanShiChuXiangQingActivity.class, bundle);
	}

	private void onAddrClicked(final STOffice office) {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(BanShiChuJieShaoActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要导航到该办事处吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						BNavigatorActivity.startNavigationActivity(BanShiChuJieShaoActivity.this,
								office.lat,
								office.lng);
					}
				})
				.build();
		dialog.show();
	}

	private void onPhoneClicked(final STOffice office) {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(BanShiChuJieShaoActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要呼叫" + office.phone + "吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						AppUtility.openDialPad(office.phone, BanShiChuJieShaoActivity.this);
					}
				})
				.build();
		dialog.show();
	}

}
