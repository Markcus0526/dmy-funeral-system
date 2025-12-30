package com.damytech.binzang.activities.preset;

import android.app.Activity;
import android.graphics.Point;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTransaction;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import com.damytech.binzang.R;
import com.damytech.utils.ResolutionUtility;

import java.util.List;

/**
 * Created by KimHM on 2014/12/11.
 */
public abstract class SuperTabActivity extends SuperActivity {
	/**
	 * Tab concerned variables. Used for the tab activity
	 */
	public static final String EXTRA_TAB_INDEX = "default_tab_index";

	public boolean needAnimation = false;

	public RadioGroup radio_grp				= null;
	public List<Fragment> fragments_array		= null;

	private int tab_content_id = 0;
	private int tab_selector_id = 0;

	public FragmentTabAdapter tab_adapter = null;

	/**
	 * Method to initialize tab content, when need to use tab control
	 * Before call this method, must set frame list and radio group control
	 * This method must be called in onCreate() method.
	 *
	 * @param tab_content_id		The resource id of the tab content. FrameLayout control id
	 * @param tab_selector_id		The resource id of the tab select part. RadioGroup control id
	 * @param fragments_array		Array of the fragments to show as tab content
	 */
	public void initTabContent(int tab_content_id, int tab_selector_id, List<Fragment> fragments_array) {
		this.tab_content_id = tab_content_id;
		this.tab_selector_id = tab_selector_id;

		View tmpView = null;

		// Check radio group
		tmpView = findViewById(tab_selector_id);
		if (tmpView == null) {
			Log.d("SuperActivity.Debug", "Radio group resource id is invalid(No control)");
			return;
		} else if (!(tmpView instanceof RadioGroup)) {
			Log.d("SuperActivity.Debug", "Radio group resource id is invalid(Not radio group control)");
			return;
		} else {
			radio_grp = (RadioGroup)tmpView;
		}


		// Check frame layout
		tmpView = findViewById(tab_content_id);
		if (tmpView == null) {
			Log.d("SuperActivity.Debug", "FrameLayout resource id is invalid(No control)");
			return;
		} else if (!(tmpView instanceof FrameLayout)) {
			Log.d("SuperActivity.Debug", "FrameLayout resource id is invalid(Not frame layout)");
			return;
		}

		this.fragments_array = fragments_array;

		tab_adapter = new FragmentTabAdapter(this, fragments_array, tab_content_id, radio_grp);

		// Set default tab
		int default_tab_index = getIntent().getIntExtra(EXTRA_TAB_INDEX, 0);
		View childView = radio_grp.getChildAt(default_tab_index);
		RadioButton radioBtn = (RadioButton)childView;
		radioBtn.setChecked(true);
	}


	public void setOnRgsExtraCheckedChangedListener(OnRgsExtraCheckedChangedListener listener) {
		tab_adapter.setOnRgsExtraCheckedChangedListener(listener);
	}


	@Override
	public void checkAvailability() throws Exception {
		if (radio_grp == null || fragments_array == null || fragments_array.size() == 0) {
			throw new Exception("Radio group control or fragments array is not initialized. See <initTabContent> method.");
		}
	}

	public class FragmentTabAdapter implements RadioGroup.OnCheckedChangeListener {
		private List<Fragment> fragments;				// 一个tab页面对应一个Fragment
		private RadioGroup rgs;							// 用于切换tab
		private FragmentActivity fragmentActivity;		// Fragment所属的Activity
		private int fragmentContentId;					// Activity中所要被替换的区域的id

		private int currentTab;							// 当前Tab页面索引

		private OnRgsExtraCheckedChangedListener onRgsExtraCheckedChangedListener; // 用于让调用者在切换tab时候增加新的功能


		public FragmentTabAdapter(FragmentActivity fragmentActivity, List<Fragment> fragments, int fragmentContentId, RadioGroup rgs) {
			this.fragments = fragments;
			this.rgs = rgs;
			this.fragmentActivity = fragmentActivity;
			this.fragmentContentId = fragmentContentId;

			// 默认显示第一页
			FragmentTransaction ft = fragmentActivity.getSupportFragmentManager().beginTransaction();
			ft.add(fragmentContentId, fragments.get(0));
			ft.commit();

			rgs.setOnCheckedChangeListener(this);
		}


