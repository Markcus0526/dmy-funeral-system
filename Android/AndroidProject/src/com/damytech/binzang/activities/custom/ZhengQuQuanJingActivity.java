package com.damytech.binzang.activities.custom;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.CusImgMapView;
import com.damytech.structure.custom.STAreaPoint;
import com.damytech.utils.*;
import com.damytech.binzang.dialogs.custom.MapAreaPopupDlg;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 10:58
 * File Name : ZhengQuQuanJingActivity
 */
public class ZhengQuQuanJingActivity extends SuperActivity
{
	private TextView txtTitle = null;
	private Button btnReserveVisit = null;
	private Button btnChangeMap = null;
	private CusImgMapView imgMapView = null;
	private CusImgMapView imgMapViewFront = null;

	private static int nMapWidth = 1000;
	private static int nMapHeight = 667;

	private ArrayList<STAreaPoint> arrAreaList = null;

	private int mapType = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_zhengququanjing);
	}

	@Override
	protected void initializeActivity() {
		txtTitle = (TextView)findViewById(R.id.txt_title);

		btnReserveVisit = (Button)findViewById(R.id.btn_reserve_visit);
		btnReserveVisit.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedReserveVisit();
			}
		});

		btnChangeMap = (Button)findViewById(R.id.btn_change_map);
		btnChangeMap.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedChangeMap();
			}
		});

		imgMapView = (CusImgMapView)findViewById(R.id.img_mapview);
		imgMapView.setFitMode(CusImgMapView.FIT_HEIGHT);
		Bitmap bm = BitmapFactory.decodeResource(getResources(), R.drawable.map_image);
		imgMapView.setImageBitmap(bm);

		imgMapViewFront = (CusImgMapView)findViewById(R.id.img_mapview_front);
		imgMapViewFront.setFitMode(CusImgMapView.FIT_HEIGHT);
		Bitmap bm_front = BitmapFactory.decodeResource(getResources(), R.drawable.map_image_front);
		imgMapViewFront.setImageBitmap(bm_front);

		// set map image size
		nMapWidth = bm.getWidth();
		nMapHeight = bm.getHeight();

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
				ToastUtility.showToast(ZhengQuQuanJingActivity.this, retmsg);
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
			float posX = (float)(data.x_rate * nMapWidth);
			float posY = (float)(data.y_rate * nMapHeight);
			if(data.type == 2)
				imgMapViewFront.addShape(data.name, data.type, posX, posY - 50, 50, data.uid);
			else
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

		imgMapViewFront.addOnImageMapClickedHandler(new CusImgMapView.OnImageMapClickedHandler() {
			@Override
			public void onImageMapClicked(long id) {
				// when the area is tapped, show the popup
				showPopupDialog(id);
			}
		});

		imgMapView.invalidate();
		imgMapViewFront.invalidate();
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
				// go to detail view of area
				Bundle bundle = new Bundle();
				bundle.putLong("area_id", uid);
				//pushNewActivityAnimated(YuanQuXiangQingActivity.class, bundle);
			}
		};
		MapAreaPopupDlg popupDlg = new MapAreaPopupDlg(ZhengQuQuanJingActivity.this);
		popupDlg.setDataInfo(info, delegate);
		popupDlg.show();
	}


	private void onClickedReserveVisit() {
		pushNewActivityAnimated(YuYueCanGuanActivity.class);
	}

	private void onClickedChangeMap() {
		if(mapType == 0) {
			imgMapView.setVisibility(View.GONE);
			imgMapViewFront.setVisibility(View.VISIBLE);
			mapType = 1;
			txtTitle.setText("前方全景");
		}
		else {
			imgMapView.setVisibility(View.VISIBLE);
			imgMapViewFront.setVisibility(View.GONE);
			mapType = 0;
			txtTitle.setText("整区全景");
		}

	}

}
