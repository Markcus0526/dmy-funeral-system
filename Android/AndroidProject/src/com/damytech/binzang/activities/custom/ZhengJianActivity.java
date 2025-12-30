package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.widget.ImageView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.misc.AppCommon;
import com.damytech.utils.BitmapUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 17:26
 * File Name : ZhengJianActivity
 */
public class ZhengJianActivity extends SuperActivity {
	private ImageView imgID = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_zhengjian);
	}

	@Override
	protected void initializeActivity() {
		imgID = (ImageView)findViewById(R.id.img_main);
		BitmapUtility.setImageWithImageLoader(imgID, AppCommon.loadIDImageUrl(getApplicationContext()), loader_options);
	}
}
