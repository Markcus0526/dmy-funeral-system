package com.damytech.binzang.activities.custom;

import android.graphics.Color;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.HorizontalPager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.structure.custom.STTombKnowledge;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 14:37
 * File Name : BinZangZhiShi_LingYuanZhiShiTabFrame
 */
public class BinZangZhiShi_LingYuanZhiShiTabFrame extends SuperTabActivity.TabFrame {
	private final int PAGER_PAGE_COUNT = 3;

	private final int page_header_text_sel_color = Color.rgb(0, 99, 44);
	private final int page_header_text_normal_color = Color.rgb(50, 50, 50);


	public int sel_index = 0;

	private HorizontalPager pager = null;

	private WebContentView web_view1 = null;
	private WebContentView web_view2 = null;
	private WebContentView web_view3 = null;

	private ImageView img_indicator = null;


	private TextView txtBuyTombFlow = null;
	private TextView txtPrecautions = null;
	private TextView txtBeryCustom = null;

	private ImageButton btnBuyTombFlow = null;
	private ImageButton btnPrecautions = null;
	private ImageButton btnBeryCustom = null;


	private boolean isInit = false;


	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_binzangzhishi_lingyunzhishi_tab, container, false);

		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		pager = (HorizontalPager)parentView.findViewById(R.id.hor_pager);

		web_view1 = (WebContentView)parentView.findViewById(R.id.web_view1);
		web_view2 = (WebContentView)parentView.findViewById(R.id.web_view2);
		web_view3 = (WebContentView)parentView.findViewById(R.id.web_view3);

		img_indicator = (ImageView)parentView.findViewById(R.id.img_tab_indicator);

		RelativeLayout content_view1 = (RelativeLayout)parentView.findViewById(R.id.tab_content1);
		RelativeLayout content_view2 = (RelativeLayout)parentView.findViewById(R.id.tab_content2);
		RelativeLayout content_view3 = (RelativeLayout)parentView.findViewById(R.id.tab_content3);

		ViewGroup tab_content_layout = (ViewGroup)content_view1.getParent();
		tab_content_layout.removeView(content_view1);
		pager.addView(content_view1);

		tab_content_layout = (ViewGroup)content_view2.getParent();
		tab_content_layout.removeView(content_view2);
		pager.addView(content_view2);

		tab_content_layout = (ViewGroup)content_view3.getParent();
		tab_content_layout.removeView(content_view3);
		pager.addView(content_view3);

		txtBuyTombFlow = (TextView)parentView.findViewById(R.id.txt_goumuliucheng);
		txtPrecautions = (TextView)parentView.findViewById(R.id.txt_zhuyishixiang);
		txtBeryCustom = (TextView)parentView.findViewById(R.id.txt_luozangxisu);


		pager.setCurrentScreen(sel_index, false);

		correctIndicator(sel_index);
		correctTextColor(sel_index);

		btnBuyTombFlow = (ImageButton)parentView.findViewById(R.id.btn_goumuliucheng);
		btnPrecautions = (ImageButton) parentView.findViewById(R.id.btn_zhuyishixiang);
		btnBeryCustom = (ImageButton)parentView.findViewById(R.id.btn_luozangxisu);

		btnBuyTombFlow.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				pager.setCurrentScreen(0, true);
			}
		});
		btnPrecautions.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				pager.setCurrentScreen(1, true);
			}
		});
		btnBeryCustom.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				pager.setCurrentScreen(2, true);
			}
		});

		pager.setScrollChangeListener(new HorizontalPager.OnHorScrolledListener() {
			@Override
			public void onScrolled() {
				int pager_width = pager.getWidth();
				int scr_width = ResolutionUtility.getScreenSize(parentActivity.getApplicationContext()).x;

				if (pager_width != scr_width)
					return;

				int scroll_x = pager.getScrollX();
				int index = 0;
				for (int i = 0; i < PAGER_PAGE_COUNT; i++) {
					if (scroll_x >= i * pager_width - pager_width / 2 &&
							scroll_x < i * pager_width + pager_width / 2) {
						index = i;
						break;
					}
				}

				correctIndicatorWithScrollX(scroll_x);
				correctTextColor(index);
			}
		});
	}


	@Override
	public void onResume() {
		super.onResume();

		if (!isInit)
			loadData();
	}


	private void loadData() {
		startProgress();
		CommManager.getTombKnowledge(lingyuan_knowledge_delegate);
	}

	private CommDelegate lingyuan_knowledge_delegate = new CommDelegate() {
		@Override
		public void getTombKnowledgeResult(int retcode, String retmsg, STTombKnowledge info) {
			super.getTombKnowledgeResult(retcode, retmsg, info);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setContents(info);
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};

	private void setContents(STTombKnowledge info) {
		web_view1.loadHTMLString(info.buy_tomb_flow);
		web_view2.loadHTMLString(info.precaution);
		web_view3.loadHTMLString(info.bury_custom);

		if (!isInit)
			isInit = true;
	}

	private void correctIndicator(int index) {
		int nBaseWidth = ResolutionUtility.getBaseWidth() / PAGER_PAGE_COUNT;
		int nCurWidth = ResolutionUtility.getScreenSize(parentActivity.getApplicationContext()).x / PAGER_PAGE_COUNT;

		RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams)img_indicator.getLayoutParams();
		params.leftMargin = nCurWidth * index;

		img_indicator.setLayoutParams(params);
		img_indicator.setTag(R.string.TAG_KEY_MARGINLEFT, "" + nBaseWidth * index);
	}

	private void correctIndicatorWithScrollX(int nXPos) {
		int nBaseWidth = ResolutionUtility.getBaseWidth() / PAGER_PAGE_COUNT;
		int nScrWidth = ResolutionUtility.getScreenSize(parentActivity.getApplicationContext()).x;

		RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams)img_indicator.getLayoutParams();
		params.leftMargin = nXPos * img_indicator.getWidth() / nScrWidth;

		img_indicator.setLayoutParams(params);
		img_indicator.setTag(R.string.TAG_KEY_MARGINLEFT, "" + nXPos * nBaseWidth / nScrWidth);
	}


	private void correctTextColor(int index) {
		if (index == 0) {
			txtBuyTombFlow.setTextColor(page_header_text_sel_color);
			txtPrecautions.setTextColor(page_header_text_normal_color);
			txtBeryCustom.setTextColor(page_header_text_normal_color);
		} else if (index == 1) {
			txtBuyTombFlow.setTextColor(page_header_text_normal_color);
			txtPrecautions.setTextColor(page_header_text_sel_color);
			txtBeryCustom.setTextColor(page_header_text_normal_color);
		} else if (index == 2) {
			txtBuyTombFlow.setTextColor(page_header_text_normal_color);
			txtPrecautions.setTextColor(page_header_text_normal_color);
			txtBeryCustom.setTextColor(page_header_text_sel_color);
		}
	}

}

