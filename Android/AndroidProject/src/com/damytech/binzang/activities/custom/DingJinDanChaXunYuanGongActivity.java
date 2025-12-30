package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 17:18
 * File Name : DingJinDanChaXunActivity_YuanGong
 */
public class DingJinDanChaXunYuanGongActivity extends SuperTabActivity {
	public static final String EXTRA_AIM_USER_ID = "aim_user_id";
	public static final String EXTRA_TITLE = "activity_title";
	public static final String EXTRA_BONUS_LOG = "bonus_log";

	public long aim_user_id = 0;

	private ArrayList<Fragment> arrFragments = new ArrayList<Fragment>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_dingjindanchaxun_yuangong);
	}


	@Override
	protected void initializeActivity() {
		aim_user_id = getIntent().getLongExtra(EXTRA_AIM_USER_ID, 0);

		TextView txtTitle = (TextView)findViewById(R.id.txt_title);
		txtTitle.setText(getIntent().getStringExtra(EXTRA_TITLE));

		Button btnMingXiBiao = (Button)findViewById(R.id.btn_mingxibiao);
		btnMingXiBiao.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedMingXiBiao();
			}
		});

		if (getIntent().getBooleanExtra(EXTRA_BONUS_LOG, false)) {
			btnMingXiBiao.setVisibility(View.VISIBLE);
		} else {
			btnMingXiBiao.setVisibility(View.GONE);
		}

		arrFragments.add(new DingJinDanChaXunYuanGongActivity_TabFrame1());
		arrFragments.add(new DingJinDanChaXunYuanGongActivity_TabFrame2());

		initTabContent(R.id.tab_content_layout, R.id.tab_selector_layout, arrFragments);
	}



	private void onClickedMingXiBiao() {
		pushNewActivityAnimated(JiangJinMingXiBiaoActivity.class);
	}


}
