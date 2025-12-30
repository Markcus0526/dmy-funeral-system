package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.HorizontalPager;
import com.damytech.structure.custom.STAdvertImage;
import com.damytech.structure.custom.STRelative;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 00:08
 * File Name : ZhuRenShouYeActivity
 */
public class ZhuRenShouYeActivity extends SwitchAnimActivity {
	private ImageButton btnSwitch = null;
	private TextView txtTitle = null;


	/**
	 * YuanGong variables ************************************************
	 */
	private ArrayList<STAdvertImage> arr_yuangong_adverts = new ArrayList<STAdvertImage>();

	private TextView txtActivityBadge = null;
	private TextView txtBuyBadge = null;

	private ImageButton btnHuoDongTongZhi = null;
	private ImageButton btnLingYuanYuLiu = null;
	private ImageButton btnJiangJinJiSuan = null;
	private ImageButton btnZhangDanChaXun = null;
	private ImageButton btnDingJinDanChaXun = null;
	private ImageButton btnDaiXiaoRenYuan = null;
	private ImageButton btnLuoZangYiShiYuYue = null;
	private ImageButton btnDaiDingJiPinGouMai = null;
	private ImageButton btnZiYouKeHuShangPin = null;
	private ImageButton btnXiuJiaBiao = null;
	/////////////////////////////////////////////////////////////////////////////////////


	/**
	 * LingDao variables ************************************************
	 */
	private ArrayList<STAdvertImage> arr_lingdao_adverts = new ArrayList<STAdvertImage>();

