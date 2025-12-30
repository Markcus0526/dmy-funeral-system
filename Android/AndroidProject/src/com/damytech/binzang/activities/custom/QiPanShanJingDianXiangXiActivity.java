package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.structure.custom.STMtQiPanView;
import com.damytech.utils.AppUtility;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by Personal on 2015/4/13.
 */
public class QiPanShanJingDianXiangXiActivity extends SuperActivity {
	public static final String EXTRA_QIPAN_ID = "qipan_id";

	private long qipan_id = 0;
	private STMtQiPanView view_detail = null;

	private TextView txtAddr = null;
	private TextView txtPhone = null;
	private WebContentView webIntro = null;
	private ImageView imageIntro = null;
	private ImageButton btnAddr = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_qipanshanjingdianxiangxi);
	}

	@Override
	protected void initializeActivity() {
		qipan_id = getIntent().getLongExtra(EXTRA_QIPAN_ID, 0);

		txtAddr = (TextView)findViewById(R.id.txt_addr);
		txtPhone = (TextView)findViewById(R.id.txt_phone);
		txtPhone.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				CommonAlertDialog dialog = new CommonAlertDialog.Builder(QiPanShanJingDianXiangXiActivity.this)
						.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
						.message("确定要呼叫" + txtPhone.getText().toString() + "吗？")
						.positiveListener(new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								AppUtility.openDialPad(txtPhone.getText().toString(), QiPanShanJingDianXiangXiActivity.this);
							}
						})
						.build();
				dialog.show();
			}
		});
		webIntro = (WebContentView)findViewById(R.id.intro_view);
		imageIntro = (ImageView)findViewById(R.id.img_intro);

		btnAddr = (ImageButton)findViewById(R.id.btn_addr);
		btnAddr.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedAddr();
			}
		});

		loadData();
	}


	private void loadData() {
		startProgress();
		CommManager.getMtQiPanViewDetail(qipan_id, qipan_detail_delegate);
	}


	private CommDelegate qipan_detail_delegate = new CommDelegate() {
		@Override
		public void getMtQiPanViewDetailResult(int retcode, String retmsg, STMtQiPanView view_info) {
			super.getMtQiPanViewDetailResult(retcode, retmsg, view_info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setServiceData(view_info);
			} else {
				ToastUtility.showToast(QiPanShanJingDianXiangXiActivity.this, retmsg);
			}
		}
	};

	private void setServiceData(STMtQiPanView view_info) {
		view_detail = view_info;

		txtAddr.setText(view_info.address);
		txtPhone.setText(view_info.phone);
		webIntro.loadHTMLString(view_info.contents);
		BitmapUtility.setImageWithImageLoader(imageIntro, view_info.image_url, loader_options);
	}


	private void onClickedAddr() {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(QiPanShanJingDianXiangXiActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定要导航到景点吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						BNavigatorActivity.startNavigationActivity(QiPanShanJingDianXiangXiActivity.this,
								view_detail.lat,
								view_detail.lng);
					}
				})
				.build();
		dialog.show();
	}


}
