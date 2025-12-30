package com.damytech.binzang.activities.custom;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.activities.preset.SuperTabActivity;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 17:18
 * File Name : DingJinDanChaXunActivity_YuanGong
 */
public class ZiYouKeHuShangPinDingGouActivity extends SuperTabActivity {
	public static final int REQCODE_WAITING_DETAIL = 1;
	public static final int REQCODE_COMPLETED_DETAIL = 2;

	ArrayList<Fragment> arrFragments = new ArrayList<Fragment>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_ziyoukehushangpindinggou);
	}


	@Override
	protected void initializeActivity() {
		arrFragments.add(new ZiYouKeHuShangPinDingGouActivity_TabFrame1());
		arrFragments.add(new ZiYouKeHuShangPinDingGouActivity_TabFrame2());

		initTabContent(R.id.tab_content_layout, R.id.tab_selector_layout, arrFragments);
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);

		if (resultCode != SuperActivity.RESULT_OK)
			return;

		if (requestCode == REQCODE_WAITING_DETAIL) {
			long log_id = data.getLongExtra(ZiYouKeHuShangPinDingGouXiangXiActivity.EXTRA_LOG_ID, 0);
			ZiYouKeHuShangPinDingGouActivity_TabFrame1 frame1 = (ZiYouKeHuShangPinDingGouActivity_TabFrame1)arrFragments.get(0);
			frame1.updateReadMark(log_id);
		} else if (requestCode == REQCODE_COMPLETED_DETAIL) {
			long log_id = data.getLongExtra(ZiYouKeHuShangPinDingGouXiangXiActivity.EXTRA_LOG_ID, 0);
			ZiYouKeHuShangPinDingGouActivity_TabFrame2 frame2 = (ZiYouKeHuShangPinDingGouActivity_TabFrame2)arrFragments.get(1);
			frame2.updateReadMark(log_id);
		}
	}

}
