package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.binzang.dialogs.preset.CommonSelectSingleDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.WheelPicker.OnWheelChangedListener;
import com.damytech.preset_controls.WheelPicker.WheelAdapter;
import com.damytech.preset_controls.WheelPicker.WheelView;
import com.damytech.structure.custom.STTombStoneArea;
import com.damytech.structure.custom.STTombStoneIndex;
import com.damytech.structure.custom.STTombStonePart;
import com.damytech.structure.custom.STTombStoneRow;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-20
 * Time : 10:02
 * File Name : LingYuanYuLiuActivity_TabFrame4
 */
public class LingYuanYuLiuActivity_TabFrame4 extends SuperTabActivity.TabFrame {
	private TextView txtArea = null;
	private ImageButton btnArea = null;
	private ImageView imgArea = null;

	private WheelView partView = null;
	private WheelView rowView = null;
	private WheelView indexView = null;

	private WheelAdapter partAdapter = null;
	private WheelAdapter rowAdapter = null;
	private WheelAdapter indexAdapter = null;

	private ArrayList<STTombStoneArea> arrAreas = new ArrayList<STTombStoneArea>();

	private ArrayList<String> arrPartNames = new ArrayList<String>();
	private ArrayList<String> arrRowNames = new ArrayList<String>();
	private ArrayList<String> arrIndexNames = new ArrayList<String>();

