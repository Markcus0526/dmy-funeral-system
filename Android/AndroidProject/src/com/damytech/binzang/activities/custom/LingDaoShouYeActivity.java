package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.HorizontalPager;
import com.damytech.structure.custom.STAdvertImage;
import com.damytech.structure.custom.STRelative;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 00:08
 * File Name : LingDaoShouYeActivity
 */
public class LingDaoShouYeActivity extends SwitchAnimActivity {
	private ImageButton btnSwitch = null;
	private TextView txtTitle = null;

	/**
	 * FangKe variables ***************************************
	 */
	private ArrayList<STAdvertImage> arr_newuser_adverts = new ArrayList<STAdvertImage>();

	private ImageButton btnCompanyIntro = null;
	private ImageButton btnAreaBirdsEyeView = null;
	private ImageButton btnAfterService = null;
	private ImageButton btnOfficeIntro = null;
	private ImageButton btnAreaActivity = null;
	private ImageButton btnMapNav = null;
	private ImageButton btnBeryKnowledge = null;
	private ImageButton btnBeryNews = null;
	private ImageButton btnOneDragon = null;
	private ImageButton btnLifeService = null;
	private ImageButton btnReserveVisit = null;
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


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_lingdaoshouye);
	}


	@Override
	protected void onResume() {
		super.onResume();
		CommManager.getNewActivityCount(AppCommon.loadUserIDLong(getApplicationContext()),
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
		second_view = findViewById(R.id.fangke_layout);
		first_view.setVisibility(View.VISIBLE);
		second_view.setVisibility(View.VISIBLE);
		first_view.bringToFront();

		first_advert_pager = (HorizontalPager)findViewById(R.id.advert_pager);
		first_indicator_layout = (LinearLayout)findViewById(R.id.page_indicator_layout);

		second_advert_pager = (HorizontalPager)findViewById(R.id.lingdao_advert_pager);
		second_indicator_layout = (LinearLayout)findViewById(R.id.lingdao_page_indicator_layout);

		// Add some views to prevent dragging in these views
		arrFirstDraggableViews.add(first_advert_pager);
		arrFirstDraggableViews.add(txtTitle);
		arrSecondDraggableViews.add(second_advert_pager);
		arrSecondDraggableViews.add(txtTitle);


		/**
		 * Fangke initialize
		 */
		btnCompanyIntro = (ImageButton)findViewById(R.id.btn_company);
		btnAreaBirdsEyeView = (ImageButton)findViewById(R.id.btn_birdseyeview);
		btnAfterService = (ImageButton)findViewById(R.id.btn_afterservice);
		btnOfficeIntro = (ImageButton)findViewById(R.id.btn_office_intro);
		btnAreaActivity = (ImageButton)findViewById(R.id.btn_activity);
		btnMapNav = (ImageButton)findViewById(R.id.btn_navigation);
		btnBeryKnowledge = (ImageButton)findViewById(R.id.btn_bery_knowledge);
		btnBeryNews = (ImageButton)findViewById(R.id.btn_bery_news);
		btnOneDragon = (ImageButton)findViewById(R.id.btn_one_dragon);
		btnLifeService = (ImageButton)findViewById(R.id.btn_life_service);
		btnReserveVisit = (ImageButton)findViewById(R.id.btn_reserve_visit);

		btnCompanyIntro.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedCompanyIntro();
			}
		});
		btnAreaBirdsEyeView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedAreaBirdsEyeView();
			}
		});
		btnAfterService.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedAfterService();
			}
		});
		btnOfficeIntro.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedOfficeIntro();
			}
		});
		btnAreaActivity.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedActivity();
			}
		});
		btnMapNav.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedMapNav();
			}
		});
		btnBeryKnowledge.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedBeryKnowledge();
			}
		});
		btnBeryNews.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedBeryNews();
			}
		});
		btnOneDragon.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedOneDragon();
			}
		});
		btnLifeService.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedLifeService();
			}
		});
		btnReserveVisit.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedReserveVisit();
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
		/////////////////////////////////////////////////////////////////////////////////////



		startProgress();
		CommManager.getBannerImages(comm_delegate);
		CommManager.getAdverts(AppCommon.loadUserIDLong(getApplicationContext()), comm_delegate);
	}



	/**
	 * LingDao actions
	 */
	private void updateLingDaoImageGallery() {
		second_indicator_layout.removeAllViews();
		arrSecondIndicatorViews.clear();

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


	private void onClickedLingDaoBanner(long activity_id) {
		Bundle bundle = new Bundle();
		bundle.putLong(YuanQuHuoDongXiangQingActivity.EXTRA_ACTIVITY_ID, activity_id);
		bundle.putBoolean(YuanQuHuoDongXiangQingActivity.EXTRA_SHOPCART, false);

		pushNewActivityAnimated(YuanQuHuoDongXiangQingActivity.class, bundle);
	}


	/**
	 * FangKe actions
	 */
	private void onClickedCompanyIntro() {
		pushNewActivityAnimated(GongSiJianJieActivity.class);
	}

	private void onClickedAreaBirdsEyeView() {
		pushNewActivityAnimated(ZhengQuQuanJingActivity.class);
	}

	private void onClickedAfterService() {
		pushNewActivityAnimated(ShouHouFuWuActivity.class);
	}

	private void onClickedOfficeIntro() {
		pushNewActivityAnimated(BanShiChuChengShiActivity.class);
	}

	private void onClickedActivity() {
		pushNewActivityAnimated(SanLiuJingActivity.class);
	}

	private void onClickedMapNav() {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(LingDaoShouYeActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要导航到陵园吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						startProgress();
						CommManager.getNavDestination(comm_delegate);
					}
				})
				.build();
		dialog.show();
	}

	private void onClickedBeryKnowledge() {
		Bundle bundle = new Bundle();
		bundle.putInt(SuperTabActivity.EXTRA_TAB_INDEX, 1);
		bundle.putBoolean(BinZangZhiShiActivity.EXTRA_BINZANG_XINWEN, false);
		pushNewActivityAnimated(BinZangZhiShiActivity.class, bundle);
	}

	private void onClickedBeryNews() {
		pushNewActivityAnimated(BinZangXinWenActivity.class);
	}

	private void onClickedOneDragon() {
		Bundle bundle = new Bundle();
		bundle.putInt(SuperTabActivity.EXTRA_TAB_INDEX, 0);

		pushNewActivityAnimated(BinZangZhiShiActivity.class, bundle);
	}

	private void onClickedLifeService() {
		pushNewActivityAnimated(ShengHuoFuWuActivity.class);
	}

	private void onClickedReserveVisit() {
		pushNewActivityAnimated(YuYueCanGuanActivity.class);
	}


	private void updateNewUserImageGallery() {
		first_indicator_layout.removeAllViews();
		arrFirstIndicatorViews.clear();

		for (int i = 0 ; i < arr_newuser_adverts.size(); i++) {
			STAdvertImage image = arr_newuser_adverts.get(i);

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

					onClickedBanner((Long)v.getTag());
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


	private void onClickedBanner(long advert_id) {
		Bundle bundle = new Bundle();
		bundle.putLong(SanLiuJingJieShaoActivity.EXTRA_VIEW_ID, advert_id);

		pushNewActivityAnimated(SanLiuJingJieShaoActivity.class, bundle);
	}





	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getAdvertsResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages, ArrayList<STRelative> arrRelatives) {
			super.getAdvertsResult(retcode, retmsg, arrImages, arrRelatives);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				LingDaoShouYeActivity.this.arr_lingdao_adverts.clear();
				LingDaoShouYeActivity.this.arr_lingdao_adverts.addAll(arrImages);

				updateLingDaoImageGallery();
			}
		}


		@Override
		public void getNavDestinationResult(int retcode, String retmsg, double lat, double lng) {
			super.getNavDestinationResult(retcode, retmsg, lat, lng);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				BNavigatorActivity.startNavigationActivity(LingDaoShouYeActivity.this,
						lat,
						lng);
			} else {
				ToastUtility.showToast(LingDaoShouYeActivity.this, retmsg);
			}
		}


		@Override
		public void getBannerImagesResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages) {
			super.getBannerImagesResult(retcode, retmsg, arrImages);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				LingDaoShouYeActivity.this.arr_newuser_adverts.clear();
				LingDaoShouYeActivity.this.arr_newuser_adverts.addAll(arrImages);

				updateNewUserImageGallery();
			}
		}
	};


	private void onClickedChuQin() {
		pushNewActivityAnimated(ChuQinNeiRongActivity.class);
	}

	private void onClickedMeiYueYeJi() {
		pushNewActivityAnimated(BanShiChuDanYueYeJiActivity.class);
	}

	private void onClickedMeiRiYeJi() {
		pushNewActivityAnimated(BanShiChuDanRiYeJiActivity.class);
	}

	private void onClickedGeRenYeJi() {
		pushNewActivityAnimated(GeRenYeJiLingDaoActivity.class);
	}

	private void onClickedDaiXiaoYeJi() {
		pushNewActivityAnimated(DaiXiaoYeJiLingDaoActivity.class);
	}

	private void onClickedDingJinDan() {
		pushNewActivityAnimated(DingJinDanChaXunLingDaoActivity.class);
	}

}
