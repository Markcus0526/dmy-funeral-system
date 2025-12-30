package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:03
 * File Name : ShengHuoFuWuActivity
 */
public class ShengHuoFuWuActivity extends SuperActivity {
	private ImageButton btnMeiShi = null;
	private ImageButton btnJiuDian = null;
	private ImageButton btnChuXing = null;
	private ImageButton btnDianYingShiKeBiao = null;
	private ImageButton btnJingDian = null;
	private ImageButton btnKaoShi = null;
	private ImageButton btnYouXi = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_shenghuofuwu);
	}

	@Override
	protected void initializeActivity() {
		btnMeiShi = (ImageButton)findViewById(R.id.btn_food);
		btnJiuDian = (ImageButton)findViewById(R.id.btn_hotel);
		btnChuXing = (ImageButton)findViewById(R.id.btn_plane);
		btnDianYingShiKeBiao = (ImageButton)findViewById(R.id.btn_cinema);
		btnJingDian = (ImageButton)findViewById(R.id.btn_view);
		btnKaoShi = (ImageButton)findViewById(R.id.btn_test);
		btnYouXi = (ImageButton)findViewById(R.id.btn_game);

		btnMeiShi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedMeiShi();
			}
		});
		btnJiuDian.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedJiuDian();
			}
		});
		btnChuXing.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedChuXing();
			}
		});
		btnDianYingShiKeBiao.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedDianYingShiKeBiao();
			}
		});
		btnJingDian.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedJingDian();
			}
		});
		btnKaoShi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedKaoShi();
			}
		});
		btnYouXi.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedYouXi();
			}
		});
	}


	private void onClickedMeiShi() {
		pushNewActivityAnimated(MeiShiActivity.class);
	}

	private void onClickedJiuDian() {
		pushNewActivityAnimated(JiuDianActivity.class);
	}

	private void onClickedChuXing() {
		pushNewActivityAnimated(ChuXingActivity.class);
	}

	private void onClickedDianYingShiKeBiao() {
		pushNewActivityAnimated(DianYingShiKeBiaoActivity.class);
	}

	private void onClickedJingDian() {
		pushNewActivityAnimated(QiPanShanJingDianActivity.class);
	}

	private void onClickedKaoShi() {
		pushNewActivityAnimated(KaoShiActivity.class);
	}

	private void onClickedYouXi() {
		pushNewActivityAnimated(YouXiActivity.class);
	}


}
