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
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.structure.custom.STMtQiPanView;
import com.damytech.utils.AppUtility;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 21:53
 * File Name : JingDianActivity
 */
public class QiPanShanJingDianActivity extends SuperActivity {
	private int page_no = 0;
	private PullToRefreshListView pullList = null;
	private PullAdpater pullAdapter = null;
	private ArrayList<STMtQiPanView> arrPullArr = new ArrayList<STMtQiPanView>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_qipanshanjingdian);
	}

	@Override
	protected void initializeActivity() {
		pullAdapter = new PullAdpater(this, arrPullArr);
		pullList = (PullToRefreshListView)findViewById(R.id.pulllist_jingdian);
		{
			pullList.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			pullList.setOnRefreshListener(pullListRefreshListener);
			pullList.setAdapter(pullAdapter);
			pullList.getRefreshableView().setDivider(new ColorDrawable(Color.parseColor("#FFF1F1F1")));
			pullList.getRefreshableView().setDividerHeight(2);
			pullList.getRefreshableView().setCacheColorHint(Color.parseColor("#FFF1F1F1"));
		}

		startProgress();
		getPagedItems();
	}

	private PullToRefreshBase.OnRefreshListener pullListRefreshListener = new PullToRefreshBase.OnRefreshListener() {
		@Override
		public void onRefresh(PullToRefreshBase refreshView) {
			getPagedItems();
		}
	};


	private void getPagedItems() {
		if (arrPullArr == null) {
			arrPullArr = new ArrayList<STMtQiPanView>();
			page_no = 0;
		} else {
			page_no = arrPullArr.size() / AppCommon.getPageItemCount();
		}

		CommManager.getMtQiPanViews(page_no, jingdian_delegate);
	}

	private class PullAdpater extends ArrayAdapter<STMtQiPanView> {
		public PullAdpater(Context context, List<STMtQiPanView> objects) {
			super(context, 0, objects);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STMtQiPanView item_info = arrPullArr.get(position);

			STViewHolder viewHolder = null;
			if (convertView == null) {
				RelativeLayout itemView = (RelativeLayout) getLayoutInflater().inflate(R.layout.item_qipanshanjingdian_layout, null);
				ResolutionUtility.instance.iterateChild(itemView, screen_size.x, screen_size.y);

				viewHolder = new STViewHolder();
				viewHolder.imgIntro = (ImageView)itemView.findViewById(R.id.img_intro);
				viewHolder.txtName = (TextView)itemView.findViewById(R.id.txt_Name);
				viewHolder.txtAddr = (TextView)itemView.findViewById(R.id.txt_address);
				viewHolder.txtPhonenum = (TextView)itemView.findViewById(R.id.txt_phonenum);
				viewHolder.btnItemSel = (ImageButton)itemView.findViewById(R.id.btn_itemsel);
				viewHolder.btnItemSel.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						selectItem((Long)v.getTag());
					}
				});
				viewHolder.btnAddr = (ImageButton)itemView.findViewById(R.id.btn_addr);
				viewHolder.btnAddr.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onAddrClicked((STMtQiPanView)v.getTag());
					}
				});
				viewHolder.btnPhone = (ImageButton)itemView.findViewById(R.id.btn_phone);
				viewHolder.btnPhone.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onPhoneClicked((STMtQiPanView) v.getTag());
					}
				});

				itemView.setTag(viewHolder);
				convertView = itemView;
			} else {
				viewHolder = (STViewHolder) convertView.getTag();
			}

			BitmapUtility.setImageWithImageLoader(viewHolder.imgIntro, item_info.image_url, loader_options);
			viewHolder.txtName.setText(item_info.title);
			viewHolder.txtAddr.setText(item_info.address);
			viewHolder.txtPhonenum.setText(item_info.phone);
			viewHolder.btnItemSel.setTag(item_info.uid);
			viewHolder.btnAddr.setTag(item_info);
			viewHolder.btnPhone.setTag(item_info);

			return convertView;
		}
	}

	private void selectItem(long uid)
	{
		Bundle bundle = new Bundle();
		bundle.putLong(QiPanShanJingDianXiangXiActivity.EXTRA_QIPAN_ID, uid);

		pushNewActivityAnimated(QiPanShanJingDianXiangXiActivity.class, bundle);
	}


	private void onAddrClicked(final STMtQiPanView item_info) {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(QiPanShanJingDianActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要导航到该景点吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						BNavigatorActivity.startNavigationActivity(QiPanShanJingDianActivity.this,
								item_info.lat,
								item_info.lng);
					}
				})
				.build();
		dialog.show();
	}


	private void onPhoneClicked(final STMtQiPanView item_info) {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(QiPanShanJingDianActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要呼叫" + item_info.phone + "吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						AppUtility.openDialPad(item_info.phone, QiPanShanJingDianActivity.this);
					}
				})
				.build();
		dialog.show();
	}


	private CommDelegate jingdian_delegate = new CommDelegate() {
		@Override
		public void getMtQiPanViewsResult(int retcode, String retmsg, ArrayList<STMtQiPanView> arrViews) {
			super.getMtQiPanViewsResult(retcode, retmsg, arrViews);
			stopProgress();
			pullList.onRefreshComplete();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for (int i = 0; i < arrViews.size(); i++) {
					STMtQiPanView item = arrViews.get(i);

					boolean isExist = false;
					for (int j = 0; j < arrPullArr.size(); j++) {
						STMtQiPanView orgItem = arrPullArr.get(j);
						if (orgItem.uid == item.uid) {
							isExist = true;
							break;
						}
					}

					if (!isExist)
						arrPullArr.add(item);
				}

				pullAdapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(QiPanShanJingDianActivity.this, retmsg);
			}
		}
	};

	public class STViewHolder
	{
		TextView txtName = null;
		TextView txtAddr = null;
		TextView txtPhonenum = null;
		ImageView imgIntro = null;

		ImageButton btnItemSel = null;
		ImageButton btnAddr = null;
		ImageButton btnPhone = null;
	}
}
