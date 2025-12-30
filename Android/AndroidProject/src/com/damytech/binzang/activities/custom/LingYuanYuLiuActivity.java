package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-20
 * Time : 09:59
 * File Name : LingYuanYuLiuActivity
 */
public class LingYuanYuLiuActivity extends SuperTabActivity {
	public List<Fragment> arrFrames = new ArrayList<Fragment>();

	// Tab1
	public String customer_name = "", customer_phone = "";
	public String death1 = "", comfort1 = "", death2 = "", comfort2 = "";

	// Tab2
	public long area_id = 0;
	public long area_type = 0;

	// Tab3
	public long tomb_site_id = 0;
	public long tomb_tablet_id = 0;

	// Tab4
	public long tomb_stone_area_id = 0;
	public long tomb_stone_part_id = 0;
	public long tomb_stone_row_id = 0;
	public long tomb_stone_index_id = 0;

	private TextView txtTiTle = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_lingyuanyuliu);
	}


	@Override
	protected void initializeActivity() {
		//arrFrames.add(new LingYuanYuLiuActivity_TabFrame1());
		arrFrames.add(new LingYuanYuLiuActivity_TabFrame2());
		arrFrames.add(new LingYuanYuLiuActivity_TabFrame3());
		arrFrames.add(new LingYuanYuLiuActivity_TabFrame4());

		initTabContent(R.id.tab_content_layout, R.id.tab_selector_layout, arrFrames);

		txtTiTle = (TextView)findViewById(R.id.txt_title);
	}


	@Override
	public void onClickedBack() {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(LingYuanYuLiuActivity.this)
				.message("确定要取消吗？")
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						LingYuanYuLiuActivity.super.onClickedBack();
					}
				})
				.build();
		dialog.show();
	}

	public void setTitle(String title)
	{
		txtTiTle.setText(title);
	}
}
