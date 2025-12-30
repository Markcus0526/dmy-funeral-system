package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:02
 * File Name : BinZangZhiShiActivity
 */
public class BinZangZhiShiActivity extends SuperTabActivity {
	public static final String EXTRA_BINZANG_XINWEN = "binzang_xinwen";

	private List<Fragment> arrFrames = new ArrayList<Fragment>();
	private int tabIndex = 0;

	private TextView txtTitle = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_binzangzhishi);
	}

	@Override
	protected void initializeActivity() {
		tabIndex = getIntent().getIntExtra(EXTRA_TAB_INDEX, 0);

		arrFrames.add(new BinZangZhiShi_YiTiaoLongTabFrame());
		arrFrames.add(new BinZangZhiShi_LingYuanZhiShiTabFrame());
		initTabContent(R.id.tab_content_layout, R.id.tab_selector_layout, arrFrames);

		txtTitle = (TextView)findViewById(R.id.txt_title);
		if(tabIndex == 0) {
			txtTitle.setText("一条龙服务");
		}
		else {
			txtTitle.setText("陵园知识");
		}
	}
}
