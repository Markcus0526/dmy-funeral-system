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
 * Time : 00:06
 * File Name : YuanGongShouYeActivity
 */
public class YuanGongShouYeActivity extends SwitchAnimActivity {
	private ImageButton btnSwitch = null;
	private TextView txtTitle = null;

	/**
	 * FangKe variables ***************************************
	 */
	private ArrayList<STAdvertImage> arr_newuser_adverts = new ArrayList<STAdvertImage>();

	private ImageButton btnUser = null;
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



	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yuangongshouye);
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
		first_view = findViewById(R.id.yuangong_layout);
		second_view = findViewById(R.id.fangke_layout);
		first_view.setVisibility(View.VISIBLE);
		second_view.setVisibility(View.VISIBLE);
		first_view.bringToFront();

		first_advert_pager = (HorizontalPager)findViewById(R.id.advert_pager);
		first_indicator_layout = (LinearLayout)findViewById(R.id.page_indicator_layout);

		second_advert_pager = (HorizontalPager)findViewById(R.id.yuangong_advert_pager);
		second_indicator_layout = (LinearLayout)findViewById(R.id.yuangong_page_indicator_layout);

		// Add some views to prevent dragging in these views
		arrFirstDraggableViews.add(first_advert_pager);
		arrFirstDraggableViews.add(txtTitle);
		arrSecondDraggableViews.add(second_advert_pager);
		arrSecondDraggableViews.add(txtTitle);


		/**
		 * Fangke initialize
		 */
		btnUser = (ImageButton)findViewById(R.id.btn_user);
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

		btnUser.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedUser();
			}
		});
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


		startProgress();
		CommManager.getBannerImages(comm_delegate);
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
				YuanGongShouYeActivity.this.arr_yuangong_adverts.clear();
				YuanGongShouYeActivity.this.arr_yuangong_adverts.addAll(arrImages);

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

		@Override
		public void getNavDestinationResult(int retcode, String retmsg, double lat, double lng) {
			super.getNavDestinationResult(retcode, retmsg, lat, lng);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				BNavigatorActivity.startNavigationActivity(YuanGongShouYeActivity.this,
						lat,
						lng);
			} else {
				ToastUtility.showToast(YuanGongShouYeActivity.this, retmsg);
			}
		}

		@Override
		public void getBannerImagesResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages) {
			super.getBannerImagesResult(retcode, retmsg, arrImages);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				YuanGongShouYeActivity.this.arr_newuser_adverts.clear();
				YuanGongShouYeActivity.this.arr_newuser_adverts.addAll(arrImages);

				updateNewUserImageGallery();
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
	 * FangKe actions
	 */
	private void onClickedUser() {}

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
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(YuanGongShouYeActivity.this)
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


}
