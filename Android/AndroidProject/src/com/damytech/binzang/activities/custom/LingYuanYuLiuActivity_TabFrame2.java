package com.damytech.binzang.activities.custom;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.custom.MapAreaPopupDlg;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.CusImgMapView;
import com.damytech.structure.custom.STAreaPoint;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-20
 * Time : 10:02
 * File Name : LingYuanYuLiuActivity_TabFrame2
 */
public class LingYuanYuLiuActivity_TabFrame2 extends SuperTabActivity.TabFrame {
	private CusImgMapView imgMapView = null;

	private static int nMapWidth = 1000;
	private static int nMapHeight = 667;

	private ArrayList<STAreaPoint> arrAreaList = null;
	private Button btnPrev = null;


	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_lingyuanyuliu_tab2, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		imgMapView = (CusImgMapView)parentView.findViewById(R.id.cus_img_view);
		imgMapView.setFitMode(CusImgMapView.FIT_HEIGHT);
		Bitmap bm = BitmapFactory.decodeResource(getResources(), R.drawable.map_image);
		imgMapView.setImageBitmap(bm);

		// set map image size
		nMapWidth = bm.getWidth();
		nMapHeight = bm.getHeight();

		btnPrev = (Button)parentView.findViewById(R.id.btn_prev);
		btnPrev.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPrev();
			}
		});

		// get area data list
		startProgress();
		CommManager.getAreaPoints(area_points_delegate);
	}


	private CommDelegate area_points_delegate = new CommDelegate() {
		@Override
		public void getAreaPointsResult(int retcode, String retmsg, ArrayList<STAreaPoint> arrPoints) {
			super.getAreaPointsResult(retcode, retmsg, arrPoints);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrAreaList = arrPoints;
				addAreaPois();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}
	};



	/**
	 * Add & Draw area poi on custom image map
	 */
	private void addAreaPois()
	{
		for (STAreaPoint data : arrAreaList)
		{
			if(data.type == 2)		// 排除其他园区
				continue;
			float posX = (float)(data.x_rate * nMapWidth);
			float posY = (float)(data.y_rate * nMapHeight);
			imgMapView.addShape(data.name, data.type, posX, posY - 50, 50, data.uid);
		}

		// add a click handler to react when areas are tapped
		imgMapView.addOnImageMapClickedHandler(new CusImgMapView.OnImageMapClickedHandler() {
			@Override
			public void onImageMapClicked(long id) {
				// when the area is tapped, show the popup
				showPopupDialog(id);
			}
		});

		imgMapView.invalidate();
	}

	/**
	 * Show popup dialog of area
	 * @param id [in], area id
	 */
	private void showPopupDialog(long id)
	{
		// selected area point info
		STAreaPoint info = new STAreaPoint();
		for (STAreaPoint area : arrAreaList)
		{
			if (area.uid == id)
			{
				info = area;
				break;
			}
		}

		MapAreaPopupDlg.MapAreaPopupDelegate delegate = new MapAreaPopupDlg.MapAreaPopupDelegate() {
			@Override
			public void onClicked(long uid, int type) {
				onAreaSelected(uid, type);
			}
		};

		MapAreaPopupDlg popupDlg = new MapAreaPopupDlg(parentActivity);
		popupDlg.setDataInfo(info, delegate);
		popupDlg.show();
	}


	private void onAreaSelected(long uid, int type) {
		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.area_id = uid;
		yuliuActivity.area_type = type;
		if(type == 0)
			yuliuActivity.tab_adapter.changeTab(1);
		else
			yuliuActivity.tab_adapter.changeTab(2);
//		((LingYuanYuLiuActivity_TabFrame3)yuliuActivity.arrFrames.get(1)).loadTombList();
	}


	private void onClickedPrev() {
		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.tab_adapter.changeTab(0);
	}
}
