package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import com.baidu.lbsapi.auth.LBSAuthManagerListener;
import com.baidu.navisdk.BNaviEngineManager;
import com.baidu.navisdk.BaiduNaviManager;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.HorizontalPager;
import com.damytech.structure.custom.STAdvertImage;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 09:45
 * File Name : FangKeShouYeActivity
 */
public class FangKeShouYeActivity extends SuperActivity {
	private HorizontalPager advert_pager = null;

	private final int ADVERT_TIMER_INTERVAL = 3000;
	private Timer advert_timer = null;
	private TimerTask advert_timer_task = null;

	private ArrayList<STAdvertImage> arr_images = new ArrayList<STAdvertImage>();

	private ArrayList<ImageView> arrImageViews = new ArrayList<ImageView>();
	private LinearLayout indicator_layout = null;
	private int indicator_index = 0;

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

	private String TAG = "BinZang";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_fangkeshouye);
	}


	@Override
	protected void onResume() {
		super.onResume();

		if (arrImageViews.size() > 0)
			startAdvertTimer();
	}


	@Override
	protected void onPause() {
		super.onPause();
		stopAdvertTimer();
	}

	@Override
	protected void initializeActivity() {
		advert_pager = (HorizontalPager)findViewById(R.id.advert_pager);
		indicator_layout = (LinearLayout)findViewById(R.id.page_indicator_layout);

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
				onClickedUser();
			}
		});
		btnCompanyIntro.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedCompanyIntro();
			}
		});
		btnAreaBirdsEyeView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedAreaBirdsEyeView();
			}
		});
		btnAfterService.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedAfterService();
			}
		});
		btnOfficeIntro.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedOfficeIntro();
			}
		});
		btnAreaActivity.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedActivity();
			}
		});
		btnMapNav.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedMapNav();
			}
		});
		btnBeryKnowledge.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedBeryKnowledge();
			}
		});
		btnBeryNews.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedBeryNews();
			}
		});
		btnOneDragon.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedOneDragon();
			}
		});
		btnLifeService.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedLifeService();
			}
		});
		btnReserveVisit.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedReserveVisit();
			}
		});

		startProgress();
		CommManager.getBannerImages(comm_delegate);
	}

	private void onClickedUser() {
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
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(FangKeShouYeActivity.this)
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
		pushNewActivityAnimated(BinZangZhiShiActivity.class, bundle);
	}

	private void onClickedBeryNews() {
		Bundle bundle = new Bundle();
		pushNewActivityAnimated(BinZangXinWenActivity.class, bundle);
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


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getNavDestinationResult(int retcode, String retmsg, double lat, double lng) {
			super.getNavDestinationResult(retcode, retmsg, lat, lng);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				BNavigatorActivity.startNavigationActivity(FangKeShouYeActivity.this,
						lat,
						lng);
			} else {
				ToastUtility.showToast(FangKeShouYeActivity.this, retmsg);
			}
		}


		@Override
		public void getBannerImagesResult(int retcode, String retmsg, ArrayList<STAdvertImage> arrImages) {
			super.getBannerImagesResult(retcode, retmsg, arrImages);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				FangKeShouYeActivity.this.arr_images.clear();
				FangKeShouYeActivity.this.arr_images.addAll(arrImages);

				updateImageGallery();
			}
		}

	};




	private void updateImageGallery() {
		indicator_layout.removeAllViews();
		arrImageViews.clear();

		for (int i = 0 ; i < arr_images.size(); i++) {
			STAdvertImage image = arr_images.get(i);

			RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_guanggao_layout, null);
			ResolutionUtility.instance.iterateChild(item_layout, screen_size.x, screen_size.y);

			ImageView imgView = (ImageView)item_layout.findViewById(R.id.img_content);
			BitmapUtility.setImageWithImageLoader(imgView, image.image_url, loader_options);

			ImageButton btnItem = (ImageButton)item_layout.findViewById(R.id.btn_item);
			btnItem.setTag(image.uid);
			btnItem.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					onClickedBanner((Long)v.getTag());
				}
			});

			advert_pager.addView(item_layout);


			// Indicator layout
			RelativeLayout indicator_item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.item_yemiansuoyin_layout, null);
			ResolutionUtility.instance.iterateChild(indicator_item_layout, screen_size.x, screen_size.y);

			ImageView imgIndicator = (ImageView)indicator_item_layout.findViewById(R.id.img_circle);
			if (i == 0) {
				imgIndicator.setImageResource(R.drawable.green_circle);
			} else {
				imgIndicator.setImageResource(R.drawable.gray_circle);
			}
			arrImageViews.add(imgIndicator);

			indicator_layout.addView(indicator_item_layout);
		}


		advert_pager.setOnScreenSwitchListener(new HorizontalPager.OnScreenSwitchListener() {
			@Override
			public void onScreenSwitched(int screen) {
				arrImageViews.get(indicator_index).setImageResource(R.drawable.gray_circle);
				arrImageViews.get(screen).setImageResource(R.drawable.green_circle);
				indicator_index = screen;
			}
		});

		startAdvertTimer();
	}


	private void onClickedBanner(long advert_id) {
		Bundle bundle = new Bundle();
		bundle.putLong(SanLiuJingJieShaoActivity.EXTRA_VIEW_ID, advert_id);

		pushNewActivityAnimated(SanLiuJingJieShaoActivity.class, bundle);
	}


	private void startAdvertTimer() {
		stopAdvertTimer();

		advert_timer_task = new TimerTask() {
			@Override
			public void run() {
				runOnUiThread(new Runnable() {
					@Override
					public void run() {
						if (arrImageViews.size() == 0)
							return;

						int nCurScreen = advert_pager.getCurrentScreen();
						if (nCurScreen == arrImageViews.size() - 1)
							nCurScreen = 0;
						else
							nCurScreen++;

						advert_pager.setCurrentScreen(nCurScreen, true);
					}
				});
			}
		};

		advert_timer = new Timer();
		advert_timer.schedule(advert_timer_task, ADVERT_TIMER_INTERVAL, ADVERT_TIMER_INTERVAL);
	}


	private void stopAdvertTimer() {
		if (advert_timer_task != null) {
			advert_timer_task.cancel();
			advert_timer_task = null;
		}

		if (advert_timer != null) {
			advert_timer.cancel();
			advert_timer = null;
		}
	}
}
