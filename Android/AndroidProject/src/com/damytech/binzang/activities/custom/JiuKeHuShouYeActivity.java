package com.damytech.binzang.activities.custom;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import cn.jpush.android.api.JPushInterface;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.custom.ParentBirthNotifyDlg;
import com.damytech.binzang.dialogs.custom.TombDetailDialog;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.HorizontalPager;
import com.damytech.structure.custom.STAdvertImage;
import com.damytech.structure.custom.STParentBirthNotify;
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
 * File Name : JiuKeHuShouYeActivity
 */
public class JiuKeHuShouYeActivity extends SwitchAnimActivity {
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
	 * JiuKeHu variables ************************************************
	 */
	private ArrayList<STAdvertImage> arr_jiukehu_adverts = new ArrayList<STAdvertImage>();
	private ArrayList<STRelative> arr_jiukehu_relatives = new ArrayList<STRelative>();

	private TextView txtBadge = null;

	private ImageButton btnYuanQuHuoDong = null;
	private ImageButton btnQinRenShuJuChaXun = null;
	private ImageButton btnZhangDanChaXun = null;
	private ImageButton btnDaiJiBaiHuiHan = null;
	private ImageButton btnFuWuRenYuan = null;
	private ImageButton btnLuoZangYiShiYuYue = null;
	private ImageButton btnJiuBaiYuYue = null;
	///////////////////////////////////////////////////////////////////////////////////////////


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_jiukehushouye);
	}


	@Override
	protected void onResume() {
		super.onResume();

		CommManager.getNewActivityCount(AppCommon.loadUserIDLong(getApplicationContext()), comm_delegate);
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
		first_view = findViewById(R.id.jiukehu_layout);
		second_view = findViewById(R.id.fangke_layout);
		first_view.setVisibility(View.VISIBLE);
		second_view.setVisibility(View.VISIBLE);
		first_view.bringToFront();

		first_advert_pager = (HorizontalPager)findViewById(R.id.advert_pager);
		first_indicator_layout = (LinearLayout)findViewById(R.id.page_indicator_layout);

		second_advert_pager = (HorizontalPager)findViewById(R.id.jiukehu_advert_pager);
		second_indicator_layout = (LinearLayout)findViewById(R.id.jiukehu_page_indicator_layout);

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
		 * JiuKeHu initialize
		 */
		txtBadge = (TextView)findViewById(R.id.txt_badge);
		txtBadge.setVisibility(View.INVISIBLE);

		btnYuanQuHuoDong = (ImageButton)findViewById(R.id.btn_yuanquhuodongtongzhi);
		btnQinRenShuJuChaXun = (ImageButton)findViewById(R.id.btn_qinrenshujuchaxun);
		btnZhangDanChaXun = (ImageButton)findViewById(R.id.btn_zhangdanchaxun);
		btnDaiJiBaiHuiHan = (ImageButton)findViewById(R.id.btn_daijibaihuihan);
		btnFuWuRenYuan = (ImageButton)findViewById(R.id.btn_fuwurenyuan);
		btnLuoZangYiShiYuYue = (ImageButton)findViewById(R.id.btn_luozangyishiyuyue);
		btnJiuBaiYuYue = (ImageButton)findViewById(R.id.btn_jibaiyuyue);

		btnYuanQuHuoDong.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedYuanQuHuoDongTongZhi();
			}
		});
		btnQinRenShuJuChaXun.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedQinRenShuJuChaXun();
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
		btnDaiJiBaiHuiHan.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedDaiJiBaiHuiHan();
			}
		});
		btnFuWuRenYuan.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedFuWuRenYuan();
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
		btnJiuBaiYuYue.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
					return;

				onClickedJiBaiYuYue();
			}
		});
		///////////////////////////////////////////////////////////////////////////////////


		startProgress();
		CommManager.getBannerImages(comm_delegate);
		CommManager.getAdverts(AppCommon.loadUserIDLong(getApplicationContext()), comm_delegate);
		CommManager.checkParentBirthNotify(AppCommon.loadUserIDLong(getApplicationContext()), comm_delegate);

		//check whether received the push notification.

		Intent intent = getIntent();

		if (intent != null)
		{
			Bundle bundle = intent.getExtras();

			if (bundle != null) {
				String strMsg = bundle.getString(JPushInterface.EXTRA_ALERT);

				if (strMsg != null) {

					//first_view.setVisibility(View.VISIBLE);
					//second_view.setVisibility(View.VISIBLE);
					//second_view.bringToFront();
					transViewsProcess(0);

					String contentMsg = strMsg.replace("ParentBirth\r\n","");
					CommonAlertDialog dialog = new CommonAlertDialog.Builder(JiuKeHuShouYeActivity.this)
							.message(contentMsg)
							.type(CommonAlertDialog.DIALOGTYPE_ALERT)
							.build();
					dialog.show();
				}
			}
		}
	}




	/**
	 * JiuKeHu actions
	 */
	private void onClickedYuanQuHuoDongTongZhi() {
		Bundle bundle = new Bundle();
		bundle.putBoolean(YuanQuHuoDongActivity.EXTRA_SHOPCART, true);
		pushNewActivityAnimated(YuanQuHuoDongActivity.class, bundle);
	}

	private void onClickedQinRenShuJuChaXun() {
		pushNewActivityAnimated(QinRenShuJuChaXunActivity.class);
	}

	private void onClickedZhangDanChaXun() {
		pushNewActivityAnimated(ZhangDanChaXunActivity.class);
	}

	private void onClickedDaiJiBaiHuiHan() {
		pushNewActivityAnimated(DaiJiBaiHuiHanActivity.class);
	}

	private void onClickedFuWuRenYuan() {
		pushNewActivityAnimated(FuWuRenYuanActivity.class);
	}

	private void onClickedLuoZangYiShiYuYue() {
		Bundle bundle = new Bundle();
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_ISAGENT, false);
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_NEED_BURYSERVICE, true);
		bundle.putString(YiShiYuYueActivity.EXTRA_ACTIVITY_TITLE, "落葬仪式预约");

		pushNewActivityAnimated(YiShiYuYueActivity.class, bundle);
	}

	private void onClickedJiBaiYuYue() {
		Bundle bundle = new Bundle();
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_ISAGENT, false);
		bundle.putBoolean(YiShiYuYueActivity.EXTRA_NEED_BURYSERVICE, false);
		bundle.putString(YiShiYuYueActivity.EXTRA_ACTIVITY_TITLE, "祭拜预约");

		pushNewActivityAnimated(YiShiYuYueActivity.class, bundle);
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getAdvertsResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages, ArrayList<STRelative> arrRelatives) {
			super.getAdvertsResult(retcode, retmsg, arrImages, arrRelatives);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				JiuKeHuShouYeActivity.this.arr_jiukehu_adverts.clear();
				JiuKeHuShouYeActivity.this.arr_jiukehu_adverts.addAll(arrImages);

				JiuKeHuShouYeActivity.this.arr_jiukehu_relatives.clear();
				JiuKeHuShouYeActivity.this.arr_jiukehu_relatives.addAll(arrRelatives);

				updateCustomerImageGallery();
			}
		}


		@Override
		public void getNewActivityCountResult(int retcode, String retmsg, int count) {
			super.getNewActivityCountResult(retcode, retmsg, count);

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				txtBadge.setText("" + count);
				if (count > 0)
					txtBadge.setVisibility(View.VISIBLE);
				else
					txtBadge.setVisibility(View.INVISIBLE);
			}
		}


		@Override
		public void getNavDestinationResult(int retcode, String retmsg, double lat, double lng) {
			super.getNavDestinationResult(retcode, retmsg, lat, lng);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				BNavigatorActivity.startNavigationActivity(JiuKeHuShouYeActivity.this,
						lat,
						lng);
			} else {
				ToastUtility.showToast(JiuKeHuShouYeActivity.this, retmsg);
			}
		}


		@Override
		public void getBannerImagesResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages) {
			super.getBannerImagesResult(retcode, retmsg, arrImages);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				JiuKeHuShouYeActivity.this.arr_newuser_adverts.clear();
				JiuKeHuShouYeActivity.this.arr_newuser_adverts.addAll(arrImages);

				updateNewUserImageGallery();
			}
		}


		@Override
		public void checkParentBirthNotifyResult(int retcode, String retmsg, ArrayList<STParentBirthNotify> arrNotify) {
			super.checkParentBirthNotifyResult(retcode, retmsg, arrNotify);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				for(STParentBirthNotify item : arrNotify) {
					ParentBirthNotifyDlg dialog = new ParentBirthNotifyDlg(JiuKeHuShouYeActivity.this);
					dialog.init(JiuKeHuShouYeActivity.this,
							item);
					dialog.show();
				}
			}
		}
	};


	private void updateCustomerImageGallery() {
		second_indicator_layout.removeAllViews();
		arrSecondIndicatorViews.clear();

		for (int i = 0 ; i < arr_jiukehu_adverts.size(); i++) {
			STAdvertImage image = arr_jiukehu_adverts.get(i);

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

					onClickedCustomerBanner((Long)v.getTag());
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


		for (int i = 0 ; i < arr_jiukehu_relatives.size(); i++) {
			STRelative relative = arr_jiukehu_relatives.get(i);

			RelativeLayout parent_layout = new RelativeLayout(second_advert_pager.getContext());
			ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
			parent_layout.setLayoutParams(params);

			RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_qinrenshuju_layout, null);
			RelativeLayout.LayoutParams item_params = (RelativeLayout.LayoutParams)item_layout.getLayoutParams();
			if (item_params == null) {
				item_params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
			}
			item_params.addRule(RelativeLayout.CENTER_IN_PARENT);
			item_layout.setLayoutParams(item_params);

			ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

			TextView txt_name = (TextView)item_layout.findViewById(R.id.txt_name);
			txt_name.setText(relative.relative + "：" + relative.name);
			TextView txt_area = (TextView)item_layout.findViewById(R.id.txt_area);
			txt_area.setText(relative.area_no);
			TextView txt_birthday = (TextView)item_layout.findViewById(R.id.txt_birthday);
			txt_birthday.setText(relative.birthday);
			TextView txt_deathday = (TextView)item_layout.findViewById(R.id.txt_deathday);
			txt_deathday.setText(relative.deathday);

			ImageButton btnItem = (ImageButton)item_layout.findViewById(R.id.btn_item);
			btnItem.setTag(relative.uid);
			btnItem.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					if (Calendar.getInstance().getTimeInMillis() - touch_up_time < TOUCH_UP_INTERVAL)
						return;

					onClickedCustomerRelative((Long) v.getTag());
				}
			});

			parent_layout.addView(item_layout);

			second_advert_pager.addView(parent_layout);


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


	private void onClickedCustomerBanner(long activity_id) {
		Bundle bundle = new Bundle();
		bundle.putLong(YuanQuHuoDongXiangQingActivity.EXTRA_ACTIVITY_ID, activity_id);
		bundle.putBoolean(YuanQuHuoDongXiangQingActivity.EXTRA_SHOPCART, true);

		pushNewActivityAnimated(YuanQuHuoDongXiangQingActivity.class, bundle);
	}


	private void onClickedCustomerRelative(long relative_id) {
		// Do nothing
	}


	/**
	 * FangKe actions
	 */
	private void onClickedUser() {
		pushNewActivityAnimated(ZhengJianActivity.class);
	}

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
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(JiuKeHuShouYeActivity.this)
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