	private Button btnPrev = null, btnConfirm = null;


	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);

		View contentView = inflater.inflate(R.layout.activity_lingyuanyuliu_tab4, container, false);
		initResolution(contentView);
		initControls(contentView);

		return contentView;
	}


	private void initControls(View parentView) {
		final LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.setTitle("牌位预留");

		btnPrev = (Button)parentView.findViewById(R.id.btn_prev);
		btnPrev.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedPrev();
			}
		});

		btnConfirm = (Button)parentView.findViewById(R.id.btn_next);
		btnConfirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedConfirm();
			}
		});


		txtArea = (TextView)parentView.findViewById(R.id.txt_area);
		btnArea = (ImageButton)parentView.findViewById(R.id.btn_area);
		btnArea.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedArea();
			}
		});

		imgArea = (ImageView)parentView.findViewById(R.id.img_area);

		partView = (WheelView)parentView.findViewById(R.id.part_view);
		rowView = (WheelView)parentView.findViewById(R.id.row_view);
		indexView = (WheelView)parentView.findViewById(R.id.index_view);

		arrPartNames.add("未定");
		arrRowNames.add("未定");
		arrIndexNames.add("未定");

		partAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrPartNames.size(); }
			@Override
			public String getItem(int index) { return arrPartNames.get(index); }
			@Override
			public int getMaximumLength() { return arrPartNames.size(); }
		};

		rowAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrRowNames.size(); }
			@Override
			public String getItem(int index) { return arrRowNames.get(index); }
			@Override
			public int getMaximumLength() { return arrRowNames.size(); }
		};

		indexAdapter = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrIndexNames.size(); }
			@Override
			public String getItem(int index) { return arrIndexNames.get(index); }
			@Override
			public int getMaximumLength() { return arrIndexNames.size(); }
		};

		partView.setAdapter(partAdapter);
		rowView.setAdapter(rowAdapter);
		indexView.setAdapter(indexAdapter);

		partView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				partChanged();
			}
		});
		rowView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				rowChanged();
			}
		});
		indexView.addChangingListener(new OnWheelChangedListener() {
			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				indexChanged();
			}
		});
	}


	@Override
	public void onResume() {
		super.onResume();

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;

		startProgress();
		CommManager.getTombStonePlaces(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
				yuliuActivity.area_id,
				comm_delegate);
	}

	private void onClickedPrev() {
		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.tab_adapter.changeTab(0);
	}


	private CommDelegate comm_delegate = new CommDelegate() {
		@Override
		public void getTombStonePlacesResult(int retcode, String retmsg, ArrayList<STTombStoneArea> arrTombStoneAreas) {
			super.getTombStonePlacesResult(retcode, retmsg, arrTombStoneAreas);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				arrAreas.clear();
				arrAreas.addAll(arrTombStoneAreas);

				initializeUI();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}


		@Override
		public void reserveTombPlaceResult(int retcode, String retmsg) {
			super.reserveTombPlaceResult(retcode, retmsg);
			stopProgress();

			if (retcode == 0) {
				ToastUtility.showToast(parentActivity, "保留成功");
				parentActivity.popOverCurActivityAnimated();
			} else {
				ToastUtility.showToast(parentActivity, retmsg);
			}
		}

	};


	private void initializeUI() {
		if (arrAreas.size() == 0 || arrAreas.get(0).parts.size() == 0 || arrAreas.get(0).parts.get(0).rows.size() == 0 || arrAreas.get(0).parts.get(0).rows.get(0).indexes.size() == 0) {
			arrPartNames.clear();
			arrRowNames.clear();
			arrIndexNames.clear();
			arrPartNames.add("未定");
			arrRowNames.add("未定");
			arrIndexNames.add("未定");

			partView.setCurrentItem(0);
			rowView.setCurrentItem(0);
			indexView.setCurrentItem(0);

			partView.forceInvalidate();
			rowView.forceInvalidate();
			indexView.forceInvalidate();
			return;
		}

		STTombStoneArea firstArea = arrAreas.get(0);
		STTombStonePart firstPart = firstArea.parts.get(0);
		STTombStoneRow firstRow = firstPart.rows.get(0);
		STTombStoneIndex firstIndex = firstRow.indexes.get(0);

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;

		yuliuActivity.tomb_stone_area_id = firstArea.uid;
		yuliuActivity.tomb_stone_part_id = firstPart.uid;
		yuliuActivity.tomb_stone_row_id = firstRow.uid;
		yuliuActivity.tomb_stone_index_id = firstIndex.uid;


		txtArea.setText(firstArea.name);
		BitmapUtility.setImageWithImageLoader(imgArea, firstArea.image_url, parentActivity.loader_options);

		arrPartNames.clear();
		arrRowNames.clear();
		arrIndexNames.clear();

		for (int i = 0; i < firstArea.parts.size(); i++) {
			arrPartNames.add("" + firstArea.parts.get(i).name);
		}

		for (int i = 0; i < firstPart.rows.size(); i++) {
			arrRowNames.add("" + firstPart.rows.get(i).uid);
		}

		for (int i = 0; i < firstRow.indexes.size(); i++) {
			arrIndexNames.add("" + firstRow.indexes.get(i).uid);
		}

		partView.setCurrentItem(0);
		rowView.setCurrentItem(0);
		indexView.setCurrentItem(0);

		partView.forceInvalidate();
		rowView.forceInvalidate();
		indexView.forceInvalidate();
	}


	private void onClickedArea() {
		ArrayList<String> arrAreaNames = new ArrayList<String>();
		for (int i = 0; i < arrAreas.size(); i++) {
			arrAreaNames.add(arrAreas.get(i).name);
		}

		CommonSelectSingleDialog dialog = new CommonSelectSingleDialog(parentActivity);
		dialog.initItemData(arrAreaNames);
		dialog.setDialogTitle("请选择园区");
		dialog.delegate = new CommonSelectSingleDialog.SelectItemListener() {
			@Override
			public void onItemClicked(String item_data, int index) {
				txtArea.setText(item_data);
				STTombStoneArea area = arrAreas.get(index);

				LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
				yuliuActivity.tomb_stone_area_id = area.uid;
				areaChanged();
			}
		};
		dialog.show();
	}



	private STTombStoneArea getCurrentArea() {
		STTombStoneArea area = null;

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		for (int i = 0; i < arrAreas.size(); i++) {
			STTombStoneArea area_item = arrAreas.get(i);
			if (area_item.uid == yuliuActivity.tomb_stone_area_id) {
				area = area_item;
				break;
			}
		}

		return area;
	}


	private STTombStonePart getCurrentPart() {
		STTombStonePart part = null;

		try {
			STTombStoneArea area = getCurrentArea();
			if (area != null) {
				int index = partView.getCurrentItem();
				part = area.parts.get(index);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return part;
	}


	private STTombStoneRow getCurrentRow() {
		STTombStoneRow row = null;

		try {
			STTombStonePart part = getCurrentPart();
			if (part != null) {
				int index = rowView.getCurrentItem();
				row = part.rows.get(index);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return row;
	}


	private STTombStoneIndex getCurrentIndex() {
		STTombStoneIndex index = null;

		try {
			STTombStoneRow row = getCurrentRow();
			if (row != null) {
				int cur_index = indexView.getCurrentItem();
				index = row.indexes.get(cur_index);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return index;
	}



	private void areaChanged() {
		STTombStoneArea area = getCurrentArea();
		if (area == null)
			return;

		arrPartNames.clear();
		arrRowNames.clear();
		arrIndexNames.clear();

		for (int i = 0; i < area.parts.size(); i++) {
			arrPartNames.add("" + area.parts.get(i).name);
		}

		STTombStonePart tombStonePart = area.parts.get(0);
		STTombStoneRow tombStoneRow = tombStonePart.rows.get(0);
		STTombStoneIndex tombStoneIndex = tombStoneRow.indexes.get(0);

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.tomb_stone_part_id = tombStonePart.uid;
		yuliuActivity.tomb_stone_row_id = tombStoneRow.uid;
		yuliuActivity.tomb_stone_index_id = tombStoneIndex.uid;

		for (int i = 0; i < tombStonePart.rows.size(); i++) {
			arrRowNames.add("" + tombStonePart.rows.get(i).uid);
		}

		for (int i = 0; i < tombStoneRow.indexes.size(); i++) {
			arrIndexNames.add("" + tombStoneRow.indexes.get(i).uid);
		}


		partView.setCurrentItem(0);
		rowView.setCurrentItem(0);
		indexView.setCurrentItem(0);

		partView.forceInvalidate();
		rowView.forceInvalidate();
		indexView.forceInvalidate();
	}


	private void partChanged() {
		STTombStonePart part = getCurrentPart();
		if (part == null)
			return;

		arrRowNames.clear();
		arrIndexNames.clear();

		STTombStoneRow row = part.rows.get(0);
		STTombStoneIndex index = row.indexes.get(0);

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.tomb_stone_part_id = part.uid;
		yuliuActivity.tomb_stone_row_id = row.uid;
		yuliuActivity.tomb_stone_index_id = index.uid;

		for (int i = 0; i < part.rows.size(); i++) {
			arrRowNames.add("" + part.rows.get(i).uid);
		}

		for (int i = 0; i < row.indexes.size(); i++) {
			arrIndexNames.add("" + row.indexes.get(i).uid);
		}


		rowView.setCurrentItem(0);
		indexView.setCurrentItem(0);

		rowView.forceInvalidate();
		indexView.forceInvalidate();
	}


	private void rowChanged() {
		STTombStoneRow row = getCurrentRow();
		if (row == null)
			return;


		arrIndexNames.clear();

		STTombStoneIndex index = row.indexes.get(0);

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.tomb_stone_row_id = row.uid;
		yuliuActivity.tomb_stone_index_id = index.uid;

		for (int i = 0; i < row.indexes.size(); i++) {
			arrIndexNames.add("" + row.indexes.get(i).uid);
		}


		indexView.setCurrentItem(0);
		indexView.forceInvalidate();
	}


	private void indexChanged() {
		STTombStoneIndex index = getCurrentIndex();
		if (index == null)
			return;

		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;
		yuliuActivity.tomb_tablet_id = index.tablet_id;
	}


	private void onClickedConfirm() {
		LingYuanYuLiuActivity yuliuActivity = (LingYuanYuLiuActivity)parentActivity;

		if(yuliuActivity.tomb_tablet_id <= 0) {
			ToastUtility.showToast(parentActivity, "请您选择牌位...");
			return;
		}

		startProgress();
		CommManager.reserveTombPlace(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
				yuliuActivity.customer_name,
				yuliuActivity.customer_phone,
				yuliuActivity.death1,
				yuliuActivity.comfort1,
				yuliuActivity.death2,
				yuliuActivity.comfort2,
				yuliuActivity.area_id,
				yuliuActivity.tomb_site_id,
				yuliuActivity.tomb_tablet_id,
				comm_delegate);
	}

}
