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
 * Date : 2015-04-10
 * Time : 10:59
 * File Name : ShouHouFuWuActivity
 */
public class ShouHouFuWuActivity extends SuperTabActivity {
	private List<Fragment> arrFrames = new ArrayList<Fragment>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_shouhoufuwu);
	}

	@Override
	protected void initializeActivity() {
		arrFrames.add(new ShouHouFuWu_FuWuLeiTabFrame());
		arrFrames.add(new ShouHouFuWu_JiBaiYongPinTabFrame());

		initTabContent(R.id.tab_content_layout, R.id.tab_selector_layout, arrFrames);
	}
}
