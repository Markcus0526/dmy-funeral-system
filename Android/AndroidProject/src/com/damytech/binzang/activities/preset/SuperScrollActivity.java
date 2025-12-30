package com.damytech.binzang.activities.preset;

import android.widget.ScrollView;

/**
 * Created by KimHM on 2015-02-17.
 */
public abstract class SuperScrollActivity extends SuperActivity {
	protected ScrollView content_scrollview = null;

	@Override
	public void checkAvailability() throws Exception {
		if (content_scrollview == null) {
			throw new Exception("ScrollView cannot be null. Please see SuperScrollActivity.content_scrollview");
		}
	}

}
