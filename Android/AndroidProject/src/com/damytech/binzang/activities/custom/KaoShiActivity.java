package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 21:51
 * File Name : KaoShiActivity
 */
public class KaoShiActivity extends SuperTabActivity {
	private List<Fragment> arrFrames = new ArrayList<Fragment>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_kaoshi);
	}

	@Override
	protected void initializeActivity() {
		arrFrames.add(new KaoShi_GongWuYuanTabFrame());
		arrFrames.add(new KaoShi_XuexiaoTabFrame());
		arrFrames.add(new KaoShi_ZhengZhaoTabFrame());

		initTabContent(R.id.tab_content_layout, R.id.tab_selector_layout, arrFrames);
	}
}
