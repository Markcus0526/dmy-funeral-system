package com.damytech.binzang.activities.custom;

import android.graphics.Color;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.widget.*;
import com.damytech.animations.ResizeAnimation;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.STDragonServiceArea;
import com.damytech.structure.custom.STDragonServiceCity;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 14:36
 * File Name : BinZangZhiShi_YiTiaoLongTabFrame
 */
public class BinZangZhiShi_YiTiaoLongTabFrame extends SuperTabActivity.TabFrame {
	private final int EXPAND_DURATION = 200;

	private LinearLayout mAreaListLayout = null;
	private LinearLayout mTmpLayout = null;
	private boolean mTmpIsExpand = false;
	private ImageView mTmpImgExpand = null;

	private boolean isInit = false;

	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_binzangzhishi_yitiaolong_tab, container, false);

		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		mAreaListLayout = (LinearLayout)parentView.findViewById(R.id.arealist_layout);
	}


	@Override
	public void onResume() {
		super.onResume();

		if (!isInit)
			loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getOneDragonAreas(one_dragon_areas_delegate);
	}

	private CommDelegate one_dragon_areas_delegate = new CommDelegate() {
		@Override
		public void getOneDragonAreasResult(int retcode, String retmsg, ArrayList<STDragonServiceCity> arrCities) {
			super.getOneDragonAreasResult(retcode, retmsg, arrCities);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				mAreaListLayout.removeAllViews();
				for (int i = 0; i < arrCities.size(); i++) {
					STDragonServiceCity info = arrCities.get(i);
					addContents(info.name, info.uid, info.areas);
				}

				isInit = true;
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};


	private void addContents(String szTitle, long uid, ArrayList<STDragonServiceArea> arrs) {
		LinearLayout item_layout = (LinearLayout)parentActivity.getLayoutInflater().inflate(R.layout.item_city_layout, null);
		LinearLayout.LayoutParams layout_params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 90);
		item_layout.setBackgroundColor(getResources().getColor(R.color.DEFAULT_BACK_GRAY));
		item_layout.setLayoutParams(layout_params);
		TextView txtMainTitle = (TextView)item_layout.findViewById(R.id.txt_main_title);
		txtMainTitle.setTextColor(Color.DKGRAY);
		txtMainTitle.setText(szTitle);

		LinearLayout list_layout = (LinearLayout)item_layout.findViewById(R.id.sublist_layout);

		for (int i = 0; i < arrs.size();i++) {
			STDragonServiceArea info = arrs.get(i);
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

			ImageView sep_view = new ImageView(sub_layout.getContext());
			RelativeLayout.LayoutParams sep_layout_params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 1);
			sep_layout_params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
			sep_view.setLayoutParams(sep_layout_params);
			sep_view.setBackgroundColor(getResources().getColor(R.color.LIST_SEP_NORMAL_COLOR));
			sub_layout.addView(sep_view);


			ImageButton btnItem = new ImageButton(sub_layout.getContext());
			btnItem.setLayoutParams(layout_params);
			btnItem.setBackgroundResource(R.drawable.preset_btn_rect_transparent_transparent);
			btnItem.setTag(info.uid);
			btnItem.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					onSelectArea((Long)v.getTag());
				}
			});
			sub_layout.addView(btnItem);

			list_layout.addView(sub_layout);
		}

		ImageButton btnExpand = (ImageButton)item_layout.findViewById(R.id.btn_expand);
		btnExpand.setTag(arrs.size());
		btnExpand.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onExpandRecord(v);
			}
		});

		ResolutionUtility.instance.iterateChild(item_layout, parentActivity.screen_size.x, parentActivity.screen_size.y);

		mAreaListLayout.setTag(uid);
		mAreaListLayout.addView(item_layout);
	}

	private void onSelectArea(Long  id)
	{
		Bundle bundle = new Bundle();
		bundle.putLong(YiTiaoLongFuWuActivity.EXTRA_AREA_ID, id);

		parentActivity.pushNewActivityAnimated(YiTiaoLongFuWuActivity.class, bundle);
	}

	private void onExpandRecord(View v)
	{
		int nSubItemCount = (Integer)v.getTag();
		nSubItemCount++;

		mTmpLayout = (LinearLayout)(v.getParent().getParent());

		int nRowHeight = 90, nRowCount;
		final int nRealHeight = (int)(nRowHeight * ResolutionUtility.instance.getYPro());
		mTmpIsExpand = (Math.abs(mTmpLayout.getHeight() - (int)(nRealHeight * nSubItemCount)) < 5);

		int nNewHeight, nOldHeight;
		if (mTmpIsExpand)
		{
			nOldHeight = (int)(nRealHeight * nSubItemCount);
			nNewHeight = nRealHeight;
			nRowCount = 1;
		}
		else
		{
			nNewHeight = (int)(nRealHeight * nSubItemCount);
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
			public void onAnimationStart(Animation animation) {}
			@Override
			public void onAnimationEnd(Animation animation) {
				mTmpLayout.clearAnimation();
				mTmpIsExpand = !mTmpIsExpand;
				if (mTmpIsExpand)
					mTmpImgExpand.setImageResource(R.drawable.bk_down_arrow);
				else
					mTmpImgExpand.setImageResource(R.drawable.bk_right_arrow);

				mAreaListLayout.setTag(R.string.TAG_KEY_HEIGHT, "" + nRealHeight * final_rowCount);
			}
			@Override
			public void onAnimationRepeat(Animation animation) {}
		});
		mTmpLayout.startAnimation(anim);
	}

}