	private ImageButton btnChuQin = null;
	private ImageButton btnMeiYueYeJi = null;
	private ImageButton btnMeiRiYeJi = null;
	private ImageButton btnGeRenYeJi = null;
	private ImageButton btnDaiXiaoYeJi = null;
	private ImageButton btnDingJinDan = null;
	private ImageButton btnYuYueChaXun = null;



	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_zhurenshouye);
	}


	@Override
	protected void onResume() {
		super.onResume();

		CommManager.getNewActivityCount(AppCommon.loadUserIDLong(getApplicationContext()),
				comm_delegate);
		CommManager.getBuyProductCount(AppCommon.loadUserIDLong(getApplicationContext()),
				comm_delegate);
	}


	@Override
	protected void initializeActivity() {
		txtTitle = (TextView)findViewById(R.id.txt_title);
		String strTitle = AppCommon.loadUserRealName(getApplicationContext()) + "," + getString(R.string.STR_TITLE_NIHAO);
		txtTitle.setText(strTitle);

		btnSwitch = (ImageButton)findViewById(R.id.btn_switch);
		btnSwitch.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				transViewsProcess(0);
			}
		});


		// Initialize for animation
		first_view = findViewById(R.id.lingdao_layout);
		second_view = findViewById(R.id.yuangong_layout);
		first_view.setVisibility(View.VISIBLE);
		second_view.setVisibility(View.VISIBLE);
		first_view.bringToFront();

		first_advert_pager = (HorizontalPager)findViewById(R.id.lingdao_advert_pager);
		first_indicator_layout = (LinearLayout)findViewById(R.id.lingdao_page_indicator_layout);

		second_advert_pager = (HorizontalPager)findViewById(R.id.yuangong_advert_pager);
		second_indicator_layout = (LinearLayout)findViewById(R.id.yuangong_page_indicator_layout);

		// Add some views to prevent dragging in these views
		arrFirstDraggableViews.add(first_advert_pager);
		arrFirstDraggableViews.add(txtTitle);
		arrSecondDraggableViews.add(second_advert_pager);
		arrSecondDraggableViews.add(txtTitle);


		/**
		 * YuanGong initialize
		 */
		txtActivityBadge = (TextView)findViewById(R.id.txt_badge);
		txtActivityBadge.setVisibility(View.INVISIBLE);

		txtBuyBadge = (TextView)findViewById(R.id.txt_buy_badge);
		txtBuyBadge.setVisibility(View.INVISIBLE);


		btnHuoDongTongZhi = (ImageButton)findViewById(R.id.btn_tongzhi);
		btnLingYuanYuLiu = (ImageButton)findViewById(R.id.btn_yuliu);
		btnJiangJinJiSuan = (ImageButton)findViewById(R.id.btn_jisuan);
		btnZhangDanChaXun = (ImageButton)findViewById(R.id.btn_zhangdan);
		btnDingJinDanChaXun = (ImageButton)findViewById(R.id.btn_dingjindanchaxun);
		btnDaiXiaoRenYuan = (ImageButton)findViewById(R.id.btn_daixiaorenyuan);
		btnLuoZangYiShiYuYue = (ImageButton)findViewById(R.id.btn_luozangyishiyuyue);
		btnDaiDingJiPinGouMai = (ImageButton)findViewById(R.id.btn_daiding);
		btnZiYouKeHuShangPin = (ImageButton)findViewById(R.id.btn_shangpindinggoutongzhi);
		btnXiuJiaBiao = (ImageButton)findViewById(R.id.btn_vocation_table);

		btnHuoDongTongZhi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedHuoDongTongZhi();
			}
		});
		btnLingYuanYuLiu.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedLingYuanYuLiu();
			}
		});
		btnJiangJinJiSuan.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedJiangJinJiSuan();
			}
		});
		btnZhangDanChaXun.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedZhangDanChaXun();
			}
		});
		btnDingJinDanChaXun.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedDingJinDanChaXun();
			}
		});
		btnDaiXiaoRenYuan.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedDaiXiaoRenYuan();
			}
		});
		btnLuoZangYiShiYuYue.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedLuoZangYiShiYuYue();
			}
		});
		btnDaiDingJiPinGouMai.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedDaiDingJiPinGouMai();
			}
		});
		btnZiYouKeHuShangPin.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedZiYouKeHuShangPinDingGouTongZhi();
			}
		});
		btnXiuJiaBiao.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedXiuJiaBiao();
			}
		});
		/////////////////////////////////////////////////////////////////////////////////////


		// LingDao initialize
		btnChuQin = (ImageButton)findViewById(R.id.btn_chuqin);
		btnMeiYueYeJi = (ImageButton)findViewById(R.id.btn_meiyueyeji);
		btnMeiRiYeJi = (ImageButton)findViewById(R.id.btn_meiriyeji);
		btnGeRenYeJi = (ImageButton)findViewById(R.id.btn_gerenyeji);
		btnDaiXiaoYeJi = (ImageButton)findViewById(R.id.btn_daixiaoshangyeji);
		btnDingJinDan = (ImageButton)findViewById(R.id.btn_dingjindan);
		btnYuYueChaXun = (ImageButton)findViewById(R.id.btn_yuyuechaxun);

		btnChuQin.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedChuQin();
			}
		});
		btnMeiYueYeJi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedMeiYueYeJi();
			}
		});
		btnMeiRiYeJi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedMeiRiYeJi();
			}
		});
		btnGeRenYeJi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedGeRenYeJi();
			}
		});
		btnDaiXiaoYeJi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedDaiXiaoYeJi();
			}
		});
		btnDingJinDan.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedDingJinDan();
			}
		});
		btnYuYueChaXun.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedYuYueChaXun();
			}
		});
		/////////////////////////////////////////////////////////////////////////////////////


		startProgress();
		CommManager.getAdverts(AppCommon.loadUserIDLong(getApplicationContext()), comm_delegate);

	}



	/**
	 * YuanGong actions
	 */
	private void onClickedHuoDongTongZhi() {
		Bundle bundle = new Bundle();
		bundle.putBoolean(YuanQuHuoDongActivity.EXTRA_SHOPCART, false);
		pushNewActivityAnimated(YuanQuHuoDongActivity.class, bundle);
	}

	private void onClickedLingYuanYuLiu() {
		pushNewActivityAnimated(LingYuanYuLiuActivity.class);
	}

	private void onClickedJiangJinJiSuan() {
		pushNewActivityAnimated(JiangJinJiSuanActivity.class);
	}

	private void onClickedZhangDanChaXun() {
		pushNewActivityAnimated(ZhangDanChaXunActivity.class);
	}

	private void onClickedDingJinDanChaXun() {
		Bundle bundle = new Bundle();
		bundle.putString(DingJinDanChaXunYuanGongActivity.EXTRA_TITLE, "订金单查询");
		bundle.putLong(DingJinDanChaXunYuanGongActivity.EXTRA_AIM_USER_ID, AppCommon.loadUserIDLong(getApplicationContext()));
		bundle.putBoolean(DingJinDanChaXunYuanGongActivity.EXTRA_BONUS_LOG, true);

		pushNewActivityAnimated(DingJinDanChaXunYuanGongActivity.class, bundle);
	}

	private void onClickedDaiXiaoRenYuan() {
		pushNewActivityAnimated(DaiXiaoRenYuanActivity.class);
	}

	private void onClickedLuoZangYiShiYuYue() {
		Bundle bundle = new Bundle();
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_ISAGENT, true);
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_NEED_BURYSERVICE, true);
		bundle.putString(YiShiYuYueActivity.EXTRA_ACTIVITY_TITLE, "代预约落葬仪式");

		pushNewActivityAnimated(YiShiYuYueActivity.class, bundle);
	}

	private void onClickedDaiDingJiPinGouMai() {
		Bundle bundle = new Bundle();
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_ISAGENT, true);
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_NEED_BURYSERVICE, false);
		bundle.putString(YiShiYuYueActivity.EXTRA_ACTIVITY_TITLE, "代订祭品购买");

		pushNewActivityAnimated(YiShiYuYueActivity.class, bundle);
	}


	private void onClickedZiYouKeHuShangPinDingGouTongZhi() {
		pushNewActivityAnimated(ZiYouKeHuShangPinDingGouActivity.class);
	}


	private void onClickedXiuJiaBiao() {
		pushNewActivityAnimated(XiuJiaBiaoActivity.class);
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getAdvertsResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages, ArrayList<STRelative> arrRelatives) {
			super.getAdvertsResult(retcode, retmsg, arrImages, arrRelatives);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				ZhuRenShouYeActivity.this.arr_yuangong_adverts.clear();
				ZhuRenShouYeActivity.this.arr_yuangong_adverts.addAll(arrImages);

				ZhuRenShouYeActivity.this.arr_lingdao_adverts.clear();
				ZhuRenShouYeActivity.this.arr_lingdao_adverts.addAll(arrImages);

				updateLingDaoImageGallery();
				updateYuanGongImageGallery();
			}
		}

		@Override
		public void getNewActivityCountResult(int retcode, String retmsg, int count) {
			super.getNewActivityCountResult(retcode, retmsg, count);

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				txtActivityBadge.setText("" + count);
				if (count > 0)
					txtActivityBadge.setVisibility(View.VISIBLE);
				else
					txtActivityBadge.setVisibility(View.INVISIBLE);
			}
		}

		@Override
		public void getBuyProductCountResult(int retcode, String retmsg, int count) {
			super.getBuyProductCountResult(retcode, retmsg, count);

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				txtBuyBadge.setText("" + count);
				if (count > 0)
					txtBuyBadge.setVisibility(View.VISIBLE);
				else
					txtBuyBadge.setVisibility(View.INVISIBLE);
			}
		}
	};







	private void updateYuanGongImageGallery() {
		second_indicator_layout.removeAllViews();
		arrSecondIndicatorViews.clear();

		for (int i = 0 ; i < arr_yuangong_adverts.size(); i++) {
			STAdvertImage image = arr_yuangong_adverts.get(i);

			RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_guanggao_layout, null);
			ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

			ImageView imgView = (ImageView)item_layout.findViewById(R.id.img_content);
			BitmapUtility.setImageWithImageLoader(imgView, image.image_url, loader_options);

			ImageButton btnItem = (ImageButton)item_layout.findViewById(R.id.btn_item);
			btnItem.setTag(image.uid);
			btnItem.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
						return;

					onClickedDaiXiaoShangBanner((Long) v.getTag());
				}
			});

			second_advert_pager.addView(item_layout);


			// Indicator layout
			RelativeLayout indicator_item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_yemiansuoyin_layout, null);
			ResolutionUtility.instance.iterateChild(indicator_item_layout, screen_size.x, screen_size.y);

			ImageView imgIndicator = (ImageView)indicator_item_layout.findViewById(R.id.img_circle);
			if (i == 0) {
				imgIndicator.setImageResource(R.drawable.green_circle);
			} else {
				imgIndicator.setImageResource(R.drawable.gray_circle);
			}
			arrSecondIndicatorViews.add(imgIndicator);

			second_indicator_layout.addView(indicator_item_layout);
		}


		second_advert_pager.setOnScreenSwitchListener(new HorizontalPager.OnScreenSwitchListener() {
			@Override
			public void onScreenSwitched(int screen) {
				arrSecondIndicatorViews.get(second_indicator_index).setImageResource(R.drawable.gray_circle);
				arrSecondIndicatorViews.get(screen).setImageResource(R.drawable.green_circle);
				second_indicator_index = screen;
			}
		});

		startSecondAdvertTimer();
	}


	private void onClickedDaiXiaoShangBanner(long activity_id) {
		Bundle bundle = new Bundle();
		bundle.putLong(YuanQuHuoDongXiangQingActivity.EXTRA_ACTIVITY_ID, activity_id);
		bundle.putBoolean(YuanQuHuoDongXiangQingActivity.EXTRA_SHOPCART, false);

		pushNewActivityAnimated(YuanQuHuoDongXiangQingActivity.class, bundle);
	}






	/**
	 * LingDao actions
	 */
	private void updateLingDaoImageGallery() {
		first_indicator_layout.removeAllViews();
		arrFirstIndicatorViews.clear();

		for (int i = 0 ; i < arr_lingdao_adverts.size(); i++) {
			STAdvertImage image = arr_lingdao_adverts.get(i);

			RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_guanggao_layout, null);
			ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

			ImageView imgView = (ImageView)item_layout.findViewById(R.id.img_content);
			BitmapUtility.setImageWithImageLoader(imgView, image.image_url, loader_options);

			ImageButton btnItem = (ImageButton)item_layout.findViewById(R.id.btn_item);
			btnItem.setTag(image.uid);
			btnItem.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
						return;

					onClickedLingDaoBanner((Long) v.getTag());
				}
			});

			first_advert_pager.addView(item_layout);


			// Indicator layout
			RelativeLayout indicator_item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_yemiansuoyin_layout, null);
			ResolutionUtility.instance.iterateChild(indicator_item_layout, screen_size.x, screen_size.y);

			ImageView imgIndicator = (ImageView)indicator_item_layout.findViewById(R.id.img_circle);
			if (i == 0) {
				imgIndicator.setImageResource(R.drawable.green_circle);
			} else {
				imgIndicator.setImageResource(R.drawable.gray_circle);
			}
			arrFirstIndicatorViews.add(imgIndicator);

			first_indicator_layout.addView(indicator_item_layout);
		}


		first_advert_pager.setOnScreenSwitchListener(new HorizontalPager.OnScreenSwitchListener() {
			@Override
			public void onScreenSwitched(int screen) {
				arrFirstIndicatorViews.get(first_indicator_index).setImageResource(R.drawable.gray_circle);
				arrFirstIndicatorViews.get(screen).setImageResource(R.drawable.green_circle);
				first_indicator_index = screen;
			}
		});

		startFirstAdvertTimer();
	}


	private void onClickedLingDaoBanner(long activity_id) {
		Bundle bundle = new Bundle();
		bundle.putLong(YuanQuHuoDongXiangQingActivity.EXTRA_ACTIVITY_ID, activity_id);
		bundle.putBoolean(YuanQuHuoDongXiangQingActivity.EXTRA_SHOPCART, false);

		pushNewActivityAnimated(YuanQuHuoDongXiangQingActivity.class, bundle);
	}


	private void onClickedChuQin() {
		long office_id = AppCommon.loadOfficeID(getApplicationContext());
		String office_name = AppCommon.loadOfficeName(getApplicationContext());

		Bundle bundle = new Bundle();
		bundle.putLong(ChuQinXiangXiActivity.EXTRA_OFFICE_ID, office_id);
		bundle.putString(ChuQinXiangXiActivity.EXTRA_OFFICE_NAME, office_name);
		bundle.putString(ChuQinXiangXiActivity.EXTRA_TITLE, "'" + office_name + "'出勤内容");

		pushNewActivityAnimated(ChuQinXiangXiActivity.class, bundle);
	}

	private void onClickedMeiYueYeJi() {
		pushNewActivityAnimated(BanShiChuDanYueYeJiActivity.class);
	}

	private void onClickedMeiRiYeJi() {
		pushNewActivityAnimated(BanShiChuDanRiYeJiActivity.class);
	}

	private void onClickedGeRenYeJi() {
		pushNewActivityAnimated(GeRenYeJiZhuRenActivity.class);
	}

	private void onClickedDaiXiaoYeJi() {
		pushNewActivityAnimated(DaiXiaoYeJiZhuRenActivity.class);
	}

	private void onClickedDingJinDan() {
		pushNewActivityAnimated(DingJinDanChaXunZhuRenActivity.class);
	}

	private void onClickedYuYueChaXun() {
		pushNewActivityAnimated(YuYueCanGuanChaXunActivity.class);
	}
}
