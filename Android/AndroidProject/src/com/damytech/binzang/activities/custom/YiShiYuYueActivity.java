package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.structure.custom.STBuryService;
import com.damytech.structure.custom.STProduct;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 00:08
 * File Name : LingDaoShouYeActivity
 */
public class YiShiYuYueActivity extends SuperTabActivity {
	public final static String EXTRA_ISAGENT = "user_name_layout";
	public final static String EXTRA_NEED_BURYSERVICE = "need_bury";
	public final static String EXTRA_ACTIVITY_TITLE = "activity_title";

	private TextView txtTitle = null;
	public List<Fragment> arrFrames = new ArrayList<Fragment>();

	public boolean is_agent = false;
	public boolean need_bury_service = true;

	public long customer_id = -1;
	public long tomb_id = 0;
	public int is_deputyservice = 0;
	public String sel_time = "";
	public STBuryService buryService = null;
	public ArrayList<STProduct> arrSelectedProducts = new ArrayList<STProduct>();


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_yishiyuyue);
	}

	@Override
	protected void initializeActivity() {
		String szTitle = getIntent().getStringExtra(EXTRA_ACTIVITY_TITLE);

		txtTitle = (TextView)findViewById(R.id.txt_title);
		txtTitle.setText(szTitle);

		is_agent = getIntent().getBooleanExtra(EXTRA_ISAGENT, false);
		need_bury_service = getIntent().getBooleanExtra(EXTRA_NEED_BURYSERVICE, true);

		arrFrames.add(new YiShiYuYueActivity_TabFrame1());
		arrFrames.add(new YiShiYuYueActivity_TabFrame2());
		arrFrames.add(new YiShiYuYueActivity_TabFrame3());

		initTabContent(R.id.tab_frame_layout, R.id.tab_selector_layout, arrFrames);
	}


	@Override
	public void onClickedBack() {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(YiShiYuYueActivity.this)
				.message("确定要取消吗？")
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						YiShiYuYueActivity.super.onClickedBack();
					}
				})
				.build();
		dialog.show();
	}


}
