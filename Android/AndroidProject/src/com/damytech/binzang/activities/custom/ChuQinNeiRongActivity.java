package com.damytech.binzang.activities.custom;

import android.graphics.Color;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.widget.*;
import com.damytech.animations.ResizeAnimation;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperScrollActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STOffice;
import com.damytech.structure.custom.STOfficeCity;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-22
 * Time : 15:42
 * File Name : ChuQinNeiRongActivity
 */
public class ChuQinNeiRongActivity extends SuperScrollActivity {
	private final int EXPAND_DURATION = 200;

	private LinearLayout cities_layout = null;
	private ArrayList<STOfficeCity> arrOfficeCities = new ArrayList<STOfficeCity>();

	private LinearLayout mTmpLayout = null;
	private boolean mTmpIsExpand = false;
	private ImageView mTmpImgExpand = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_chuqinneirong);
	}


	@Override
	protected void initializeActivity() {
		cities_layout = (LinearLayout)findViewById(R.id.cities_layout);

		startProgress();
		CommManager.getOfficeList(AppCommon.loadUserIDLong(getApplicationContext()),
				office_list_delegate);
	}



	private CommDelegate office_list_delegate = new CommDelegate() {
		@Override
		public void getOfficeListResult(int retcode, String retmsg, ArrayList<STOfficeCity> arrCities) {
			super.getOfficeListResult(retcode, retmsg, arrCities);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrOfficeCities.clear();
				arrOfficeCities.addAll(arrCities);

				updateUI();
			} else {
				ToastUtility.showToast(ChuQinNeiRongActivity.this, retmsg);
			}
		}
	};


	private void updateUI() {
		for (int i = 0; i < arrOfficeCities.size(); i++) {
			STOfficeCity info = arrOfficeCities.get(i);
			addCityView(info.name, info.uid, info.offices);
		}
	}


	private void addCityView(String szTitle, long uid, ArrayList<STOffice> arrOffices) {
		LinearLayout item_layout = (LinearLayout)getLayoutInflater().inflate(R.layout.item_city_layout, null);

		LinearLayout.LayoutParams layout_params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 90);
		item_layout.setLayoutParams(layout_params);

		item_layout.setBackgroundColor(getResources().getColor(R.color.NORMAL_BACKCOLOR));

		TextView txtMainTitle = (TextView)item_layout.findViewById(R.id.txt_main_title);
		txtMainTitle.setTextColor(Color.DKGRAY);
		txtMainTitle.setText(szTitle);

		LinearLayout list_layout = (LinearLayout)item_layout.findViewById(R.id.sublist_layout);

		for (int i = 0; i < arrOffices.size();i++) {
			STOffice info = arrOffices.get(i);

			RelativeLayout sub_layout = new RelativeLayout(list_layout.getContext());
			sub_layout.setLayoutParams(new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 90));

			TextView txtView = new TextView(sub_layout.getContext());
			RelativeLayout.LayoutParams txtlayout_params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
			txtView.setLayoutParams(txtlayout_params);
			txtView.setPadding(20, 0, 0, 0);
			txtView.setTextSize(TypedValue.COMPLEX_UNIT_PX, 22);
			txtView.setTextColor(Color.DKGRAY);
			txtView.setGravity(Gravity.CENTER_VERTICAL);
			txtView.setText(info.name);
			sub_layout.addView(txtView);

			ImageView top_sep_view = new ImageView(sub_layout.getContext());
			RelativeLayout.LayoutParams sep_layout_params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 1);
			sep_layout_params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
			top_sep_view.setLayoutParams(sep_layout_params);
			top_sep_view.setBackgroundColor(getResources().getColor(R.color.LIST_SEP_NORMAL_COLOR));
			sub_layout.addView(top_sep_view);


			if (i == arrOffices.size() - 1) {
				ImageView bottom_sep_view = new ImageView(sub_layout.getContext());
				RelativeLayout.LayoutParams bottom_sep_layout_params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 1);
				bottom_sep_layout_params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
				bottom_sep_view.setLayoutParams(bottom_sep_layout_params);
				bottom_sep_view.setBackgroundColor(getResources().getColor(R.color.LIST_SEP_NORMAL_COLOR));
				sub_layout.addView(bottom_sep_view);
			}


			ImageButton btnItem = new ImageButton(sub_layout.getContext());
			btnItem.setLayoutParams(layout_params);
			btnItem.setBackgroundResource(R.drawable.preset_btn_rect_transparent_transparent);
			btnItem.setTag(info);
			btnItem.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					onSelectArea((STOffice)v.getTag());
				}
			});
			sub_layout.addView(btnItem);

			list_layout.addView(sub_layout);
		}

		ImageButton btnExpand = (ImageButton)item_layout.findViewById(R.id.btn_expand);
		btnExpand.setTag(arrOffices.size());
		btnExpand.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onExpandRecord(v);
			}
		});

		ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

		item_layout.setTag(uid);
		cities_layout.addView(item_layout);
	}


	private void onSelectArea(STOffice office_info) {
		Bundle bundle = new Bundle();
		bundle.putLong(ChuQinXiangXiActivity.EXTRA_OFFICE_ID, office_info.uid);
		bundle.putString(ChuQinXiangXiActivity.EXTRA_OFFICE_NAME, office_info.name);
		bundle.putString(ChuQinXiangXiActivity.EXTRA_TITLE, "'" + office_info.name + "'出勤内容");

		pushNewActivityAnimated(ChuQinXiangXiActivity.class, bundle);
	}

	private void onExpandRecord(View v)
	{
		int nSubItemCount = (Integer)v.getTag();
		nSubItemCount++;
		mTmpLayout = (LinearLayout)(v.getParent().getParent());

		int nRowHeight = 90, nRowCount;
		final int nRealHeight = (int)(nRowHeight * ResolutionUtility.instance.getYPro());
		mTmpIsExpand = (Math.abs(mTmpLayout.getHeight() - nRealHeight * nSubItemCount) < 5);

		int nNewHeight, nOldHeight;
		if (mTmpIsExpand)
		{
			nOldHeight = nRealHeight * nSubItemCount;
			nNewHeight = nRealHeight;
			nRowCount = 1;
		}
		else
		{
			nNewHeight = nRealHeight * nSubItemCount;
			nOldHeight = nRealHeight;
			nRowCount = nSubItemCount;
		}

		final int final_rowCount = nRowCount;
		mTmpImgExpand = (ImageView)mTmpLayout.findViewById(R.id.img_expand);

		ResizeAnimation anim = new ResizeAnimation(mTmpLayout, ViewGroup.LayoutParams.MATCH_PARENT, nOldHeight, ViewGroup.LayoutParams.MATCH_PARENT, nNewHeight);
		anim.setDuration(EXPAND_DURATION);
		anim.setFillAfter(true);
		anim.setAnimationListener(new Animation.AnimationListener() {
			@Override
			public void onAnimationStart(Animation animation) {
			}

			@Override
			public void onAnimationEnd(Animation animation) {
				mTmpLayout.clearAnimation();
				mTmpIsExpand = !mTmpIsExpand;
				if (mTmpIsExpand)
					mTmpImgExpand.setImageResource(R.drawable.bk_down_arrow);
				else
					mTmpImgExpand.setImageResource(R.drawable.bk_right_arrow);

				cities_layout.setTag(R.string.TAG_KEY_HEIGHT, "" + nRealHeight * final_rowCount);
			}

			@Override
			public void onAnimationRepeat(Animation animation) {
			}
		});
		mTmpLayout.startAnimation(anim);
	}



}