		public void changeTab(int nIndex) {
			int nCount = radio_grp.getChildCount();

			if (nCount <= nIndex || nIndex < 0)
				return;

			onCheckedChanged(radio_grp, radio_grp.getChildAt(nIndex).getId());
		}


		@Override
		public void onCheckedChanged(RadioGroup radioGroup, int checkedId) {
			for (int i = 0; i < rgs.getChildCount(); i++) {
				if (rgs.getChildAt(i).getId() == checkedId) {
					Fragment fragment = fragments.get(i);
					FragmentTransaction ft = obtainFragmentTransaction(i);

					getCurrentFragment().onPause(); // 暂停当前tab

					if (fragment.isAdded()) {
						fragment.onResume(); // 启动目标tab的onResume()
					} else {
						ft.add(fragmentContentId, fragment);
					}

					showTab(i); // 显示目标tab
					ft.commit();

					// 如果设置了切换tab额外功能功能接口
					if (null != onRgsExtraCheckedChangedListener) {
						onRgsExtraCheckedChangedListener.OnRgsExtraCheckedChanged(radioGroup, checkedId, i);
					}
				}
			}
		}


		/**
		 * 切换tab
		 * @param idx
		 */
		public void showTab(int idx) {
			for (int i = 0; i < fragments.size(); i++) {
				Fragment fragment = fragments.get(i);
				FragmentTransaction ft = obtainFragmentTransaction(idx);

				if (idx == i) {
					ft.show(fragment);
				} else {
					ft.hide(fragment);
				}

				ft.commit();
			}

			currentTab = idx; // 更新目标tab为当前tab
		}


		/**
		 * 获取一个带动画的FragmentTransaction
		 * @param index
		 * @return
		 */
		private FragmentTransaction obtainFragmentTransaction(int index) {
			FragmentTransaction ft = fragmentActivity.getSupportFragmentManager().beginTransaction();


			/**
			 * Code snippet for the tab transition animation
			 */

			if (needAnimation) {
				// Set transition animation
				if (index > currentTab) {
					ft.setCustomAnimations(R.anim.right_in, R.anim.left_out);
				} else {
					ft.setCustomAnimations(R.anim.left_in, R.anim.right_out);
				}
			}

			return ft;
		}


		public int getCurrentTab() {
			return currentTab;
		}


		public Fragment getCurrentFragment() {
			return fragments.get(currentTab);
		}


		public OnRgsExtraCheckedChangedListener getOnRgsExtraCheckedChangedListener() {
			return onRgsExtraCheckedChangedListener;
		}


		public void setOnRgsExtraCheckedChangedListener(OnRgsExtraCheckedChangedListener onRgsExtraCheckedChangedListener) {
			this.onRgsExtraCheckedChangedListener = onRgsExtraCheckedChangedListener;
		}
	}


	public static class OnRgsExtraCheckedChangedListener {
		public void OnRgsExtraCheckedChanged(RadioGroup radioGroup, int checkedId, int index) {}
	}


	/**
	 * Class for the individual tab instance
	 */
	public static class TabFrame extends Fragment {
		public SuperTabActivity parentActivity = null;

		@Override
		public View onCreateView(LayoutInflater inflater,
								 ViewGroup container,
								 Bundle savedInstanceState) {
			View view = super.onCreateView(inflater, container, savedInstanceState);
			parentActivity = (SuperTabActivity)getActivity();
			return view;
		}

		public void initResolution(View parentView) {
			Point ptScreenSize = ResolutionUtility.getScreenSize(getActivity().getApplicationContext());
			ResolutionUtility.instance.iterateChild(parentView, ptScreenSize.x, ptScreenSize.y);
		}

		public void startProgress(String szMsg) {
			SuperActivity super_activity = null;
			if (parentActivity == null) {
				Activity activity = getActivity();
				if (activity instanceof SuperActivity) {
					super_activity = (SuperActivity)activity;
				}
			} else {
				super_activity = parentActivity;
			}

			if (super_activity != null)
				super_activity.startProgress(szMsg);
		}

		public void startProgress() {
			TabFrame.this.startProgress("");
		}

		public void stopProgress() {
			SuperActivity super_activity = null;
			if (parentActivity == null) {
				Activity activity = getActivity();
				if (activity instanceof SuperActivity) {
					super_activity = (SuperActivity)activity;
				}
			} else {
				super_activity = parentActivity;
			}

			if (super_activity != null)
				super_activity.stopProgress();
		}
	}


}
